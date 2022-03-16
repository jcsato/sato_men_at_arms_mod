# Sato's Men at Arms Origin

A mod for the game Battle Brothers ([Steam](https://store.steampowered.com/app/365360/Battle_Brothers/), [GOG](https://www.gog.com/game/battle_brothers), [Developer Site](http://battlebrothersgame.com/buy-battle-brothers/)).

## Table of contents

-   [Features](#features)
-   [Requirements](#requirements)
-   [Installation](#installation)
-   [Uninstallation](#uninstallation)
-   [Compatibility](#compatibility)
-   [Building](#building)

## Features

Adds a new starting scenario, the Men at Arms, focused on slowly building up a group of elite units. The quick summary:

 - Start with three veteran brothers with good equipment, and a prestige bonus.
 - Training Halls cost 50% less.
 - Every village starts out "Unfriendly", forcing a more measured approach to contract negotiation and bargain hunting early on.
 - You can only hire combat backgrounds, and cannot have more than 16 men in your roster.

I've always enjoyed campaigns where I've limited the amount of brothers I hire, I've always enjoyed elite units in the early game, and I've always wanted to Training Halls to be more useful; this mod is the outcome of that.

I hope you enjoy the new origin!

## Requirements

1) [Modding Script Hooks](https://www.nexusmods.com/battlebrothers/mods/42) (Preferably the latest version, but I'd recommend at least 19)

## Installation

1) Download the mod from the [releases page](https://github.com/jcsato/sato_men_at_arms_mod/releases/latest)
2) Without extracting, put the `sato_men_at_arms_origin_x.x.zip` file in your game's data directory
    1) For Steam installations, this is typically: `C:\Program Files (x86)\Steam\steamapps\common\Battle Brothers\data`
    2) For GOG installations, this is typically: `C:\Program Files (x86)\GOG Galaxy\Games\Battle Brothers\data`

## Uninstallation

1) Remove the relevant `sato_men_at_arms_origin_x.x.zip` file from your game's data directory

## Compatibility

This should be fully save game compatible, i.e. you can make a save with it active and remove it without corrupting that save.

This should be fairly compatible with other mods, except where obvious (e.g. mods that change the same thing).

### Building

To build, run the appropriate `build.bat` script. This will automatically compile and zip up the mod and put it in the `dist/` directory, as well as print out compile errors if there are any. The zip behavior requires Powershell / .NET to work - no reason you couldn't sub in 7-zip or another compression utility if you know how, though.

Note that the build script references the modkit directory, so you'll need to edit it to point to that before you can use it. In general, the modkit doesn't play super nicely with spaces in path names, and I'm anything but a batch expert - if you run into issues, try to run things from a directory that doesn't include spaces in its path.

After building, you can easily install the mod with the appropriate `install.bat` script. This will take any existing versions of the mod already in your data directory, append a timestamp to the filename, and move them to an `old_versions/` directory in the mod folder; then it will take the built `.zip` in `dist/` and move it to the data directory.

Note that the install script references your data directory, so you'll need to edit it to point to that before you can use it.
