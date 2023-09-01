#!/bin/sh

# post installation script for Parrot Security

configure_sources_list() {
    if grep -q '^deb http' /etc/apt/sources.list; then
	echo "INFO: sources.list is configured, everything is fine"
	return
    fi

    echo "INFO: sources.list is empty, setting up a default one for Parrot Security"

    cat >/etc/apt/sources.list <<END
END
    apt-get update
}

get_user_list() {
    for user in $(cd /home && ls); do
	if ! getent passwd "$user" >/dev/null; then
	    echo "WARNING: user '$user' is invalid but /home/$user exists"
	    continue
	fi
	echo "$user"
    done
    echo "root"
}

configure_zsh() {
    if grep -q 'nozsh' /proc/cmdline; then
	echo "INFO: user opted out of zsh by default"
	return
    fi
    if [ ! -x /usr/bin/zsh ]; then
	echo "INFO: /usr/bin/zsh is not available"
	return
    fi
    for user in $(get_user_list); do
	echo "INFO: changing default shell of user '$user' to zsh"
	chsh --shell /usr/bin/zsh $user
    done
}


configure_sources_list
configure_zsh

##################################
# Custom post-installation steps #
##################################

configure_swapfile() {
    dd if=/dev/zero of=/swapfile bs=2G count=1
    chmod 600 /swapfile
    mkswap /swapfile
    printf "/swapfile none swap sw 0 0\n" >> /etc/fstab
}

configure_swapfile

install_ssh() {
    sudo apt install ssh -y
    sudo systemctl enable ssh.service
    sudo systemctl start ssh
}

install_ssh
