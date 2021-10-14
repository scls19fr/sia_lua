# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    # lua_version_major_minor = "5.4"
    lua_version = "5.4.3"
    luarocks_version = "3.7.0"

    hostname = "lua.box"
    locale = "en_GB.UTF.8"

    # Box
    config.vm.box = "ubuntu/impish64"

    # Shared folders
    config.vm.synced_folder ".", "/srv"

    # Setup
    config.vm.provision :shell, :inline => "touch .hushlogin"
    config.vm.provision :shell, :inline => "hostnamectl set-hostname #{hostname} && locale-gen #{locale}"
    config.vm.provision :shell, :inline => "apt-get update --fix-missing"
    config.vm.provision :shell, :inline => "apt-get install -q -y build-essential libreadline-dev unzip g++ make git curl vim"

    # Lang
    ## Lua
    #config.vm.provision :shell, :inline => "apt-get install -q -y lua#{lua_version_major_minor}"
    config.vm.provision :shell, :inline => "curl -R -O http://www.lua.org/ftp/lua-#{lua_version}.tar.gz"
    config.vm.provision :shell, :inline => "tar -zxf lua-#{lua_version}.tar.gz"
    config.vm.provision :shell, :inline => "rm -f lua-#{lua_version}.tar.gz"
    config.vm.provision :shell, :inline => "cd lua-#{lua_version}"
    #config.vm.provision :shell, :inline => "make linux test" # default: make: *** No rule to make target 'linux'.  Stop.
    #config.vm.provision :shell, :inline => "make linux" #  default: make: *** No rule to make target 'linux'.  Stop.
    #config.vm.provision :shell, :inline => "make install"

    ## LuaRocks
    config.vm.provision :shell, :inline => "wget https://luarocks.org/releases/luarocks-#{luarocks_version}.tar.gz"
    config.vm.provision :shell, :inline => "tar zxpf luarocks-#{luarocks_version}.tar.gz"
    config.vm.provision :shell, :inline => "rm -f luarocks-#{luarocks_version}.tar.gz"
    config.vm.provision :shell, :inline => "cd luarocks-#{luarocks_version}"
    config.vm.provision :shell, :inline => "./configure --with-lua-include=/usr/local/include"
    config.vm.provision :shell, :inline => "make"
    config.vm.provision :shell, :inline => "make install"
end
