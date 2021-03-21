def checkplugins(server, local_config, config)

     unless Vagrant.has_plugin?("vagrant-share")
         raise "`vagrant-share` is a required plugin. Install it by running: vagrant plugin install vagrant-share"
     end
     
     unless Vagrant.has_plugin?("vagrant-hostmanager")
         raise "`vagrant-hostmanager` is a required plugin. Install it by running: vagrant plugin install vagrant-hostmanager"
     end
     
     if server["provider"] === "vcenter" 
     	unless Vagrant.has_plugin?("vagrant-vcenter")
     		raise "Warning: If you are planning to use vcenter then you will need to add the plugin. Install it by running: vagrant plugin vagrant-vcenter"
     	end
     end
     
     if server["provider"] === "aws" 
     	unless Vagrant.has_plugin?("vagrant-aws")
     		raise "Warning: If you are planning to use aws then you will need to add the plugin. Install it by running: vagrant plugin vagrant-aws"
     	end
     end
     
     if server["provider"] === "vsphere" 
     	unless Vagrant.has_plugin?("vagrant-vsphere")
     		raise "Warning: If you are planning to use vsphere then you will need to add the plugin. Install it by running: vagrant plugin vagrant-vsphere"
     	end
     end
return
end

