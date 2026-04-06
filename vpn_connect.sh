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
fetch_credentials() {
    USERNAME=$(op item get "$OP_ITEM" --fields label=username 2>/dev/null)
    PASSWORD=$(op item get "$OP_ITEM" --fields label=password --reveal 2>/dev/null)
    [[ -n "$USERNAME" && -n "$PASSWORD" ]]
}

echo "Fetching credentials from 1Password..."
if ! fetch_credentials; then
    echo "Session may be stale. Re-authenticating..."
    eval $(op signin)
    if ! fetch_credentials; then
        echo "Error: Could not retrieve username or password from 1Password."
        exit 1
    fi
fi

# 3. Run the GlobalProtect interaction
# We use a quoted heredoc (<<'EOF') so Bash does NOT expand variables.
# Instead, we pass values through environment variables to Expect/Tcl.
export GP_PORTAL="$PORTAL"
export GP_USERNAME="$USERNAME"
export GP_PASSWORD="$PASSWORD"
export GP_OP_ITEM="$OP_ITEM"

expect <<'EXPECT_SCRIPT'
set timeout 60

set portal $env(GP_PORTAL)
set username $env(GP_USERNAME)
set password $env(GP_PASSWORD)
set op_item $env(GP_OP_ITEM)

# NOTE: globalprotect connect does NOT support a --pass flag.
# The password must be provided interactively when prompted.
# If saved credentials are still valid, the CLI skips straight to MFA.
spawn globalprotect connect --portal $portal --username $username

set password_attempts 0

expect {
    -re "Username.*:" {
        send "\r"
        exp_continue
    }
    "Password:" {
        incr password_attempts
        if {$password_attempts > 1} {
            puts "\nError: Authentication failed. Check your credentials.\n"
            exit 1
        }
        send "$password\r"
        exp_continue
    }
    "Choose MFA authentication method:" {
        send "1\r"
        exp_continue
    }
    "Enter the verification code shown in your authenticator app::" {
        set otp [exec op item get $op_item --otp]
        send "$otp\r"
    }
    timeout {
        puts "\nError: Timed out waiting for GlobalProtect prompt.\n"
        exit 1
    }
}

# Wait for the command to finish and the daemon to take over
expect eof
EXPECT_SCRIPT

unset GP_PASSWORD

