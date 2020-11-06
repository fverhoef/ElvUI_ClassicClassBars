local addonName, addonTable = ...
local Module = addonTable[1]

Module.database = {
    Mage = {
        Portals = {
            Alliance = {
                10059, -- Stormwind
                11416, -- Ironforge
                11419 -- Darnassus
            },
            Horde = {
                11417, -- Orgrimmar
                11418, -- Undercity
                11420 -- Thunder Bluff
            }
        },
        Teleports = {
            Alliance = {
                3561, -- Stormwind
                3562, -- Ironforge
                3565 -- Darnassus
            },
            Horde = {
                3567, -- Orgrimmar
                3563, -- Undercity
                3566 -- Thunder Bluff
            }
        },
        ConjureFood = {587, 597, 990, 6129, 10144, 10145, 28612},
        ConjureWater = {5504, 5505, 5506, 6127, 10138, 10139, 10140},
        ConjureGem = {759, 3552, 10053, 10054},
        PolymorphSheep = {118, 12824, 12825, 12826},
        PolymorphPig = {28272},
        PolymorphTurtle = {28271}
    },
    Shaman = {
        FireTotems = {
            ["Fire Nova Totem"] = {1535, 8498, 8499, 11314, 11315},
            ["Magma Totem"] = {8190, 10585, 10586, 10587},
            ["Searing Totem"] = {3599, 6363, 6364, 6365, 10437, 10438},
            ["Flametongue Totem"] = {8227, 8249, 10526, 16387},
            ["Frost Resistance Totem"] = {8181, 10478, 10479}
        },

        EarthTotems = {
            ["Earthbind Totem"] = {2484},
            ["Stoneclaw Totem"] = {5730, 6390, 6391, 6392, 10427, 10428},
            ["Stoneskin Totem"] = {8071, 8154, 8155, 10406, 10407, 10408},
            ["Strength of Earth Totem"] = {8075, 8160, 8161, 10442, 25361},
            ["Tremor Totem"] = {8143}
        },

        WaterTotems = {
            ["Poison Cleansing Totem"] = {8166},
            ["Disease Cleansing Totem"] = {8170},
            ["Fire Resistance Totem"] = {8184, 10537, 10538},
            ["Healing Stream Totem"] = {5394, 6375, 6377, 10462, 10463},
            ["Mana Spring Totem"] = {5675, 10495, 10496, 10497},
            ["Mana Tide Totem"] = {16190, 17354, 17359}
        },

        AirTotems = {
            ["Grace of Air Totem"] = {8835, 10627, 25359},
            ["Grounding Totem"] = {8177},
            ["Nature Resistance Totem"] = {10595, 10600, 10601},
            ["Sentry Totem"] = {6495},
            ["Tranquil Air Totem"] = {25908},
            ["Windfury Totem"] = {8512, 10613, 10614},
            ["Windwall Totem"] = {15107, 15111, 15112}
        },

        WeaponEnchants = {
            ["Rockbiter Weapon"] = {8017, 8018, 8019, 10399, 16314, 16315, 16316},
            ["Flametongue Weapon"] = {8024, 8027, 8030, 16339, 16341, 16342},
            ["Frostbrand Weapon"] = {8033, 8038, 10456, 16355, 16356},
            ["Windfury Weapon"] = {8232, 8235, 10486, 16362}
        }
    }
}

local spellRankTables = {Module.database.Mage.ConjureFood, Module.database.Mage.ConjureWater, Module.database.Mage.ConjureGem, Module.database.Mage.PolymorphSheep}
for i, totemRankTable in next, Module.database.Shaman.FireTotems do
    table.insert(spellRankTables, totemRankTable)
end
for i, totemRankTable in next, Module.database.Shaman.EarthTotems do
    table.insert(spellRankTables, totemRankTable)
end
for i, totemRankTable in next, Module.database.Shaman.WaterTotems do
    table.insert(spellRankTables, totemRankTable)
end
for i, totemRankTable in next, Module.database.Shaman.AirTotems do
    table.insert(spellRankTables, totemRankTable)
end
for i, totemRankTable in next, Module.database.Shaman.WeaponEnchants do
    table.insert(spellRankTables, totemRankTable)
end

function Module:GetMaxKnownRank(spellId)
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

function Module:IsMaxKnownRank(spellId)
    return Module:GetMaxKnownRank(spellId) == spellId
end

function Module:FindTotem(totemName)
    local totem = Module.database.Shaman.FireTotems[totemName] or Module.database.Shaman.EarthTotems[totemName] or Module.database.Shaman.WaterTotems[totemName] or
                      Module.database.Shaman.AirTotems[totemName]

    local totemId
    if totem then
        for index, id in next, totem do
            if IsSpellKnown(id) then
                totemId = id
            end
        end
    end

    return totemId
end
