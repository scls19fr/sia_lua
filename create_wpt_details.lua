local csv = require("csv")
local argparse = require("argparse")
local sia = require("sia")
local mil_ad = require("mil_ad")

local parser = argparse("create_wpt_details", "Create waypoint details file.")
parser:option("-i --input", "Input file (France.cup).", "France.cup")
local args = parser:parse()

local f_ad = csv.open(args.input, {
    separator = ',',
    header = false,
})

local fname = "WPT_DETAILS.txt"
local f_wpt_details = assert(io.open(fname, 'w'))

local pattern = "LF[A-Z][A-Z]"
for fields in f_ad:lines() do
    -- print(inspect(fields))
    if string.match(fields[2], pattern) then
        local icao_code = fields[2]
        f_wpt_details:write(string.format("[%s]", icao_code), "\n")
        f_wpt_details:write(string.format("file=vac/%s.pdf", icao_code), "\n")
        if mil_ad.MIL_AD[icao_code] == nil then
        else -- is a mil AD
            f_wpt_details:write("MILITARY AD", "\n")
        end
        f_wpt_details:write("\n")
    end
end

f_wpt_details:close()