local ADDON_NAME, ns = ...

ns.Units = {
    hour = {
        s = "hour",
        p = "hours",
        a = "hr.",
        t = "h",
    },
    minute = {
        s = "minute",
        p = "minutes",
        a = "min.",
        t = "m",
    },
    second = {
        s = "second",
        p = "seconds",
        a = "sec.",
        t = "s",
    },
}

-- Check locale and apply appropriate changes below
local CURRENT_LOCALE = GetLocale()

-- XXXX
-- if CURRENT_LOCALE == "xxXX" then
--     ns.Units = {}
-- end