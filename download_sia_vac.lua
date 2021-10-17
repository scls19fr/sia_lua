local argparse = require "argparse"
local https = require("ssl.https")

local BASE_URL_SIA = "https://www.sia.aviation-civile.gouv.fr"

local function download_sia_vac(icao_code)
    -- local airac_string = format_french_date(dt_airac)
    local airac_string = "07_OCT_2021"
    local endpoint = string.format("/dvd/eAIP_%s/Atlas-VAC/PDF_AIPparSSection/VAC/AD/AD-2.%s.pdf", airac_string, icao_code)
    local url = BASE_URL_SIA .. endpoint
    print(string.format("Download %s VAC from %s", icao_code, url))
    local body, code, headers, status = https.request(url)
    if not body then error(code) end
    local fname = string.format("AD-2.%s.pdf", icao_code)
    local f = assert(io.open(fname, 'wb')) -- open in "binary" mode
    f:write(body)
    return f:close()
end

local function split(s, delimiter)
    local result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

local parser = argparse("download_sia_vac", "Download VAC of french AD from SIA.")
parser:argument("code", "ICAO AD code.")
local args = parser:parse()

for _, icao_code in ipairs(split(args.code, ",")) do
    download_sia_vac(icao_code)
end
