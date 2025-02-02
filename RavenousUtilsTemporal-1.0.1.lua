local ADDON_NAME, ns = ...

local hour = ns.Units.hour
local minute = ns.Units.minute
local second = ns.Units.second

--- Formats a duration in seconds to a "Xm Xs" string
-- @param {any} key
-- @param {number} duration
-- @param {number|string} [timeFormat]
-- @return {string}
function ns:DurationFormat(key, duration, timeFormat)
    timeFormat = timeFormat ~= nil and timeFormat or ns:OptionValue(key, "timeFormat")
    local hours = math.floor(duration / 3600)
    local minutes = math.floor(math.fmod(duration, 3600) / 60)
    local seconds = math.fmod(duration, 60)
    local h, m, s
    if timeFormat == 3 or timeFormat == "long" then
        h = " " .. (hours > 1 and hour.p or hour.s)
        m = " " .. (minutes > 1 and minute.p or minute.s)
        s = " " .. (seconds > 1 and second.p or second.s)
    elseif timeFormat == 2 or timeFormat == "short" then
        h = " " .. hour.a
        m = " " .. minute.a
        s = " " .. second.a
    else
        h = hour.t
        m = minute.t
        s = second.t
    end
    if hours > 0 then
        if minutes > 0 then
            return string.format("%d" .. h .. ((timeFormat == 3 or timeFormat == "long") and "," or "") .. " %d" .. m, hours, minutes)
        end
        return string.format("%d" .. h, hours)
    end
    if minutes > 0 then
        if seconds > 0 then
            return string.format("%d" .. m .. ((timeFormat == 3 or timeFormat == "long") and "," or "") .. " %d" .. s, minutes, seconds)
        end
        return string.format("%d" .. m, minutes)
    end
    return string.format("%d" .. s, seconds)
end

--- Format a timestamp to a local time string
-- @param {number} timestamp
-- @param {boolean} [includeSeconds]
-- @return {string}
function ns:TimeFormat(timestamp, includeSeconds)
    local useMilitaryTime = GetCVar("timeMgrUseMilitaryTime") == "1"
    local timeFormat = useMilitaryTime and ("%H:%M" .. (includeSeconds and ":%S" or "")) or ("%I:%M" .. (includeSeconds and ":%S" or "") .. "%p")
    local time = date(timeFormat, timestamp)

    -- Remove starting zero from non-military time
    if not useMilitaryTime then
        time = time:gsub("^0", ""):lower()
    end

    return time
end
