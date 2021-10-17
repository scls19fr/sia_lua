local BASE_URL_SIA = "https://www.sia.aviation-civile.gouv.fr"

local https = require("ssl.https")

local function download_sia_vac(oaci_code)
    -- local airac_string = format_french_date(dt_airac)
    local airac_string = "07_OCT_2021"
    local endpoint = string.format("/dvd/eAIP_%s/Atlas-VAC/PDF_AIPparSSection/VAC/AD/AD-2.%s.pdf", airac_string, oaci_code)
    local url = BASE_URL_SIA .. endpoint
    print(string.format("Download VAC from %s", url))
    local body, code, headers, status = https.request(url)
    if not body then error(code) end
    local fname = string.format("AD-2.%s.pdf", oaci_code)
    local f = assert(io.open(fname, 'wb')) -- open in "binary" mode
    f:write(body)
    return f:close()
end

print(BASE_URL_SIA)
print(download_sia_vac("LFBI"))
