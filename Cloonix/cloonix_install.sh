#!/bin/bash

#############
# VARIABLES #
#############

# colors
green='\033[1;32m'
yellow='\033[0;33m'
white='\033[0m'

# general paths
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cloonix_source_dir_name="cloonix_install"
cloonix_source_path=$SCRIPTPATH/$cloonix_source_dir_name

cloonix_url_root=http://clownix.net/downloads/cloonix-45

bundle=cloonix-bundle-45-01-amd64
cloonix=$bundle.tar.gz
cloonix_url=$cloonix_url_root/$cloonix

bookworm=bookworm.qcow2
bookworm_tar=$bookworm.gz
bookworm_tar_url=$cloonix_url_root/bulk/$bookworm_tar

zipfrr=zipfrr.zip
zipfrr_url=$cloonix_url_root/bulk/$zipfrr

bulk=bulk.tar.gz
bulk_url=https://gitlab.com/amer.hasanovic/fet_net/-/raw/master/$bulk

profile=cloonix
profile_url=https://raw.githubusercontent.com/mahirsuljic-fet/RandomUseful/refs/heads/main/Cloonix/$profile

bundle_file1=install_cloonix
bundle_file2=server.tar.gz
bundle_file3=common.tar.gz

bulk_path=$cloonix_source_path/opt1/cloonix_data/bulk/
openwrt=openwrt.qcow2
stretch=stretch.qcow2

cloonix_bulk_path=/var/lib/cloonix/bulk
apparmor_profiles_path=/etc/apparmor.d/


############
# DOWNLOAD #
############

if [ ! -d $cloonix_source_path ]; then
  mkdir $cloonix_source_dir_name
fi

cd $cloonix_source_path

if [ ! -f $cloonix_source_path/$cloonix ]; then
  echo -e "${green}Downloading Cloonix...${white}"
  wget $cloonix_url
fi

# Bookworm
if [ ! -f $cloonix_source_path/$bookworm_tar ]; then
  echo -e "${green}Downloading bookworm...${white}"
  wget $bookworm_tar_url
fi

# zipfrr
if [ ! -f $cloonix_source_path/$zipfrr  ]; then
  echo -e "${green}Downloading zipfrr...${white}"
  wget $zipfrr_url
fi

# bulk
if [ ! -f $cloonix_source_path/$bulk ]; then
  echo -e "${green}Downloading bulk...${white}"
  wget $bulk_url
fi

# apparmor profile
if [ ! -f $cloonix_source_path/$profile ]; then
  echo -e "${green}Downloading apparmor profile...${white}"
  wget $profile_url
fi

# gzip
installed=$(dpkg-query -W --showformat='${Status}\n' gzip | grep "install ok installed")
if [ "" = "$installed" ]; then
  echo -e "${green}Installing gzip...${white}"
  sudo apt-get --yes install gzip
fi


###########
# INSTALL #
###########

install=true

if [ ls /usr/bin/cloonix_* 1> /dev/null 2>&1 ] ||
   [ -d /usr/libexec/cloonix ] ||
   [ -d /var/lib/cloonix ]; then
  echo -ne "${yellow}Cloonix is already installed\nDo you want to reinstall it? (Y/N): ${white}"
  read uninstall

  if [[ $uninstall == [yY] || $uninstall == [yY][eE][sS] ]]; then
    echo -e "${green}Removing cloonix...${white}"
    sudo rm -rf /usr/bin/cloonix_*
    sudo rm -rf /usr/libexec/cloonix
    sudo rm -rf /var/lib/cloonix
  else
    install=false
  fi
fi

if [ $install = true ]; then
  ###########
  # EXTRACT #
  ###########

  if [ ! -f $cloonix_source_path/$bundle/$bundle_file1 ] ||
     [ ! -f $cloonix_source_path/$bundle/$bundle_file2 ] ||
     [ ! -f $cloonix_source_path/$bundle/$bundle_file3 ]; then
    echo -e "${green}Extracting cloonix bundle...${white}"
    tar -xvf $cloonix
  fi
  
  if [ ! -f $cloonix_source_path/$bookworm ]; then
    echo -e "${green}Extracting bookworm...${white}"
    gunzip -k $bookworm_tar
  fi
  
  if [ ! -f $bulk_path/$openwrt ] ||
     [ ! -f $bulk_path/$stretch ]; then
    echo -e "${green}Extracting bulk...${white}"
    tar -xzvf $bulk
  fi

  echo -e "${green}Installing cloonix...${white}"

  cd $cloonix_source_path/$bundle
  sudo ./install_cloonix
  cd $cloonix_source_path

  echo -e "${green}Moving bulk files...${white}"
  if [ ! -r $cloonix_bulk_path ]; then
    mkdir -p $cloonix_bulk_path
  fi

  if [ ! -f $cloonix_bulk_path/$bookworm ]; then
    sudo mv $cloonix_source_path/$bookworm $cloonix_bulk_path
  fi

  if [ ! -f $cloonix_bulk_path/$openwrt ]; then
    sudo mv $bulk_path/$openwrt $cloonix_bulk_path
  fi

  if [ ! -f $cloonix_bulk_path/$stretch ]; then
    sudo mv $bulk_path/$stretch $cloonix_bulk_path
  fi
fi

if [ -d $apparmor_profiles_path ] &&
   [ ! -f $apparmor_profiles_path/$profile ]; then
  echo -e "${green}Creating apparmor profile for cloonix...${white}"
  sudo mv $cloonix_source_path/$profile $apparmor_profiles_path
  echo -e "${green}Reloading apparmor service...${white}"
  sudo systemctl reload apparmor.service
fi

cd $SCRIPTPATH
