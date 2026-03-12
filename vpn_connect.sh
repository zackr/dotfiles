#!/bin/bash

# --- Configuration ---
OP_ITEM="Broadcom"
PORTAL="portal.vpn.broadcom.com"

# 1. Ensure 1Password CLI is signed in
if ! op whoami >/dev/null 2>&1; then
    echo "1Password session expired. Please sign in..."
    eval $(op signin)
fi

# 2. Fetch Username and Password from 1Password
echo "Fetching credentials from 1Password..."
USERNAME=$(op item get "$OP_ITEM" --fields label=username)
PASSWORD=$(op item get "$OP_ITEM" --fields label=password --reveal)

if [[ -z "$USERNAME" || -z "$PASSWORD" ]]; then
    echo "Error: Could not retrieve username or password from 1Password."
    exit 1
fi

# 3. Run the GlobalProtect interaction
# We use an unquoted Heredoc (<<EOF) so Bash variables ($USERNAME, $PASSWORD) 
# are expanded before being passed to Expect.
expect <<EOF
set timeout 60

# Start GlobalProtect with the password flag
spawn globalprotect connect --portal "$PORTAL" --username "$USERNAME" --pass "$PASSWORD"

expect {
    "Choose MFA authentication method:" {
        send "1\r"
        exp_continue
    }
    "Enter the verification code shown in your authenticator app::" {
        # FETCH OTP AT THE LAST SECOND
        # [exec ...] runs a shell command from within Expect
        # We escape the $ in \$otp so Bash doesn't try to parse it
        set otp [exec op item get "$OP_ITEM" --otp]
        send "\$otp\r"
    }
    timeout {
        puts "\nError: Timed out waiting for GlobalProtect prompt.\n"
        exit 1
    }
}

# Wait for the command to finish and the daemon to take over
expect eof
EOF

