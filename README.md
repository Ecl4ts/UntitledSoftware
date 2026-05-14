# [Unnamed Library](https://discord.gg/YmrUNMw4vd)
A simple UI Library designed and developed by ecl4ts.

Version: v0.1.1 (Build 1)

## Getting Started
To load the library, use:

```lua
local UnnamedLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ecl4ts/UntitledSoftware/main/UnnamedLibrary.luau"))()
```

Next intialize the library by using:
```lua
UnnamedLibrary:intialize("[THEME]","[FONT]","[TOGGLEKEY]") -- Theme: "Dark" OR "Light", Font: "Enum.Font" ToggleKey: Enum.Keycode
```
This creates the MainUI and sets all the needed variables


You can name your UI by using:
```lua
UnnamedLibrary:createTitle("[TITLE]","[VERSION]") -- Title,Theme: String
```
This just names the MainUI -- Note: The title auto formats, with the game name. (E.g: "Untitled Software - V0 - ABC")

To protect any **custom** UI elements, run:
```lua
UnnamedLibrary:protectName([ELEMENT]) -- Element: Instance
```
This renames **any** instance to a mix of different unicode characters

If you run into any problems, try:
```lua
UnnamedLibrary:debug()
```
This prints all actions

If the GUI won't show, try:
```lua
UnnamedLibrary:allowPlayerUI()
```
This allows for the UI to be parented to LocalPlayer.PlayerGUI
**Some games may easily detect this, use at your own risk.**

For more help, [join our Discord](https://discord.gg/YmrUNMw4vd).
