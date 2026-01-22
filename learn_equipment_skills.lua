-- Proficiency unlocker for Acherus
-- Teaches all armor and weapon proficiencies to new characters

local function AddAllProficiencies(event, player)
    local level = player:GetLevel()
    local skillCap = level * 5

    -- Format: { spellId, skillId }
    local armorProficiencies = {
        { 750,   293 }, -- Plate Mail
        { 8737,  413 }, -- Mail
        { 9077,  414 }, -- Leather
        { 9116,  433 }, -- Shield
    }

    local weaponProficiencies = {
        { 196,   44  }, -- One-Handed Axes
        { 197,   172 }, -- Two-Handed Axes
        { 198,   54  }, -- One-Handed Maces
        { 199,   160 }, -- Two-Handed Maces
        { 200,   229 }, -- Polearms
        { 201,   43  }, -- One-Handed Swords
        { 202,   55  }, -- Two-Handed Swords
        { 227,   136 }, -- Staves
        { 264,   45  }, -- Bows
        { 266,   46  }, -- Guns
        { 1180,  173 }, -- Daggers
        { 2567,  176 }, -- Thrown
        { 5009,  228 }, -- Wands
        { 5011,  226 }, -- Crossbows
        { 15590, 473 }, -- Fist Weapons
        { 73, 162 }, -- Unarmed
    }

    -- Teach armor proficiencies (don't level up, just need the spell/skill)
    for _, prof in ipairs(armorProficiencies) do
        local spellId, skillId = prof[1], prof[2]
        if not player:HasSpell(spellId) then
            player:LearnSpell(spellId)
        end
        if not player:HasSkill(skillId) then
            player:SetSkill(skillId, 0, 300, 300)
        end
    end

    -- Teach weapon proficiencies (start at 1, cap based on level)
    for _, prof in ipairs(weaponProficiencies) do
        local spellId, skillId = prof[1], prof[2]
        if not player:HasSpell(spellId) then
            player:LearnSpell(spellId)
        end
        if not player:HasSkill(skillId) then
            player:SetSkill(skillId, 0, 1, skillCap)
        end
    end
end

RegisterPlayerEvent(30, AddAllProficiencies) -- 30 is On First Login
