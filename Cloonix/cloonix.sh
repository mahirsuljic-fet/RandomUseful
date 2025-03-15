wget http://clownix.net/downloads/cloonix-45/cloonix-bundle-45-01-amd64.tar.gz
tar xvf cloonix-bundle-45-01-amd64.tar.gz
cd cloonix-bundle-45-01-amd64
sudo ./install_cloonix
mkdir -p /var/lib/cloonix/bulk
cd /var/lib/cloonix/bulk
wget http://clownix.net/downloads/cloonix-45/bulk/bookworm.qcow2.gz
sudo apt install gzip
gunzip bookworm.qcow2.gz
wget http://clownix.net/downloads/cloonix-45/bulk/zipfrr.zip
sudo cp cloonix /etc/apparmor.d/
sudo systemctl reload apparmor.service
