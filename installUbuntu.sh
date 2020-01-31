#!/bin/bash
install='sudo apt install -y'

sudo apt install dialog -y
ans=`dialog --checklist "Choose porgramms to install:" 0 0 0 \
 Syncthing "" on\
 Borg "" on\
 KeePassXC "" on\
 Thunderbird "" on\
 Code "" on\
 Latex "" on\
 LibreOffice "" on\
 VLC "" on\
 Gimp "" on\
 Inkscape "" on\
 VPN "" on\
 Tools "" on\
 CryFS "" off\
 Cryptomator "" off\
 Qemu "" off\
 Rat7 "" off 3>&1 1>&2 2>&3`
dialog --clear
clear
echo $ans

sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade && sudo apt autoremove -y

if [[ $ans == *"Syncthing"* ]]; then
	$install curl -y
	curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
	echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
	sudo apt update
	$install syncthing
	sudo ln -s /usr/share/applications/syncthing-start.desktop /etc/xdg/autostart/
fi

if [[ $ans == *"Borg"* ]]; then
	$install borgbackup -y
fi

if [[ $ans == *"KeePassXC"* ]]; then
	$install keepassxc -y
fi

if [[ $ans == *"Thunderbird"* ]]; then
	$install thunderbird -y
fi

if [[ $ans == *"Code"* ]]; then
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -$install
	sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	sudo apt update
	$install code 
fi

if [[ $ans == *"Latex"* ]]; then
	$install texlive-latex-extra
	$install latexmk texlive-lang-german
fi

if [[ $ans == *"LibreOffice"* ]]; then
	$install libreoffice
fi

if [[ $ans == *"VLC"* ]]; then
	$install vlc
fi

if [[ $ans == *"Gimp"* ]]; then
	$install gimp
fi

if [[ $ans == *"Inkscape"* ]]; then
	$install inkscape
fi

if [[ $ans == *"VPN"* ]]; then
	$install network-manager-vpnc network-manager-vpnc-gnome vpnc
fi

if [[ $ans == *"Tools"* ]];then
	$install exfat-utils ntfs-3g
	$install vim tmux git
	$install ranger htop psensor 
	$install gparted 
	$install guake  && sudo ln -s /usr/share/applications/guake.desktop /etc/xdg/autostart/
fi

if [[ $ans == *"CryFS"* ]]; then
	$install cryfs
fi

if [[ $ans == *"Cryptomator"* ]]; then
	echo | sudo add-apt-repository ppa:sebastian-stenzel/cryptomator
	sudo apt update
	$install cryptomator
fi

if [[ $ans == *"Qemu"* ]]; then
	$install qemu-kvm qemu virt-manager virt-viewer libvirt-bin
fi

if [[ $ans == *"Rat7"* ]]; then
	if [ ! -d /etc/X11/xorg.conf.d ]; then
		sudo mkdir /etc/X11/xorg.conf.d
	fi
	if [ -e /etc/X11/xorg.conf.d/910-rat.conf ]; then
		sudo rm /etc/X11/xorg.conf.d/910-rat.conf
	fi
	sudo bash -c 'cat > /etc/X11/xorg.conf.d/910-rat.conf' <<EOF
	Section "InputClass"
	Identifier "R.A.T."
	MatchProduct "R.A.T.7|R.A.T.9"
	MatchDevicePath "/dev/input/event*"
	Option "Buttons" "17"
	Option "ButtonMapping" "1 2 3 4 5 0 0 8 9 7 6 12 0 0 0 16 17"
	Option "AutoReleaseButtons" "13 14 15"
	Option "ZAxisMapping" "4 5 6 7"
	EndSection
EOF
fi
