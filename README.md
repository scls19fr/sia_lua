# sia_lua

A [Lua](https://www.lua.org/) script to download VAC from [SIA (Service de l'information aéronautique)](https://www.sia.aviation-civile.gouv.fr/) website.

# Usage

## Download a VAC using a specific ICAO code
```bash
lua download_sia_vac.lua LFBI
```

## Download all VAC
```bash
./download_france_cup.sh
lua download_sia_vac_all.lua
```

## Development

A [Lua](https://www.lua.org/) / [LuaRocks](https://luarocks.org/) environment can be set using [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) virtual machines (VM)

```bash
vagrant up
```

You can enter into VM using

```bash
vagrant ssh
```

Each provisioners are defined in `Vagrantfile` and can be called separately if required using:

```bash
vagrant provision --provision-with lua_app
```
