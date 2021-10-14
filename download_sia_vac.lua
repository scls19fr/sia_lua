local BASE_URL_SIA = "https://www.sia.aviation-civile.gouv.fr"

local http = require("socket.http")

function download_sia_vac(code)
    -- local airac_string = format_french_date(dt_airac)
    local airac_string = "07_OCT_2021"
    local endpoint = string.format("/dvd/eAIP_%s/Atlas-VAC/PDF_AIPparSSection/VAC/AD/AD-2.%s.pdf", airac_string, code);
    local url = BASE_URL_SIA .. endpoint;
    print(string.format("Download VAC from %s", url))
    local body, ret_code = http.request(url);
    if not body then error(ret_code) end
    local fname = string.format("AD-2.%s.pdf", code);
    local f = assert(io.open(fname, 'wb')) -- open in "binary" mode
    f:write(body)
    return f:close();
end

print(BASE_URL_SIA)
print(download_sia_vac("LFBI"))
