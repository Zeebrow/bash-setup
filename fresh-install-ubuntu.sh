#!/bin/bash
# use after doing a "mimimal" Ubuntu install

user="$USER"
gh_url="https://github.com/$user\="

function prereboot() {
	sudo apt -y update && sudo apt -y upgrade
	sudo ubuntu-drivers autoupdate
}

function vim_setup() {
  if [ -e "$HOME/.vim/autoload/plug.vim" ]; then
    vim +PlugUpdate +qall
  else
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall
  fi
}

function install_software(){
# remove snap
  sudo apt -y purge snapd
  sudo apt-mark hold snapd
  rm -rf "$HOME/snap"

# install favies
	sudo apt -y install \
	vim git curl jq \
  htop \
  firefox \
  gimp \
  python3-pip \
  python3-venv 

  wget -O FirefoxSetup.exe "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"

# install "other"
  #sudo apt -y install
  #sudo apt -y install gnome-tweaks
  #sudo apt -y install virtualbox
  #sudo apt -y install libreoffice
  
  #wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O vscode.deb
  #dpkg -i vscode.deb
  #rm vscode.deb
}

function install_bloatware() {

  # the familiar scripts
	mkdir -p "$HOME/repos/github.com/$user"
	cd "$HOME/repos/github.com/$user"
	git clone "$gh_url/bash-setup.git"
	cd "$HOME/repos/github.com/$user/bash-setup"
	./install.sh all
  
  # sandbox
	mkdir -p "$HOME/sandcastle"
	mkdir -p "$HOME/sandbox"
  crontab -l | grep -q "$HOME/sandbox"
  if [ "$?" -eq 0 ]; then
    echo sandbox is already installed
  else
    _t=$(mktemp)
    crontab -l > "$_t"
    echo "@reboot /usr/bin/rm -rf /home/$user/sandbox && mkdir /home/$user/sandbox" >> "$_t"
    crontab "$_t"
    rm "$_t"
  fi
}

function chinz(){
firefox 'https://boards.4channel.org/g/thread/87264991#cfg=%7B%22settings%22%3A%22%7B%5C%22quotePreview%5C%22%3Atrue%2C%5C%22backlinks%5C%22%3Atrue%2C%5C%22quickReply%5C%22%3Atrue%2C%5C%22threadUpdater%5C%22%3Atrue%2C%5C%22threadHiding%5C%22%3Atrue%2C%5C%22alwaysAutoUpdate%5C%22%3Afalse%2C%5C%22topPageNav%5C%22%3Afalse%2C%5C%22threadWatcher%5C%22%3Afalse%2C%5C%22threadAutoWatcher%5C%22%3Afalse%2C%5C%22imageExpansion%5C%22%3Atrue%2C%5C%22fitToScreenExpansion%5C%22%3Atrue%2C%5C%22threadExpansion%5C%22%3Atrue%2C%5C%22alwaysDepage%5C%22%3Afalse%2C%5C%22localTime%5C%22%3Atrue%2C%5C%22stickyNav%5C%22%3Afalse%2C%5C%22keyBinds%5C%22%3Afalse%2C%5C%22inlineQuotes%5C%22%3Atrue%2C%5C%22showNWSBoards%5C%22%3Atrue%2C%5C%22filter%5C%22%3Afalse%2C%5C%22revealSpoilers%5C%22%3Afalse%2C%5C%22imageHover%5C%22%3Afalse%2C%5C%22threadStats%5C%22%3Atrue%2C%5C%22IDColor%5C%22%3Atrue%2C%5C%22noPictures%5C%22%3Afalse%2C%5C%22embedYouTube%5C%22%3Atrue%2C%5C%22embedSoundCloud%5C%22%3Atrue%2C%5C%22updaterSound%5C%22%3Afalse%2C%5C%22customCSS%5C%22%3Afalse%2C%5C%22autoScroll%5C%22%3Afalse%2C%5C%22hideStubs%5C%22%3Afalse%2C%5C%22compactThreads%5C%22%3Afalse%2C%5C%22centeredThreads%5C%22%3Afalse%2C%5C%22dropDownNav%5C%22%3Afalse%2C%5C%22autoHideNav%5C%22%3Afalse%2C%5C%22classicNav%5C%22%3Afalse%2C%5C%22fixedThreadWatcher%5C%22%3Afalse%2C%5C%22persistentQR%5C%22%3Atrue%2C%5C%22forceHTTPS%5C%22%3Atrue%2C%5C%22darkTheme%5C%22%3Afalse%2C%5C%22linkify%5C%22%3Atrue%2C%5C%22unmuteWebm%5C%22%3Afalse%2C%5C%22disableAll%5C%22%3Afalse%2C%5C%22customMenu%5C%22%3Afalse%2C%5C%22imageHoverBg%5C%22%3Afalse%7D%22%7D'
}


#prereboot
install_software
install_bloatware
vim_setup

