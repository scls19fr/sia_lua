local argparse = require("argparse")
local utils = require("utils")
local sia = require("sia")

local parser = argparse("download_sia_vac", "Download VAC of french AD from SIA.")
parser:argument("code", "ICAO AD code.")
local args = parser:parse()

for _, icao_code in ipairs(utils.split(args.code, ",")) do
    local status, err = pcall(sia.download_sia_vac, icao_code)
    if not status then
        print("error with " .. icao_code)
    end
end
