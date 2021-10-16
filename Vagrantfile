# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    lua_version = "5.4.2"  # 5.4.3 is out but raises lua: /usr/local/share/lua/5.4/socket/http.lua:38: bad argument #1 to 'receive' (string expected, got light userdata)
    luarocks_version = "3.7.0"

    hostname = "lua.box"
    locale = "en_GB.UTF.8"

    # Box
    config.vm.box = "ubuntu/impish64"

    # Shared folder
    config.vm.synced_folder ".", "/srv"

    # Change directory to shared folder directory when connecting using vagrant ssh
    config.ssh.extra_args = ["-t", "cd /srv; bash --login"]

    # Setup
    config.vm.provision "setup", type: "shell", inline: <<-SHELL
        touch .hushlogin
        if ! grep -q "cd /srv" ~/.bashrc ; then 
            echo "cd /srv" >> ~/.bashrc 
        fi
        hostnamectl set-hostname #{hostname} && locale-gen #{locale}
        apt-get update --fix-missing
        apt-get install -q -y build-essential libreadline-dev unzip g++ make git curl vim
    SHELL

    # Lang
    ## Lua
    config.vm.provision "lua", type: "shell", inline: <<-SHELL
        curl -R -O http://www.lua.org/ftp/lua-#{lua_version}.tar.gz
        tar -zxf lua-#{lua_version}.tar.gz
        rm -f lua-#{lua_version}.tar.gz
        cd lua-#{lua_version}
        make linux test
        make install
        # rm -rf lua-#{lua_version}
    SHELL

    ## LuaRocks
    config.vm.provision "luarocks", type: "shell", inline: <<-SHELL
        wget https://luarocks.org/releases/luarocks-#{luarocks_version}.tar.gz
        tar zxpf luarocks-#{luarocks_version}.tar.gz
        rm -f luarocks-#{luarocks_version}.tar.gz
        cd luarocks-#{luarocks_version}
        ./configure --with-lua-include=/usr/local/include
        make
        make install
        # rm -rf luarocks-#{luarocks_version}
    SHELL

    # Lua application dependencies
    config.vm.provision "lua_app_deps", type: "shell", inline: <<-SHELL
        luarocks install luasocket
        apt-get install -q -y libssl-dev
        luarocks install luasec
    SHELL

    # Lua application
    config.vm.provision "lua_app", type: "shell", inline: <<-SHELL
        cd /srv
        lua download_sia_vac.lua
    SHELL

end
