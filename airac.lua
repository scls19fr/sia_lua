local airac = {}

local date = require("date")

local AIRAC_INTERVAL_DAYS = 28
local AIRAC_INITIAL_DATE = date(2015, 1, 8)

local function airac_date(dt)
    if dt == nil then
        dt = date(true)
    end
    return AIRAC_INITIAL_DATE:adddays(math.floor((dt - AIRAC_INITIAL_DATE):spandays() // AIRAC_INTERVAL_DAYS) * AIRAC_INTERVAL_DAYS)
end

local function iso_date(d)
    return string.format("%04d-%02d-%02d", d:getisoyear(), d:getmonth(), d:getday())
end

airac.airac_date = airac_date
airac.iso_date = iso_date

return airac
