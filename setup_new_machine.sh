#!/bin/bash

email="ENTER_EMAIL_HERE"

function setupMongo() {
	echo "Installing Mongo ..."
	curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg \
   --dearmor
	echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
	sudo apt-get update
	sudo apt-get install -y mongodb-org
	sudo systemctl start mongod
}

function setupNode() {
	echo "Installing node ..."
	NVM_VERSION=$(curl -s "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | jq -r '.tag_name')
	curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
	source ~/.bashrc
	nvm install --lts
}

function firstStep() {
	# basic utilities
	echo "Installing basic utilities ..."
	sudo apt install git wget vim fuse xclip curl jq bat fzf tig gnome-tweaks gh ranger kitty build-essential ripgrep -y

	# Oh My Bash
	echo "Installing Oh-My-Bash ..."
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
	echo "alias c='clear'" >> ~/.bashrc
	echo "alias src='source ~/.bashrc'" >> ~/.bashrc

	setupNode

	# setup fonts
	echo "Installing fonts ..."
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip -P /tmp
	unzip /tmp/DroidSansMono.zip -d ~/.fonts
	fc-cache -fv

	# Git Delta for pretty gitdiffs
	echo "Installing git delta ..."
	DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | jq -r '.tag_name')
	curl -Lo ~/Downloads/git-delta.deb "https://github.com/dandavison/delta/releases/latest/download/git-delta_${DELTA_VERSION}_amd64.deb"
	sudo dpkg -i ~/Downloads/git-delta.deb

	git config --global user.email $email
	git config --global core.editor "vim"

	# Neovim
	echo "Installing Neovim ..."
	curl -Lo ~/Downloads/nvim "https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"
	sudo chmod +x ~/Downloads/nvim
	sudo mv ~/Downloads/nvim /usr/local/bin

	# install chrome
	echo "Installing Chrome ..."
	curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o ~/Downloads/chrome
	sudo chmod +x ~/Downloads/chrome
	sudo dpkg -i ~/Downloads/chrome

}

function setupGitSSHKeys() {
	echo "Setuping Git SSH Keys ..."
	ssh-keygen -t ed25519 -C "$email"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
	cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
	echo "ssh pub key copied to clipboard!!"
	google-chrome https://github.com/settings/ssh/new &
}

# to be run after login with google and github
function secondStep() {
	setupGitSSHKeys
}

function setupDotFiles() {
	echo "Setuping dotfiles ..."
	git clone git@github.com:trebaud/dotfiles.git

	mkdir ~/.config/kitty
	cp -r ~/dotfiles/kitty/* ~/.config/kitty
	mkdir ~/.config/nvim
	cp -r ~/dotfiles/nvim/* ~/.config/nvim
}

# to be run after ssh keys setup
function thirdStep() {
	setupDotFiles
}

# installs optional dependencies
function setupOptionals() {
	echo "Installing Rust ..."
	curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh

	echo "Installing Go ..."
	sudo apt install golang-go -y

	echo "Installing Lazygit ..."
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.tag_name')
	echo $LAZYGIT_VERSION
	curl -Lo  lazygitOut "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION:1}_Linux_x86_64.tar.gz"
	tar xf lazygitOut lazygit
	sudo install lazygit /usr/local/bin

	echo "Installing npm deps ..."
	npm i -g typescript prettier typescript-language-server neovim

	setupMongo

	echo "Installing slack ..."
	sudo snap install slack
}


function execute() {
	if [[ "$1" == "first" ]]
	then
		firstStep
	elif [[ "$1" == "second" ]]
	then
		secondStep
	elif [[ "$1" == "third" ]]
	then
		thirdStep
	elif [[ "$1" == "optionals" ]]
	then
		setupOptionals
	else
		echo 'ERROR: provide a valid step argument.'
		exit
	fi
}

usage() { echo "Usage: $0 [-s <first|second|optionals>] [-p <string>]" 1>&2; exit 1; }

[ $# -eq 0 ] && usage

# Parse args
while getopts ":s:e:h:" arg; do
	case $arg in
		s) stepArg=${OPTARG};;
		h | *)
			usage
			exit 0
			;;
	esac
done

execute $stepArg
