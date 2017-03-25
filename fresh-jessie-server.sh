clear
echo ""
echo " ____  _____ ____  _   _ _     ____    _"
echo "/ ___|| ____|  _ \| | | | |   / ___|  / \ "
echo "\___ \|  _| | |_) | | | | |   \___ \ / _ \ "
echo " ___) | |___|  __/| |_| | |___ ___) / ___ \ "
echo "|____/|_____|_|    \___/|_____|____/_/   \_\ "
echo ""
echo ""
echo "********************************************************"
echo " Debian Jessie Fresh Basic Installation for Sepulsa     "
echo " Content: Nginx, PHP 7.0, MariaDB 10.1, etc    	      "
echo " -- rawis@sepulsa.com     				              "
echo " -- 25 Maret 2017      					              "
echo "********************************************************"
echo "***************************************************"
echo ""
sleep 13
#
sudo tee /proc/sys/vm/drop_caches
sudo apt-get update && apt-get dist-upgrade -y

###########################################################
# DEBIAN basic packages
###########################################################
sudo apt-get install -y software-properties-common apt-transport-https lsb-release ca-certificates \
						bash-completion consolekit libexpat1-dev gettext libz-dev \
						gnupg-curl build-essential libssl-dev libcurl4-gnutls-dev \
						apache2-utils zip unzip git vim htop

###########################################################
# Debian Backports from Official
###########################################################
sudo add-apt-repository 'deb http://ftp.debian.org/debian jessie-backports main'
sudo apt-get update && sudo apt-get dist-upgrade -y

###########################################################
# MariaDB 10.1x repo for Jessie Official
###########################################################
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://download.nus.edu.sg/mirror/mariadb/repo/10.1/debian jessie main'

###########################################################
# Dotdeb
###########################################################
sudo wget https://www.dotdeb.org/dotdeb.gpg && sudo apt-key add dotdeb.gpg

###########################################################
# Add default DOTDEB.ORG repository
###########################################################
sudo add-apt-repository 'deb http://packages.dotdeb.org jessie all'
#sudo add-apt-repository 'deb-src http://packages.dotdeb.org jessie all'

##########################################################################################
# Dotdeb Nginx with “full” HTTP2 support (with ALPN negotiation) on Debian 8 “Jessie” repo
##########################################################################################
sudo add-apt-repository 'deb http://packages.dotdeb.org jessie-nginx-http2 all'
#sudo add-apt-repository 'deb-src http://packages.dotdeb.org jessie-nginx-http2 all'

###########################################################
# Install openssl from backports for support nginx http/2
###########################################################
sudo apt-get update
sudo apt-get -t jessie-backports install "openssl" -y

###############################
# Install nginx-extras packages
###############################
sudo apt-get update
sudo apt-get install -y nginx-extras

############################
# Install PHP7.0 packages
############################
sudo apt-get update
sudo apt-get install -y php7.0-fpm php7.0-cgi php7.0-cli php7.0-common php7.0-curl php7.0-gd \
                       php7.0-json php7.0-opcache php7.0-mcrypt php7.0-readline php7.0-xsl \
                       php7.0-dev php7.0-mysql php7.0-redis php7.0-memcache libphp7.0-embed \
                       libmariadbclient-dev

#############################################
# Make specific Directory for Sepulsa's need
#############################################
sudo mkdir -p /sepulsa/www
sudo mkdir -p /sepulsa/logs/nginx
sudo mkdir -p /sepulsa/certs
# @todo make default configuration and replace configs from git repo

########################################
# Install MariaDB Server 10.1x packages
########################################
sudo apt-get update
sudo apt-get install -y mariadb-server mariadb-client

######################
# Performance tuning #
######################

#sudo echo "root soft nofile 65536" >> /etc/security/limits.conf
#sudo echo "root hard nofile 65536" >> /etc/security/limits.conf
#sudo echo "* soft nofile 65536" >> /etc/security/limits.conf
#sudo echo "* hard nofile 65536" >> /etc/security/limits.conf

#sudo echo "net.ipv4.tcp_tw_recycle = 1" >> /etc/sysctl.conf
#sudo echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf
#sudo echo "net.ipv4.ip_local_port_range = 10240    65535" >> /etc/sysctl.conf

############################
# Autoremove unused packages
############################
sudo apt-get autoclean -y
echo ""
echo "Clearing Memory.."
echo ""
free -m && sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches && free -m
echo ""
echo "Done.. "
echo "Have a good day.. :)"
echo ""
echo ""
echo "*******************************************************************************************************************"
