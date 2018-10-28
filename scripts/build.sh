echo executing build.sh 

# contrail build directory
#su - vagrant -c 'mkdir -p /home/vagrant/contrail'

# create new ssh key (no passphrase)
#su - vagrant -c 'ssh-keygen -f .ssh/id_rsa -P ""'

#echo "#######################################################################"
#echo "#These manual steps will be moved into the scripts over time          #"
#echo "#------------------------------------------------------               #"
#echo "#| IMPORTANT: Add this public key to your github account |            #"
#echo "#------------------------------------------------------               #"
##cat /home/vagrant/.ssh/id_rsa.pub
#echo "#------------------------------------------------------------------   #"
#echo "#| Now use the following commands to login and build opencontrail |   #"
#echo "#------------------------------------------------------------------   #"
#echo "#vagrant ssh                                                          #"
#echo "#eval \`ssh-agent\`                                                     #"
#echo "#ssh-add                                                              #"
#echo "#git config --global user.name <your github username>                 #"
#echo "#git config --global user.email <your github primary email>           #"
#echo "#cd /home/vagrant/contrail                                            #"
#echo "#ssh -o \"StrictHostKeyChecking no\" git@github.com                     #"
#echo "#git config --global color.ui true                                    #"
#echo "#repo init -u git@github.com:Juniper/contrail-vnc                     #"
#echo "#repo sync                                                            #"
#echo "#sudo python ./third_party/fetch_packages.py                          #"
#echo "#sudo python ./contrail-webui-third-party/fetch_packages.py           #"
#echo "## remove DPDK from the build                                         #"
#echo "#sed 's/contrail-heat \\\\/contrail-heat/' < packages.make | sed '/\\\$(CONTRAIL_VROUTER_DPDK)/d' >tmp.make"
#echo "#mv -f tmp.make packages.make                                         #"
#echo "## Now make the OpenContrail packages                                 #"
#echo "#sudo make -f packages.make all 2>&1 | tee build.log                  #"
#echo "#######################################################################"
