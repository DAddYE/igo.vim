#!/usr/bin/env sh

FILES="
autoload/igo/complete.vim
ftdetect/igofiletype.vim
ftplugin/igo/fmt.vim
ftplugin/igo/test.sh
ftplugin/igo.vim
indent/igo.vim
syntax/igo.vim
"

mkdir -p ~/.vim/autoload/igo
mkdir -p ~/.vim/ftplugin/igo

for f in $FILES; do
  ln -fs $(pwd)/$f ~/.vim/$f
done

echo "Done."
