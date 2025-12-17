sudo pacman -S           \
  expat gcc-libs glibc   \
  libdrm libelf libx11   \
  libxcb libxext         \
  libxshmfence           \
  libxxf86vm  llvm-libs  \
  lm_sensors zlib zstd   

sudo pacman -S --dbonly mesa

cd ${HOME}/dotfiles/pacmania
cp bundles/core.txt intent/
cp "bundles/dwm+st+status.txt" intent/
cp bundles/xephyr.txt intent/
./enforce.sh

touch ${HOME}/.xprofile
ln -s ${HOME}/dotfiles/bash_profile ${HOME}/.bash_profile
ln -s ${HOME}/dotfiles/bashrc ${HOME}/.bashrc
ln -s ${HOME}/dotfiles/bashit ${HOME}/.bashit
ln -s ${HOME}/dotfiles/Xresources ${HOME}/.Xresources
ln -s ${HOME}/dotfiles/Xresources.colors ${HOME}/.Xresources.colors
ln -s ${HOME}/dotfiles/xmodman ${HOME}/.xmodmap
ln -s ${HOME}/dotfiles/xinitrc ${HOME}/.xinitrc
ln -s ${HOME}/dotfiles/config ${HOME}/.config
ln -s ${HOME}/dotfiles/bin ${HOME}/bin

ln -s ${HOME}/dotfiles/gitconfig ${HOME}/.gitconfig
ln -s ${HOME}/dotfiles/githelpers ${HOME}/.githelpers

unzip ${HOME}/dotfiles/fonts/*.zip -d ${HOME}/dotfiles/fonts/
ln -s ${HOME}/dotfiles/fonts ${HOME}/.fonts
fc-cache -f

git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it

cd ${HOME} && mkdir .window-manager
cd ${HOME}/.window-manager && git clone https://github.com/rlofc/dwm-patchwork
cd ${HOME}/.window-manager && git clone https://github.com/rlofc/st
cd ${HOME}/.window-manager/dwm-patchwork && sudo make install
cd ${HOME}/.window-manager/st && sudo make install

# startx -- /usr/bin/Xephyr :1
