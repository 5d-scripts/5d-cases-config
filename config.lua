    
_CONFIG = 
{
    locale = "en",
    Cases = 
    {
        {
            caseItem = "case",
            rewards = 
            {
                {
                    name = "WEAPON_PISTOL",
                    label = "Pistole",
                    type = "weapon",
                    ammo = 200,
                    img = "pistol.png",
                    chance = 0.1, 
                    rarityColor = "#B0C3D9"
                },
                {
                    name = "adder",
                    label = "Adder",
                    type = "vehicle",
                    img = "vehicle.png",
                    chance = 0.85,
                    rarityColor = "#E4AE33"
                },
                {
                    name = "gps",
                    label = "GPS",
                    type = "item",
                    amount = 2,
                    img = "gps.png",
                    chance = 0.3,
                    rarityColor = "#D32CE6"
                },
                {
                    name = "backpack",
                    label = "Backpack", 
                    type = "item",
                    amount = 10,
                    img = "backpack.png",
                    chance = 0.25,
                    rarityColor = "#8847FF"
                },
                {
                    name = "money",
                    label = "Cash", 
                    type = "account",
                    amount = 50000,
                    img = "money.png",
                    chance = 0.1,
                    rarityColor = "#EB4B4B"
                }
            } 
        },
    },

    Util = -- Util Functions used by the script, feel free to modify them to your liking.
    {
        generateRandomPlate = function() -- Function used to generate a random vehicle plate
                                         -- Produces a random string in the format "AAA 111"
                                         -- createRandomNumberGenerator is an internal utility function that handles local scope seeding for math.random().
                                         -- Make sure to use it when re-writing this function!
            local random = createRandomNumberGenerator(os.time())
            local plate = ""
            for i = 1, 3 do
                plate = plate .. string.char(random(65, 90))
            end
            plate = plate .. " "
            for i = 1, 3 do
                plate = plate .. string.char(random(48, 57))
            end

            return plate
        end,

        createDBVehicle = function(xPlayer, model, plate, reward) -- We pass the entire reward object so you can add custom config entries and modify the query.
            MySQL.Async.execute("INSERT INTO owned_vehicles (owner,plate,vehicle,`stored`) VALUES(?,?,?,1)", {xPlayer.getIdentifier(), plate, json.encode({
                model = GetHashKey(model),
                plate = plate
            })})
        end
    }
}

if (not IsDuplicityVersion()) then
    -- Notify event. Can be replaced.
    ---@param message string Message to be displayed for the notify.
    ---@param type string Notify type. Either success or errror.
    RegisterNetEvent("5d-cases:notify", function(message, type)
        ESX.ShowNotification(message)
    end)
end

_LOCALE = {} -- dont touch