local sia = {}

local airac = require("airac")
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

sia.BASE_URL_SIA = BASE_URL_SIA
sia.download_sia_vac = download_sia_vac

return sia