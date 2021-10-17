local csv = require("csv")
local inspect = require("inspect")
local argparse = require("argparse")
local sia = require("sia")

local parser = argparse("download_sia_vac_all", "Download all VAC of french AD from SIA.")
parser:option("-i --input", "Input file (France.cup).", "France.cup")
local args = parser:parse()

local f = csv.open(args.input, {
    separator = ',',
    header = false,
})

local pattern = "LF[A-Z][A-Z]"
for fields in f:lines() do
    -- print(inspect(fields))
    if string.match(fields[2], pattern) then
        local icao_code = fields[2]
        sia.download_sia_vac(icao_code)
    end
end
