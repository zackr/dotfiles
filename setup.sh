if [ ! -f "$PWD"/zsh/oh-my-zsh/custom/zack.zsh-theme ];
then
    ln -s "$PWD"/zsh/zack.zsh-theme "$PWD"/zsh/oh-my-zsh/custom/zack.zsh-theme
fi

cp "$PWD"/zsh/zshrc.zsh ~/.zshrc
SED=`which sed`
PERL=`which perl`
if [ -e  "$SED" ]; then
    sed -i -e 's,DOTFILES_DIR,'"$PWD"',g' ~/.zshrc
elif [ -e "$PERL" ]; then
    perl -pi -e 's,DOTFILES_DIR,'"$PWD"',g' ~/.zshrc
fi

echo "; Generated by $PWD/setup.sh" > ~/.emacs
echo "(setq sdk-directory \"$PWD/\")" >> ~/.emacs
echo "(load-file \"$PWD/emacs/dotemacs.el\")" >> ~/.emacs
