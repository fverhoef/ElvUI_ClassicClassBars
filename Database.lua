local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)

Addon.database = {
    Mage = {
        Portals = {
            10059, -- Stormwind
            11416, -- Ironforge
            11419, -- Darnassus
            32266, -- Exodar
            49360, -- Theramore
            33691, -- Shattrath (Alliance)
            11417, -- Orgrimmar
            11418, -- Undercity
            11420, -- Thunder Bluff
            32267, -- Silvermoon
            49361, -- Stonard
            35717 -- Shattrath (Horde)
        },
        Teleports = {
            3561, -- Stormwind
            3562, -- Ironforge
            3565, -- Darnassus
            32271, -- Exodar
            49359, -- Theramore
            33690, -- Shattrath (Alliance)
            3567, -- Orgrimmar
            3563, -- Undercity
            3566, -- Thunder Bluff
            32272, -- Silvermoon
            49358, -- Stonard
            35715 -- Shattrath (Horde)
        },
        ConjureFood = {587, 597, 990, 6129, 10144, 10145, 28612, 33717},
        ConjureWater = {5504, 5505, 5506, 6127, 10138, 10139, 10140, 37420, 27090},
        ConjureTable = {43987},
        ConjureGem = {759, 3552, 10053, 10054, 27101},
        Polymorph = {118, 12824, 12825, 12826},
        PolymorphPig = {28272},
        PolymorphTurtle = {28271},
        Armors = {},
        ["Frost Armor"] = {168, 7300, 7301},
        ["Ice Armor"] = {7302, 7320, 10219, 10220, 27124},
        ["Mage Armor"] = {6117, 22782, 22783, 27125},
        ["Molten Armor"] = {30482}
    },
    Shaman = {
        FireTotems = {},
        ["Fire Nova Totem"] = {1535, 8498, 8499, 11314, 11315},
        ["Magma Totem"] = {8190, 10585, 10586, 10587},
        ["Searing Totem"] = {3599, 6363, 6364, 6365, 10437, 10438},
        ["Flametongue Totem"] = {8227, 8249, 10526, 16387},
        ["Frost Resistance Totem"] = {8181, 10478, 10479},

        EarthTotems = {},
        ["Earthbind Totem"] = {2484},
        ["Stoneclaw Totem"] = {5730, 6390, 6391, 6392, 10427, 10428},
        ["Stoneskin Totem"] = {8071, 8154, 8155, 10406, 10407, 10408},
        ["Strength of Earth Totem"] = {8075, 8160, 8161, 10442, 25361},
        ["Tremor Totem"] = {8143},

        WaterTotems = {},
        ["Poison Cleansing Totem"] = {8166},
        ["Disease Cleansing Totem"] = {8170},
        ["Fire Resistance Totem"] = {8184, 10537, 10538},
        ["Healing Stream Totem"] = {5394, 6375, 6377, 10462, 10463},
        ["Mana Spring Totem"] = {5675, 10495, 10496, 10497},
        ["Mana Tide Totem"] = {16190, 17354, 17359},

        AirTotems = {},
        ["Grace of Air Totem"] = {8835, 10627, 25359},
        ["Grounding Totem"] = {8177},
        ["Nature Resistance Totem"] = {10595, 10600, 10601},
        ["Sentry Totem"] = {6495},
        ["Tranquil Air Totem"] = {25908},
        ["Windfury Totem"] = {8512, 10613, 10614},
        ["Windwall Totem"] = {15107, 15111, 15112},

        WeaponEnchants = {},
        ["Rockbiter Weapon"] = {8017, 8018, 8019, 10399, 16314, 16315, 16316},
        ["Flametongue Weapon"] = {8024, 8027, 8030, 16339, 16341, 16342},
        ["Frostbrand Weapon"] = {8033, 8038, 10456, 16355, 16356},
        ["Windfury Weapon"] = {8232, 8235, 10486, 16362}
    }
}

-- build spell rank tables
local spellRankTables = {
    Addon.database.Mage.ConjureFood,
    Addon.database.Mage.ConjureWater,
    Addon.database.Mage.ConjureGem,
    Addon.database.Mage.Polymorph,
    Addon.database.Mage["Mage Armor"],
    Addon.database.Mage["Molten Armor"]
}

-- frost and ice armor count as the same spell
local frostAndIceArmor = {}
for i, id in next, Addon.database.Mage["Frost Armor"] do
    table.insert(frostAndIceArmor, id)
end
for i, id in next, Addon.database.Mage["Ice Armor"] do
    table.insert(frostAndIceArmor, id)
end
table.insert(spellRankTables, frostAndIceArmor)

-- build combined mage armor table
for _, id in ipairs(Addon.database.Mage["Frost Armor"]) do
    table.insert(Addon.database.Mage.Armors, id)
end
for _, id in ipairs(Addon.database.Mage["Ice Armor"]) do
    table.insert(Addon.database.Mage.Armors, id)
end
for _, id in ipairs(Addon.database.Mage["Mage Armor"]) do
    table.insert(Addon.database.Mage.Armors, id)
end
for _, id in ipairs(Addon.database.Mage["Molten Armor"]) do
    table.insert(Addon.database.Mage.Armors, id)
end

-- build shaman totem/enchant tables
local fireTotems = {"Fire Nova Totem", "Magma Totem", "Searing Totem", "Flametongue Totem", "Frost Resistance Totem"}
for _, name in ipairs(fireTotems) do
    local rankTable = Addon.database.Shaman[name]
    table.insert(spellRankTables, rankTable)

    for _, id in ipairs(rankTable) do
        table.insert(Addon.database.Shaman.FireTotems, id)
    end
end

local earthTotems = {"Earthbind Totem", "Stoneclaw Totem", "Stoneskin Totem", "Strength of Earth Totem", "Tremor Totem"}
for _, name in ipairs(earthTotems) do
    local rankTable = Addon.database.Shaman[name]
    table.insert(spellRankTables, rankTable)

    for _, id in ipairs(rankTable) do
        table.insert(Addon.database.Shaman.EarthTotems, id)
    end
end

local waterTotems = {
    "Poison Cleansing Totem",
    "Disease Cleansing Totem",
    "Fire Resistance Totem",
    "Healing Stream Totem",
    "Mana Spring Totem",
    "Mana Tide Totem"
}
for _, name in ipairs(waterTotems) do
    local rankTable = Addon.database.Shaman[name]
    table.insert(spellRankTables, rankTable)

    for _, id in ipairs(rankTable) do
        table.insert(Addon.database.Shaman.WaterTotems, id)
    end
end

local airTotems = {
    "Grace of Air Totem",
    "Grounding Totem",
    "Nature Resistance Totem",
    "Sentry Totem",
    "Tranquil Air Totem",
    "Windfury Totem",
    "Windwall Totem"
}
for _, name in ipairs(airTotems) do
    local rankTable = Addon.database.Shaman[name]
    table.insert(spellRankTables, rankTable)

    for _, id in ipairs(rankTable) do
        table.insert(Addon.database.Shaman.AirTotems, id)
    end
end

local weaponEnchants = {"Rockbiter Weapon", "Flametongue Weapon", "Frostbrand Weapon", "Windfury Weapon"}
for _, name in ipairs(weaponEnchants) do
    local rankTable = Addon.database.Shaman[name]
    table.insert(spellRankTables, rankTable)

    for _, id in ipairs(rankTable) do
        table.insert(Addon.database.Shaman.WeaponEnchants, id)
    end
end

function Addon:GetMaxKnownRank(spellId)
    local maxKnownRank
    for i, rankTable in next, spellRankTables do
        local matchedSpell
        for j, id in next, rankTable do
            if id == spellId then
                maxKnownRank = id
                matchedSpell = true
            elseif matchedSpell and IsSpellKnown(id) then
                maxKnownRank = id
            end
        end

        if matchedSpell then
            break
        end
    end

    return maxKnownRank
end

function Addon:IsMaxKnownRank(spellId)
    return Addon:GetMaxKnownRank(spellId) == spellId
end

function Addon:GetKnownActionCount(actions, onlyMaxRank)
    local known = 0
    for i, action in ipairs(actions) do
        if IsSpellKnown(action) and (not onlyMaxRank or Addon:IsMaxKnownRank(action)) then
            known = known + 1
        end
    end

    return known
end

function Addon:FindTotem(totemName)
    local totemId

    local totem = Addon.database.Shaman[totemName]
    if totem then
        for index, id in next, totem do
            if IsSpellKnown(id) then
                totemId = id
            end
        end
    end

    return totemId
end
