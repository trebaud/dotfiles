function setupGitSSHKeys() {
	ssh-keygen -t ed25519 -C "$emailArg"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
	cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
	echo "ssh pub key copied to clipboard!!"
	google-chrome https://github.com/settings/ssh/new &
}

function setupMongo() {
	curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg \
   --dearmor
	echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
	sudo apt-get update
	sudo apt-get install -y mongodb-org
	sudo systemctl start mongod
}

function setupDotFiles() {
	git clone https://github.com/trebaud/dotfiles.git

	mkdir ~/.config/kitty
	cp -r ~/dotfiles/kitty/* ~/.config/kitty
}

function firstStep() {
	# assumes git is already installed
	if ! command -v git &> /dev/null
	then
		echo "git is not installed"
		exit
	fi

	# basic utilities
	sudo apt install wget vim xclip curl jq bat fzf tig gnome-tweaks nmap gh ranger kitty build-essential ripgrep -y

	# Oh My Bash
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
	echo "alias c='clear'" >> ~/.bashrc
	echo "alias src='source ~/.bashrc'" >> ~/.bashrc

	# Git Delta for pretty gitdiffs
	DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | jq -r '.tag_name')
	curl -Lo ~/Downloads/git-delta.deb "https://github.com/dandavison/delta/releases/latest/download/git-delta_${DELTA_VERSION}_amd64.deb"
	sudo dpkg -i ~/Downloads/git-delta.deb
	git config --global user.email $emailArg
	git config --global core.editor "vim"

	# Neovim
	curl -Lo ~/Downloads/nvim "https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"

	setupDotFiles

	# install chrome
	curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o ~/Downloads/chrome
	sudo chmod +x ~/Downloads/chrome
	sudo dpkg -i ~/Downloads/chrome

	setupMongo
}

# to be run after login with google and github
function secondStep() {
	setupGitSSHKeys
	sudo snap install slack
}

# installs optional dependencies
function optionals() {
	curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh

	sudo apt install golang-go -y

	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.tag_name')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin
}

usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; }

function parseArgs() {
	while getopts ":s:e:" flag
	do
		case "${flag}" in
			s) stepArg=${OPTARG};;
			e) emailArg=${OPTARG};;
			*) usage;;
		esac
	done

	if [ -z "$emailArg" ]
	then
		echo "ERROR: email argument is missing."
		exit
	fi

	if [ -z "$stepArg" ]
	then
		echo "ERROR: step argument is missing."
		exit
	fi

}

function execute() {
	if [$stepArg == 'first']
	then
		firstStep
	elif [$stepArg == 'second']
	then
		secondStep
	elif [$stepArg == 'optionals']
	then
		secondStep
	else
		echo 'ERROR: provide a valid step argument.'
		exit
	fi
}

parseArgs
execute
