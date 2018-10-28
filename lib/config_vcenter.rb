def configVcenter(instance, server, local_config, config)

     if server["debug"] === "true"
          puts "Debug: Creating VCenter VM"
     end

    config.vm.provider :vcenter do |vcenter|
       vcenter.hostname = '192.168.1.45'
       vcenter.username = 'root'
       vcenter.password = 'simon123'
#       vcenter.folder_name = 'myFolderName'
       vcenter.datacenter_name = 'HomeServer'
       vcenter.computer_name = 'HomeServer1'
       vcenter.datastore_name = 'datastore1'
       vcenter.network_name = 'MGMT'
       vcenter.linked_clones = true
     end



# #     instance.vm.provider "virtualbox" do |v|
# # 
# #         v.name = server["id"]
# # 
# #         if !server["cpus"]
# #             v.customize [ "modifyvm", :id, "--cpus", "1" ]
# #         else
# #             v.customize [ "modifyvm", :id, "--cpus", server["cpus"] ]
# #         end
# # 
# #         if !server["memory"]
# #             v.customize [ "modifyvm", :id, "--memory", "4096" ]
# #         else
# #             v.customize [ "modifyvm", :id, "--memory", server["memory"] ]
# #         end
# # 
# #         if !server["paravirtprovider"]
# #             v.customize [ "modifyvm", :id, "--paravirtprovider", "legacy" ]
# #         else
# #             v.customize [ "modifyvm", :id, "--paravirtprovider", server["paravirtprovider"] ]
# #         end
# # 
# #         v.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000 ]
# #         v.customize [ "setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate//opt", "1" ]
# # 
# #     end
# 
#     # Set box type based on configuration. Defaults to `precise64` (Ubuntu).
#     # The URL that you see below is from Vagrant's own list of available boxes:
#     # http://www.vagrantbox.es/
     if !server["box"]
         instance.vm.box = "precise64"
         instance.vm.box_url = "http://files.vagrantup.com/precise64.box"
     else
         instance.vm.box = server["box"]
         instance.vm.box_url = server["box_url"]
     end
# 
#     # Set IP Address
#     #instance.vm.network :private_network, ip: server["guest_ip"]
# 
#     # Setup port forwarding
#     server["host_port_forwarding"].each do |ports|
#         instance.vm.network :forwarded_port, guest: ports["guest"], host: ports["host"]
#     end
# 
#     # Enable SSH agent forwarding
#     config.ssh.forward_agent = true
# 
#     # Run provisioning scripts
#     # Global
#     server["host_scripts"].each do |script, key|
#            instance.vm.provision :host_shell do |host_shell|
#             host_shell.inline = './host_scripts/' + script
#         end
#     end
# 
#     # we are not using this plugin yet
#     #instance.hostsupdater.aliases = server["aliases"]
# 
# 
#     # Loop through configured path maps.
#     server["paths"].each do |local_path, remote_path|
#         instance.vm.synced_folder local_path, remote_path, type: "nfs", nfs_udp: true, create: true
#     end
# 
#     if server["guest_hostname"]
#         instance.vm.hostname = server["guest_hostname"]
#     end
# 
#     # Guest provisioning
# 
#     # ngrok
#     local_config["servers"].each do |tsk, this_server|
#         if this_server["ngrok_token"]
#             ngrok_cmd = "echo \"auth_token: " + this_server["ngrok_token"] + "\" >> ~/.ngrok"
#             config.vm.provision "shell", inline: ngrok_cmd
#             ngrok_cmd = "echo \"auth_token: " + this_server["ngrok_token"] + "\" >> /home/vagrant/.ngrok; chown vagrant:vagrant /home/vagrant/.ngrok"
#             config.vm.provision "shell", inline: ngrok_cmd
#         end
#     end
# 
#     # Timezone
#     local_config["servers"].each do |tsk, this_server|
#         if this_server["timezone"]
#             timezone_cmd = "mv /etc/localtime /etc/localtime.bak; ln -sf /usr/share/zoneinfo/" + this_server["timezone"] + " /etc/localtime"
#             config.vm.provision "shell", inline: timezone_cmd
#         end
#     end
# 
#     # not working yet hostname
#     #local_config["servers"].each do |tsk, this_server|
#     #    hostname_cmd = "echo \"" + this_server["guest_ip"] + " " + this_server["guest_hostname"] + "\" >> /etc/hosts"
#     #    config.vm.provision "shell", inline: hostname_cmd
#     #end
# 
#     if local_config.has_key?("hosts")
#         local_config["hosts"].each do |this_host, this_ip|
#             hostname_cmd = "echo \"" + this_ip + " " + this_host + "\" >> /etc/hosts"
#             config.vm.provision "shell", inline: hostname_cmd
#         end
#     end
# 
# # pass any parameters the shell scripts will need into a local keypair file as parameter passing in vagrant seems unreliable in all relases
# 
# 	if server["debug"] === "true"
# 		puts "Debug: passing keypairs to the VM"
# 	end
# 	addkeypair("gituser", server["gituser"], instance, server)
# 	addkeypair("gitemail", server["gitemail"], instance, server)
# 	addkeypair("makeopts", server["makeopts"], instance, server)
# 
# # here we call a function to sort out the github key based on the config file 
#      replacekey(instance, server, local_config, config)
# 
#     # Box-specific
#     if server.has_key?("scripts")
#         server["scripts"].each do |script, key|
#             if script.is_a?(String)
#                 serverScript = "/vagrant/scripts/" + script + " 2&>1 >> /vagrant/provision.log"
#                 puts "*****************************************************************************"
#                 puts "Adding a configuration file to the list, monitor with 'tail -f provision.log'"
#                 puts "*****************************************************************************"
#                 instance.vm.provision "shell", inline: serverScript
#             else
#                 if script.has_key?("inline")
#                     if script.has_key?("run") && script["run"] === "always"
#                         config.vm.provision "shell", run: "always" do |s|
#                             s.inline = script["inline"]
#                         end
#                     else
#                         instance.vm.provision "shell", inline: script["inline"]
#                     end
#                 else
#                     serverScript = "/vagrant/scripts/" + script["script"] + " 2&>1 >> /vagrant/provision.log"
#                     if script.has_key?("run") && script["run"] === "always"
#                         config.vm.provision "shell", run: "always" do |s|
#                             s.inline = serverScript
#                         end
#                     else
#                         serverScript = "/vagrant/scripts/" + script["script"] + " 2&>1 >> /vagrant/provision.log"
#                         instance.vm.provision "shell", inline: serverScript
#                     end
#                 end
#             end
#         end
#     end
# 
end
