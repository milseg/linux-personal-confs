$HOME=/home/youruser

1. verificar se terminal suporta xterm-256color
echo $TERM
export TERM=xterm-256color

2. instalar oh-my-posh
https://ohmyposh.dev/docs/installation/linux

3. baixar/instalar nerd font
oh-my-posh font install

oh-my-posh font install firacode


4. verificar qual terminal esta usando
echo $SHELL
oh-my-posh get shell


5. baixar tema
https://ohmyposh.dev/docs/themes
atomicBit

6. acrescentar tema no ~/.bashrc

7. Instalar icons in terminal
git clone https://github.com/sebastiencs/icons-in-terminal.git
cd icons-in-terminal
./install.sh

8. Instalar ls-icons
git clone https://github.com/sebastiencs/ls-icons

cd ls-icons

sudo apt-get install autoconf automake autopoint bison gperf texinfo

./bootstrap

export CFLAGS=-DNO_TRUE_COLOURS=1 # Execute this line _only_ if your terminal doesn't support true colours

export CC=clang CXX=clang++
sudo apt-get install clang
mkdir $HOME/apps/custom-tools/coreutils
./configure --prefix=$HOME/apps/custom-tools/coreutils
make
make install

9. Adicionar alias do ls customizado no custom/custom-term.sh
alias lls='$HOME/apps/custom-tools/coreutils/bin/ls'
