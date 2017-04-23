customSchema = class({})

function customSchema:init()

    -- Check the schema_examples folder for different implementations

    -- Flag Example
    -- statCollection:setFlags({version = GetVersion()})

    -- Listen for changes in the current state
    ListenToGameEvent('game_rules_state_change', function(keys)
        local state = GameRules:State_Get()

        -- Send custom stats when the game ends
        if state == DOTA_GAMERULES_STATE_POST_GAME then

            -- Build game array
            local game = BuildGameArray()

            -- Build players array
            local players = BuildPlayersArray()

            -- Print the schema data to the console
            if statCollection.TESTING then
                PrintSchema(game, players)
            end

            statCollection:sendCustom({ game = game, players = players })

        end
    end, nil)

    -- Write 'test_schema' on the console to test your current functions instead of having to end the game
    if Convars:GetBool('developer') then
        Convars:RegisterCommand("test_schema", function() PrintSchema(BuildGameArray(), BuildPlayersArray()) end, "Test the custom schema arrays", 0)
        Convars:RegisterCommand("test_end_game", function() GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS) end, "Test the end game", 0)
    end
end



-------------------------------------

-- In the statcollection/lib/utilities.lua, you'll find many useful functions to build your schema.
-- You are also encouraged to call your custom mod-specific functions

-- Returns a table with our custom game tracking.
function BuildGameArray()
    local game = {}

    -- Add game values here as game.someValue = GetSomeGameValue()

    return game
end

-- Returns a table containing data for every player in the game
function BuildPlayersArray()
    local players = {}
    for playerID = 0, DOTA_MAX_PLAYERS do
        if PlayerResource:IsValidPlayerID(playerID) then
            if not PlayerResource:IsBroadcaster(playerID) then

                local hero = PlayerResource:GetSelectedHeroEntity(playerID)
                local playerDeath = 0
                if hero then
                    playerDeath = hero:GetDeaths() --Number of deaths of this players hero
                end
                table.insert(players, {
                    --steamID32 required in here
                    steamID32 = PlayerResource:GetSteamAccountID(playerID),

                    -- Example functions of generic stats (keep, delete or change any that you don't need)
                    ph = GetHeroName(playerID), --Hero by its short name
                    plh = PlayerResource:GetLastHits(playerID), --Number of last hit of this players hero
                    pd = playerDeath,
                    nt = GetNetworth(hero), --Sum of hero gold and item worth

                    -- Item List
                    i1 = GetItemSlot(hero,0),
                    i2 = GetItemSlot(hero,1),
                    i3 = GetItemSlot(hero,2),
                    i4 = GetItemSlot(hero,3),
                    i5 = GetItemSlot(hero,4),
                    i6 = GetItemSlot(hero,5)
                })
            end
        end
    end

    return players
end


-------------------------------------
-- Stat Functions         --
-------------------------------------


function GetHeroName(hero)
    local heroName = hero:GetUnitName()
    heroName = string.gsub(heroName, "npc_dota_hero_", "") --Cuts the npc_dota_hero_ prefix
    return heroName
end

function GetNetworth(hero)
    local gold = hero:GetGold()

    -- Iterate over item slots adding up its gold cost
    for i = 0, 15 do
        local item = hero:GetItemInSlot(i)
        if item then
            gold = gold + item:GetCost()
        end
    end
end

function GetItemSlot(hero, slot)
    local item = hero:GetItemInSlot(slot)
    local itemName = ""

    if item then
        itemName = string.gsub(item:GetAbilityName(), "item_", "")
    end

    return itemName
end

-- Prints the custom schema, required to get an schemaID
function PrintSchema(gameArray, playerArray)
    print("-------- GAME DATA --------")
    DeepPrintTable(gameArray)
    print("\n-------- PLAYER DATA --------")
    DeepPrintTable(playerArray)
    print("-------------------------------------")
end

-------------------------------------

-- If your gamemode is round-based, you can use statCollection:submitRound(bLastRound) at any point of your main game logic code to send a round
-- If you intend to send rounds, make sure your settings.kv has the 'HAS_ROUNDS' set to true. Each round will send the game and player arrays defined earlier
-- The round number is incremented internally, lastRound can be marked to notify that the game ended properly
function customSchema:submitRound()

    local winners = BuildRoundWinnerArray()
    local game = BuildGameArray()
    local players = BuildPlayersArray()

    statCollection:sendCustom({ game = game, players = players })
end

-- A list of players marking who won this round
function BuildRoundWinnerArray()
    local winners = {}
    local current_winner_team = GameRules.Winner or 0 --You'll need to provide your own way of determining which team won the round
    for playerID = 0, DOTA_MAX_PLAYERS do
        if PlayerResource:IsValidPlayerID(playerID) then
            if not PlayerResource:IsBroadcaster(playerID) then
                winners[PlayerResource:GetSteamAccountID(playerID)] = (PlayerResource:GetTeam(playerID) == current_winner_team) and 1 or 0
            end
        end
    end
    return winners
end

-------------------------------------