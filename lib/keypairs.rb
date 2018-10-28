# passing args into shell scripts doesn't seem to work well in vagarant so instead we'll pass parameters via a keypairs file on the box OS

def addkeypair(key, value, instance, server)
	if server["debug"] === "true"
		puts "Debug: adding keypair to /home/vagrant/keypairs " + key + " " + value
	end
			instance.vm.provision "shell", inline: "echo " + key + "=" + value + ">> /home/vagrant/keypairs"
return
end
