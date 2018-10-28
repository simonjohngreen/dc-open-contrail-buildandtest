
def replacekey(instance, server, local_config, config)
	if server["replacekey"] === "true" && server["keytype"] === "untrusted"
		if server["debug"] === "true"
	       		puts "Debug: Copy untrusted default git keys to the VM" 
		end
		if File.file?("./insecurekey/id_rsa")
        		instance.vm.provision "file", source: "./insecurekey/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
			instance.vm.provision "shell", inline: "sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa && sudo chmod 600 /home/vagrant/.ssh/id_rsa"
			if server["debug"] === "true"
                       		puts "Debug: replaced id_rsa"
                end
    		else
			if server["debug"] === "true"
                       		puts "Debug: Could not Swapping out public key as it was not in /insecurekey"
                        end
		end
		if File.file?("./insecurekey/id_rsa.pub")
        		instance.vm.provision "file", source: "./insecurekey/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub"
 			instance.vm.provision "shell", inline: "sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa.pub && sudo chmod 644 /home/vagrant/.ssh/id_rsa.pub"
			if server["debug"] === "true"
				puts "Debug: replaced id_rsa.pub"
			end
		else
			if server["debug"] === "true"
                       		puts "Debug: Could not Swapping out private key as it was not in /insecurekey"
                       end
		end
	end
# this bit still needs sorting out. not tested this case yet
	if server["replacekey"] === "true" && server["keytype"] === "local"
		if server["debug"] === "true"
	       		puts "Debug: copy the hosts local keys out to the VM " 
		end
		if File.file?(ENV['HOME'] + "/.gitconfig")
			instance.vm.provision "file", source: ENV['HOME'] + "/.gitconfig", destination: "/home/vagrant/.gitconfig"
			instance.vm.provision "file", source: ENV['HOME'] + "/.gitconfig", destination: "/tmp/.gitconfig"
			instance.vm.provision "shell", inline: "sudo mv /tmp/.gitconfig /root/.gitconfig && chown root:root /root/.gitconfig"
		else
			puts ENV['HOME'] + "/.gitconfig not found"
		end
		if (server.has_key?("github_private_key_file") && !server["github_private_key_file"].nil? && !server["github_private_key_file"].empty?)
			instance.vm.provision "file", source: server["github_private_key_file"], destination: "/home/vagrant/.ssh/id_rsa"
			instance.vm.provision "file", source: server["github_private_key_file"], destination: "/tmp/id_rsa"
			instance.vm.provision "shell", inline: "chown vagrant:vagrant /home/vagrant/.ssh/id_rsa"
			instance.vm.provision "shell", inline: "sudo mv /tmp/id_rsa /root/.ssh/id_rsa && sudo chown root:root /root/.ssh/id_rsa && sudo chmod 600 /root/.ssh/id_rsa"
		end
	end
	if server["replacekey"] === "false" 
		if server["debug"] === "true"
	       		puts "Debug: generating local keys on the VM " 
	       		puts "The public key will need to exist within the git user" 
		end
       		instance.vm.provision "shell", inline: "su - vagrant -c 'mkdir -p /home/vagrant/contrail'"
       		instance.vm.provision "shell", inline: "su - vagrant -c 'ssh-keygen -f .ssh/id_rsa -P ""'"
       		instance.vm.provision "shell", inline: "eval `ssh-agent`"
	       	instance.vm.provision "shell", inline: "ssh-add"
	end
return
end
