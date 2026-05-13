# Titled Library
A simple UI Library designed and developed by ecl4ts.

Version: v0.1.1 (Build 0)

## Getting Started
To load the library, use:

```lua
local UnamedLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ecl4ts/UntitledSoftware/main/src/client/UnamedLibrary.lua?token=GHSAT0AAAAAADS6LXJ7ZLFGS7357NWLA42C2QE5ELQ"))()
```

Next intialize the library by using:
```lua
UnamedLibrary:intialize([THEME],[FONT],[TOGGLEKEY]) -- Theme: "Dark" OR "Light", Font: "Enum.Font.???", ToggleKey: Enum.Keycode.???
```

You can name your UI by using:
```lua
UnamedLibrary:createTitle([TITLE],[VERSION]) -- Title,Theme: String
```

If you run into any problems, try:
```lua
UnamedLibrary:debug()
```

For more help, check out [join our Discord](https://discord.gg/YmrUNMw4vd).