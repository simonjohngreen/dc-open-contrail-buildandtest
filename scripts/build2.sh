echo Executing build2.sh 
echo cloning the opencontrail git repo and building the products 


# we need the keypairs file for the git user and login so test for it
if [ ! -f /home/vagrant/keypairs ]; then
    echo "Keypairs file is missing but required by build2.sh!"
    exit 1 
fi

# extract variables from the keypairs file 
source /home/vagrant/keypairs

# contrail build directory
#su - vagrant -c 'mkdir -p /home/vagrant/contrail'
## create new ssh key (no passphrase)
#su - vagrant -c 'ssh-keygen -f .ssh/id_rsa -P ""'
#eval `ssh-agent`
#ssh-add 

##add the git repo
su - vagrant -c 'git config --global user.name $gituser'
su - vagrant -c 'git config --global user.email $gitemail'
cd /home/vagrant/contrail 
su - vagrant -c 'cd /home/vagrant/contrail; ssh -o "StrictHostKeyChecking no" git@github.com'
su - vagrant -c 'cd /home/vagrant/contrail; git config --global color.ui true'
su - vagrant -c 'cd /home/vagrant/contrail; repo init -u git@github.com:Juniper/contrail-vnc'
su - vagrant -c 'cd /home/vagrant/contrail; repo sync'
sudo python /home/vagrant/contrail/third_party/fetch_packages.py  
sudo python /home/vagrant/contrail/contrail-webui-third-party/fetch_packages.py 

echo "# removing DPDK from the build as its not working yet" 
#su - vagrant -c 'cp /home/vagrant/contrail/packages.make /home/vagrant/original-packages.make'
#su - vagrant -c "sed 's/contrail-heat \\\\/contrail-heat/' < /home/vagrant/contrail/packages.make | sed '/\\\$(CONTRAIL_VROUTER_DPDK)/d' > /home/vagrant/contrail/temp.make"
#su - vagrant -c 'cd /home/vagrant/contrail; cp -f /home/vagrant/contrail/temp.make /home/vagrant/contrail/packages.make'
su - vagrant -c 'cp /home/vagrant/contrail/packages.make /home/vagrant/original-packages.make'
su - vagrant -c "sed '/DPDK vRouter/,+6 d' < /home/vagrant/contrail/packages.make >  /home/vagrant/contrail/temp.make"
su - vagrant -c 'cd /home/vagrant/contrail; cp -f /home/vagrant/contrail/temp.make /home/vagrant/contrail/packages.make'

echo making the opencontrail packages this may take a while
#make the packages, takes a while
#sudo make -f /home/vagrant/contrail/packages.make $makeopts 2>&1 | tee /home/vagrant/contrail/build.log
cd /home/vagrant/contrail
make -f /home/vagrant/contrail/packages.make $makeopts 
