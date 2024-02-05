# 📜 README 📜
This is a simple script for your server. This is easy to use.

# ⚒️ INSALL ⚒️
- First you have to download a release of the script
- Then, open the config.lua and change the Strings/configs
- Import the SQL in your database by using the sql.sql file

# ⚠️ REQUIREMENTS ⚠️
- oxmsql (https://github.com/overextended/oxmysql)
- ox_lib (https://github.com/overextended/ox_lib)

# 🤖 COMMANDS 🤖
- /addvip (playerId) <--add the vip (permanent) to the player (admins only)
- /removevip (playerId) <--remove the vip to the player (admins only)
- /idboutique (playerId) <--get the player boutique id (admins only)
- /vipmenu <-- open the vip menu

# ⚙️ EXPORTS/EVENTS ⚙️
- Check if a user is a vip:
  ```lua
  ESX.TriggerServerCallback('av_vipmenu:verifyGroup', function(isvip)
    if isvip == true then
      --Your code if the user is a vip
    else
      --if not
    end
  end, callback)
  ```

# ❤️ THANKS ❤️
- thanks to GC who gave me the idea and the motivation for this script
