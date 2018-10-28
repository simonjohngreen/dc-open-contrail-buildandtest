Data-centre opencontrail build and test
========================================

This module contains a vagrant build that supports the building and testing of open contrail.

The vision for this is to create a vagrant development environemnt that allows consutants to quickly respond to opencontrail users demands for incorporation of their patches into contrail.

The build and test box will allow experienced consultants to rebuild contrail against different versions of openstack as required by customers.

This initial version will support v3 of contrail.

To watch the build 'tail -f provision.log'

File: config.default.json

Configuration and build parameters are located here 

Descriptions follow:

################################################################################
#                                                                              #
# config.default.json                                                          #
#                                                                              #
# Version: 1                                                                   #
#                                                                              #
# Description: json configuration file that defines all of the                 #
#              vagrant box parameters required to build OpenContrail           #
#                                                                              #
#                                                                              #
# Servers: Defines one Vagrant VM:                                             #
#          Mutiple Servers can be defined                                      #
#             [name]:                                                          #
#                    guest_hostname: Provisioned Hostname for the box          #
#                    box:            Vagrant box (only Ubuntu is supported)    #
#                    timezone:       Provisioned timezone for the box          #
#                    gui:            if set to false headless mode is used     #
#                    cpus:           number of virtual cores                   #
#                    memory:         in MB                                     #
#                    paravirtprovider: for virtualboxk, kvm, default etc.      #
#                    scripts:        a list of scripts to run in dir scripts   #
#                    makeops:        see below                                 #
#                    gituser:        user for git login                        #
#                    gitemail:       email for git login                       #
#                    replacekey:     true false                                #
#                    keytype:        untrusted, local                          #
#                                                                              #
#   Makeopts: The following options are supported                              #
#                                         all                                  #
#                                         package-ifmap-server                 #
#                                         package-contrail-web-core            #
#                                         package-contrail-web-controller      #
#                                         package-contrail                     #
#                                         package-neutron-plugin-contrail      #
#                                         package-ceilometer-plugin-contrail   #
#                                         package-contrail-vrouter-dpdk        #
#                                         package-contrail-heat                #
#                                         fetch-webui-third-party              # 
#                                                                              #
#   When replacekey=true keytype=untrusted vagrant copies over the             # 
#   untrusted keys for git user insecuregituser                                # 
#                                                                              #
#   When replacekey=true keytype=local vagrant copies over the                 # 
#   keys from the local hosts home directory                                   #
#                                                                              #
#   When replacekey=false keytype is ignored and local keys are generates      # 
#   The public key will have to be loaded into git manually                    #
#                                                                              #
# If the default git user email and replacekey are set                         #
# then an insecure key is copied over and the default git account is used      #
# for the  git clone.                                                          #
#                                                                              #
# For users who plan to submit code the gituser and gitemail should be set     #
# replacekeys should be set to false and the public key should be added to git #
# manualy                                                                      #
#                                                                              #
################################################################################
