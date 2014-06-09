# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.define :OctoberCMS do |octoberCms_config|
        octoberCms_config.vm.box = "precise32"
        octoberCms_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
        octoberCms_config.ssh.forward_agent = true
        
        # This will give the machine a static IP uncomment to enable
        # octoberCms_config.vm.network :private_network, ip: "192.168.56.101"
        
        octoberCms_config.vm.network :forwarded_port, guest: 80, host: 8888, auto_correct: true
        octoberCms_config.vm.network :forwarded_port, guest: 3306, host: 8889, auto_correct: true
        octoberCms_config.vm.network :forwarded_port, guest: 5432, host: 5433, auto_correct: true
        octoberCms_config.vm.network :forwarded_port, guest: 1080, host: 1080, auto_correct: true
        octoberCms_config.vm.network :forwarded_port, guest: 1025, host: 1025, auto_correct: true
        octoberCms_config.vm.hostname = "OctoberCMS"
        octoberCms_config.vm.synced_folder "www", "/var/www", {:mount_options => ['dmode=777','fmode=777']}
        octoberCms_config.vm.provision :shell, :inline => "echo \"Europe/London\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

        octoberCms_config.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--memory", "512"]
        end

        octoberCms_config.vm.provision :puppet do |puppet|
            puppet.manifests_path = "puppet/manifests"
            puppet.manifest_file  = "phpbase.pp"
            puppet.module_path = "puppet/modules"
            #puppet.options = "--verbose --debug"
        end

        octoberCms_config.vm.provision :shell, :path => "puppet/scripts/enable_remote_mysql_access.sh"
        octoberCms_config.vm.provision :shell, :path => "bootstrap.sh"
    end

end