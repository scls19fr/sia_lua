local airac = {}

local date = require("date")

local AIRAC_INTERVAL_DAYS = 28
local AIRAC_INITIAL_DATE = date(2015, 1, 8)

local function airac_date(dt)
    if dt == nil then
        dt = date(true)
    end
    print(dt)
    return AIRAC_INITIAL_DATE:adddays(math.floor((dt - AIRAC_INITIAL_DATE):spandays() // AIRAC_INTERVAL_DAYS) * AIRAC_INTERVAL_DAYS)
end

airac.airac_date = airac_date

return airac