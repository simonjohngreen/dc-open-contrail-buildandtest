# -*- mode: ruby -*-
# vi: set ft=ruby :

# load library files 
require_relative "lib/config_global.rb"
require_relative "lib/required_plugins.rb"
require_relative "lib/config_virtualbox.rb"
require_relative "lib/config_vcenter.rb"
require_relative "lib/config_loader.rb"
require_relative "lib/os_detector.rb"
require_relative "lib/log_writer.rb"
require_relative "lib/defaults.rb"
require_relative "lib/on_exit.rb"
require_relative "lib/replace_key.rb"
require_relative "lib/keypairs.rb"

local_config = loadConfig();
local_config = detectOS(local_config)

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

#    config.vm.provider :vcenter do |vcenter|
#       vcenter.hostname = '192.168.1.45'
#       vcenter.username = 'root'
#       vcenter.password = 'simon123'
# #      vcenter.folder_name = 'myFolderName'
#       vcenter.datacenter_name = 'HomeServer'
#       vcenter.computer_name = 'HomeServer1'
#       vcenter.datastore_name = 'datastore1'
#       vcenter.network_name = 'MGMT'
#       vcenter.linked_clones = true
#     end
# 
 
  # This is cosmetic, it fixes a stdout tty error you see every few lines
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # Add a post startup message
  config.vm.post_up_message = "**To watch the build 'tail -f provision.log'** "

  # Check that local default parameters are set 
  local_config = checkDefaults(local_config)

  # loop through the servers defined in config.defaults.json and if enabled provision them 
  local_config["servers"].each do |server_id, server|

        server = checkServerDefaults(server)


 	if server["debug"] === "true"
		puts "Debug: ***********************************" 
		puts "Debug: guest_hostname " + server["guest_hostname"]
		puts "Debug: Enabled " + server["enabled"]
		puts "Debug: Provider " + server["provider"]
		puts "Debug: box " + server["box"]
		puts "Debug: timezone " + server["timezone"]
		puts "Debug: gui " + server["gui"]
		puts "Debug: makeopts " + server["makeopts"]
		puts "Debug: cpus #{server["cpus"]} "
		puts "Debug: memory #{server["memory"]} "
	end

        if server["enabled"] == "false"
		if server["debug"] === "true"
                	puts "Debug: skipping VM as its not enabled" 
		end
            next
        end

	checkplugins(server, local_config, config)

	if server["debug"] === "true"
		puts "Debug: Assigning VM as its enabled" 
	end

        config.vm.define server_id, primary: server["primary"], autostart: server["autostart"] do |instance|
            case server["provider"]
                when "virtualbox"
                    configVirtualBox(instance, server, local_config, config)
                when "vcenter"
                    configVcenter(instance, server, local_config, config)
                    #configVirtualBox(instance, server, local_config, config)
                else
                    puts "Error: Unknown provider specified: " + server["provider"]
            end
            configGlobal(instance, server, local_config, config)
        end

    end

end
