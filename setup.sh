#!/bin/bash

######################################################################################################
#        _            _          _            _        _          _             _           _
#       /\ \         /\ \       /\ \         /\ \     /\ \       _\ \          /\ \        / /\
#      /  \ \____   /  \ \      \_\ \       /  \ \    \ \ \     /\__ \        /  \ \      / /  \
#     / /\ \_____\ / /\ \ \     /\__ \     / /\ \ \   /\ \_\   / /_ \_\      / /\ \ \    / / /\ \__
#    / / /\/___  // / /\ \ \   / /_ \ \   / / /\ \_\ / /\/_/  / / /\/_/     / / /\ \_\  / / /\ \___\
#   / / /   / / // / /  \ \_\ / / /\ \ \ / /_/_ \/_// / /    / / /         / /_/_ \/_/  \ \ \ \/___/
#  / / /   / / // / /   / / // / /  \/_// /____/\  / / /    / / /         / /____/\      \ \ \
# / / /   / / // / /   / / // / /      / /\____\/ / / /    / / / ____    / /\____\/  _    \ \ \
# \ \ \__/ / // / /___/ / // / /      / / /   ___/ / /__  / /_/_/ ___/\ / / /______ /_/\__/ / /
#  \ \___\/ // / /____\/ //_/ /      / / /   /\__\/_/___\/_______/\__\// / /_______\\ \/___/ /
#   \/_____/ \/_________/ \_\/       \/_/    \/_________/\_______\/    \/__________/ \_____\/
#
######################################################################################################
#
#         Setup script for a minimalist development environment
#
######################################################################################################

# -- Default setup values

GIT_NAME="name"
GIT_EMAIL="email"
CURRENT_DIR="$(pwd)"

# -- Utility functions

log() {
  repeat=80
  symbol="="
  if [[ $1 = "-t" ]]; then
    text=$3
    if [[ $2 = "h2" ]]; then
      repeat=60
      symbol="-"
    fi
  else
    text=$1
  fi

  printf "\n"
  for ((n=0;n<$repeat;n++)); do echo -n $symbol; done
  printf "\n\n\t$text\n\n"
  for ((n=0;n<$repeat;n++)); do echo -n $symbol; done
  printf "\n"
}

# -- Setup Git
setup_git() {
  cp $HOME/dotfiles/.gitconfig $HOME && \
  if [[ $1 = "-git" ]]; then
    git config --global user.name "$GIT_NAME" && \
    git config --global user.email "$GIT_EMAIL"
  fi
}

# --- Install Tig
install_tig() {
  log -t h2 Tig
  wget -P $HOME https://github.com/jonas/tig/releases/download/tig-2.4.1/tig-2.4.1.tar.gz && \
  tar -xvf $HOME/tig-2.4.1.tar.gz && cd tig-2.4.1 && \
  tig-2.4.1/make && sudo make install prefix=/usr/local && cd $CURRENT_DIR
}

# --- Install curl
install_curl() {
  log -t h2 curl
  if [[ $os = "debian" ]]; then
    sudo apt-get -y install curl
  elif [[ $os = "arch" ]]; then
    sudo pacman -Sy curl
  fi
}

# --- Install zsh
install_zsh() {
  if ! [ "$(command -v curl)" ]; then
    install_curl
  fi

  log -t h2 zsh
  if [[ $os = "debian" ]]; then
    sudo apt -y install zsh
  elif [[ $os = "arch" ]]; then
    sudo pacman -Sy zsh
  fi
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
  git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" && \
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" && \
  cp $HOME/dotfiles/.zshrc $HOME
}

# --- Install neovim and plugs
install_neovim() {
  log -t h2 Neovim
  if [[ $os = "debian" ]]; then
    sudo apt-get -y install neovim
  elif [[ $os = "arch" ]]; then
    sudo pacman -Sy neovim
  fi
}

# --- Install Plug
install_plug() {
  if ! [ "$(command -v curl)" ]; then
    install_curl
  fi

  if ! [ "$(command -v nvim)" ]; then
    install_neovim
  fi

  log -t h2 Plug
  curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
  mkdir $HOME/.config/nvim && cp dotfiles/init.vim $HOME/.config/nvim && \
  curl https://sh.rustup.rs -sSf | sh
  nvim +'PlugInstall --sync' +qa
}

# --- Install nodeJS/npm
install_node() {
  log -t h2 nodeJS/npm
  if [[ $os = "debian" ]]; then
    sudo apt -y install nodejs npm
  elif [[ $os = "arch" ]]; then
    sudo pacman -Sy nodejs npm
  fi
}

# --- Install Powerline - Fonts
install_powerline() {
  log -t h2 Powerline - Fonts
  git clone https://github.com/powerline/fonts.git && \
  ./$HOME/fonts/install.sh && \
  wget -P $HOME/.local/share/fonts/ https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf && \
  fc-cache -vf $HOME/.local/share/fonts/ && \
  mkdir $HOME/.config/fontconfig && mkdir $HOME/.config/fontconfig/conf.d && \
  wget -P $HOME/.config/fontconfig/conf.d https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
}

# --- Install tmux
install_tmux() {
  log -t h2 Tmux
  if [[ $os = "debian" ]]; then
    sudo apt-get -y install tmux
  elif [[ $os = "arch" ]]; then
    sudo pacman -Sy tmux
  fi
  cp $HOME/dotfiles/.tmux.conf $HOME
}

install() {
  if [ -z "$1" ]
    then
      install_curl;install_tig;install_zsh;install_tmux
      install_neovim;install_plug;install_node;install_powerline
      return 1
  fi

  for prog in $1
  do
    case $prog in
      curl)
        install_curl
      ;;
      tig)
        install_tig
      ;;
      zsh)
        install_zsh
      ;;
      tmux)
        install_tmux
      ;;
      neovim)
        install_neovim
      ;;
      plug)
        install_plug
      ;;
      nodejs)
        install_node
      ;;
      powerline)
        install_powerline
      ;;
      *)
        echo "Program $prog is not supported"
      ;;
    esac
  done
}

# -- Set distribution

os=$(cat /etc/os-release | grep ID_LIKE | cut -d'=' -f2)

if [ "$os" != "debian" && "$os" != "arch" ]; then
  log "You are not using a supported distribution"
  exit 0
fi

# -- Parse params

for i in "$@"
do
case $i in
    -i=*|--install=*)
      PROGRAMS="${i#*=}"
      shift
    ;;
    *)
      echo "Unknown params"
    ;;
esac
done

programs=$(echo $PROGRAMS | tr ";" "\n")


# -- START THE SETUP PROCESS

log "Start setup"
log  -t h2 "Installing $programs in $os"

install $programs

setup_git

# -- Setup Complete
log "Setup Complete"
