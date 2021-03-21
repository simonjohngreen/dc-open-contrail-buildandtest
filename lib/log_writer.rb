#helps with a problem where tail has to be restarted
if !File.exists?("provision.log")
    File.open("provision.log", "w") {}
end
