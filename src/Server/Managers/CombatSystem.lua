--[[
    CombatSystem.lua
    Handles all combat mechanics and territory capture
]]

local Config = require(game:GetService("ServerScriptService"):WaitForChild("Config"))
local Constants = require(game:GetService("ServerScriptService"):WaitForChild("Constants"))
local Utils = require(game:GetService("ServerScriptService"):WaitForChild("Utils"))

local CombatSystem = {}
CombatSystem.activeCombats = {}

-- INITIATE ATTACK
function CombatSystem:AttackTerritory(attacker, sourceTerrId, targetTerrId, troops, territoryMgr, resourceMgr)
    -- Validation
    local can, err = territoryMgr:CanAttack(sourceTerrId, targetTerrId)
    if not can then return false, err end
    
    local source = territoryMgr:GetTerritory(sourceTerrId)
    local target = territoryMgr:GetTerritory(targetTerrId)
    
    if troops < Config.Combat.MinimumTroopsToAttack then
        return false, "Insufficient troops"
    end
    
    if source.resources.Troops < troops then
        return false, "Not enough troops in source territory"
    end
    
    -- Calculate combat power
    local attackPower = self:CalculateAttackPower(source, troops)
    local defensePower = self:CalculateDefensePower(target)
    
    -- Determine outcome
    local victory = attackPower > defensePower
    
    -- Apply damage
    local troopsLost = math.floor(troops * Config.Combat.TroopLossPercentage)
    source.resources.Troops = source.resources.Troops - troops
    
    if victory then
        -- Capture territory
        territoryMgr:SetOwner(targetTerrId, attacker)
        target.resources = Utils.DeepCopy(source.resources)
        target.resources.Troops = math.floor(troops * (1 - Config.Combat.TroopLossPercentage))
        
        return true, "Territory captured!"
    else
        -- Defense success
        target.resources.Troops = target.resources.Troops + math.floor(troops * 0.5)
        return false, "Defense successful!"
    end
end

-- CALCULATE ATTACK POWER
function CombatSystem:CalculateAttackPower(territory, troops)
    local basePower = Config.Combat.BaseAttackPower
    local troopBonus = (troops / 100) * 0.5
    return basePower + troopBonus
end

-- CALCULATE DEFENSE POWER
function CombatSystem:CalculateDefensePower(territory)
    local basePower = Config.Combat.BaseDefensePower
    local buildingBonus = #territory.buildings * Config.Combat.DefenseBonusPerBuilding
    local troopBonus = (territory.resources.Troops / 100) * 0.3
    
    return basePower + buildingBonus + troopBonus
end

-- UPDATE ONGOING COMBATS
function CombatSystem:UpdateCombats()
    local toRemove = {}
    
    for combatId, combat in pairs(self.activeCombats) do
        combat.progress = combat.progress + Config.Combat.CaptureDuration / 100
        
        if combat.progress >= 1 then
            table.insert(toRemove, combatId)
        end
    end
    
    for _, combatId in ipairs(toRemove) do
        self.activeCombats[combatId] = nil
    end
end

-- GET COMBAT STATUS
function CombatSystem:GetCombatStatus(combatId)
    return self.activeCombats[combatId]
end

return CombatSystem
