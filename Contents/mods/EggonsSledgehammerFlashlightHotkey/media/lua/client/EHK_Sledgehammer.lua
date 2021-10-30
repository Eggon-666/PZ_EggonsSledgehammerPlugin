local sledgehammers = {
    ["Base.Sledgehammer"] = true,
    ["Base.Sledgehammer2"] = true
}

local function initCursor(player, sledge)
    local bo = ISDestroyCursor:new(player, false, sledge)
    getCell():setDrag(bo, bo.player)
end

local function equipSledge()
    local player = getPlayer()
    local inv = player:getInventory()

    local SHI = player.getSecondaryHandItem()
    local PHI = player.getPrimaryHandItem()
    local equippedPrimary = false
    local equippedSecondary = false

    if SHI and sledgehammers[SHI:getFullType()] then
        equippedSecondary = true
    end
    if PHI and sledgehammers[PHI:getFullType()] then
        equippedPrimary = true
    end

    local sledge
    if equippedPrimary and equippedSecondary and PHI == SHI then -- already equipped
        sledge = PHI
    elseif equippedPrimary then -- two different sledges or primary only
        sledge = PHI
    elseif equippedSecondary then -- held secondary only
        sledge = SHI
    else
        -- znajdź sledge z listy
        for fullType, _ in pairs(sledgehammers) do
            sledge = inv:getFirstTypeRecurse(fullType)
            if sledge then
                break
            end
        end
    end
    if sledge then
        ISInventoryPaneContextMenu.equipWeapon(PHI, true, true, player:getPlayerNum()) --(weapon, primary, twoHands, player)
        initCursor(player, sledge)
    else
        player:Say("Where have I put my sledgehammer?")
    end
end

local keyConfigs = {
    flashlight = {
        action = equipSledge,
        keyCode = 0
    }
}
if EHK_Plugin then
    EHK_Plugin:AddConfigs(keyConfigs)
end
