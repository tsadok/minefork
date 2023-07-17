# Overview

Minefork is my attempt to create an essentially complete non-combat mine-and-build game experience in the Minetest engine.  It is based on Dreambuilder, by Vanessa Dannenberg, which in turn is based on minetest_game, the base game content package maintained by Minetest engine game developers, and should be compatible with most modules written for either; but it is my intention that you should generally not need additional modules for a peaceful-mode game: I have attempted to include everything that is needed.  Some components of Dreambuilder (and one component of MTG) have been removed because they are at odds with my design philosophy for the game.  Specifically, it is my intention that players should build things, and so I have removed modules that were focused instead on crafting prefab single-node versions of complex objects and merely placing them in the world.  When a player is building a house and wants to put e.g. a swimming pool in the back yard, I want them to build the swimming pool out of existing blocks, not search through the recipe book for a "swimming pool" object that they can craft and place as a single node.  Similar logic applies to things like tables and chairs:  they can be built in the world, the same as anything else.  However, this does not apply to important functional things (like the grinders and furnaces and whatnot that are used to process materials); on the contrary, I have attempted to supply enough materials-processing options to allow players to build up their infrastructure and acquire large quantities of building materials, and this means that useful building materials like clay and sandstone and glass can be readily made, in bulk and in a variety of colors, from abundant materials.  The major exception is combat:  Minefork is intended to be a peaceful game experience, so if you want combat, you will need additional modules.

##

# What's in it?  What's changed from Dreambuilder?

* The five most important technical mods are built in:  Mesecons, Pipeworks, Technic, Digtron, and Digilines.  Misuse (especially of Pipeworks) can cause lag, but honestly, nobody wants to play without these modules, because it would be unbearably tedious (except maybe in creative mode with worldedit).  Relatedly, I've included Technic Addons and Technic HV Extend and some minor improvements.
* The standard set of dyes has been supplemented with four additional colors (navy, tan, spring green, and indigo).  All colors of dye can be readily produced in bulk, from some combination of autofarmable crops, abundant materials, grinding, extracting, and crafting, all of which can be automated.
* All three varieties of sand can be dyed, and the dyed sand can either be compressed into sandstone, or smelted into glass.
* Important building materials have been made easier to produce in bulk.  Sand can be ground down into silt, which in turn can be ground down into clay.  Normal sandstone can be baked to produce desert sandstone, which can be compressed to produce desert stone.  Colored plastic can be made by alloying plastic sheets with dye.
* Tools made out of certain materials have special behaviors, when they are the correct type of tool for mining the block that is mined.  Mese tools bypass drop tables and yield up the block itself.  Gold tools produce more output (so e.g. if you mine copper ore with a gold pick, you can get more than one copper nugget).  Alatro tools subvert the probabilities in drop tables, so that the normally least likely drops become the most likely ones (e.g., gravel usually drops flint, leaves usually drop saplings).  Also, mithril tools last longer than before, including the mithril screwdriver.
* Metal blocks can be "polished" (via a crafting recipe), which removes the beveled block borders, allowing for smooth surfaces.
* Craft-and-place single-node versions of complex structures have been removed, in favor of allowing the player to build things out of more basic nodes ("blocks"), which is the main point of the game.  I made a couple of exceptions for light sources, because everyone is always looking for more lighting options.
* Some redundancies have been consolidated, where more than one module was supplying essentially the same thing, unnecessarily.
* Some recipe conflicts have been resolved by changing recipes as needed so that they are distinct from other recipes for unrelated outputs.
* Some really pointless things have been removed so they don't clutter up the recipe book.
* UI improvements.  Among other things, you don't need a crafted item to set your respawn point; there's a button in the UI.
* Digtron inventory nodes can be marked with colors (by dying them).  This is purely aesthetic and is meant as a mnemonic aid for people who use digtron for portable storage.
* Several modules have been added that supply additional building materials (e.g., various additional types of wood).
* Several modules have been added that supply new types of areas to explore (e.g., Caverealms, DF Caverns, Hallelujah Mountains, Magma Conduits).
* Basic transportation infrastructure modules have been added (lowercrossroads and travelnet, for exploration and low-lag fast-travel respectively).
* Several tracks have been supplied for the Technic music player.  These tracks are in the public domain and are also available under a Creative Commons CC0 license and can be freely used by anyone for any legal purpose without any licensing fees or copyright-related restrictions whatsoever.
* The areas module has been added, for the benefit of public servers.  Single-player worlds can safely ignore it.
* A decent set of signs has been added, again mainly for the benefit of public servers.  Certain colors of signs are uncraftable, reserved for server admin use.
* Minegeld currency has been adjusted so that the list of denominations is more sensible.
* The SmartShop module is included, and other shop objects from other modules are disabled in favor of SmartShop.
* Some terminology is changed.
* Various bugs have been fixed.

# Dreambuilder's changes compared to Minetest Game:
* The complete Plantlife Modpack along with More Trees add a huge amount of variation to your landscape (as a result, they will add mapgen lag).  Active spawning of Horsetail ferns is disabled by default, and I've added papyrus growth on dirt/grass with leaves (using a copy of the default growth ABM).
* This game includes RealBadAngel's Unified Inventory mod, which overrides minetest_game's default inventory to give you a much more powerful user interface, with crafting guide, bags, and much more.
* The default hotbar HUD holds 16 items instead of 8, taken from the top two rows of your inventory.  You can use [icode]/hotbar ##[/icode] (8, 16, 24, or 32) to change the number of slots.  Your setting is retained across restarts.
* The default lavacooling code has been supplanted by better, safer code from my Gloop Blocks mod.  That mod also provides stone/cobble --> mossy stone/cobble transformation in the presence of water.
* An extensive selection of administration tools for single-player and server use are included, such as areas, maptools, worldedit, xban, and more.
* A few textures here and there are different from their defaults.
* By way of Technic, all locked chests use a padlock in their recipes instead of a steel ingot.  Most other locked items work this way, too.
* The mapgen won't spawn apples on default trees, nor will they appear on a sapling-grown default tree. Only the *real* apple trees supplied by the More Trees mod will bear apples (both at mapgen time and sapling-grown).  While on that subject, apples now use a 3d model instead of the plantlike version.
* A whole boatload of other mods have been added, which is where most of the content actually comes from.  To be a little more specific, as of Feb. 2021, this game has a total of 209 mods (counting all of the various sub-mods that themselves are normally as part of some modpack, such as Mesecons, Home Decor, Roads, etc.) and supplies over 3000 items in the inventory/craft guide, and tens of thousands of unique items in total (counting everything that isn't displayed in the inventory)!

##  

# Okay, what else?

A whole boatload of other mods have been added, which is where most of the content actually comes from. To be a little more specific, as of February 2021, this game has a total of 208 mods (counting all of the various components that themselves come as part of some modpack, such as mesecons or homedecor) and supplies over 3100 items in the inventory/craft guide (there are tens of thousands of unique items in total, counting everything that isn't displayed in the inventory)!

A complete list of mods is as follows:

* Ambience (TenPlus1; https://notabug.org/TenPlus1/ambience)
* Arrowboards (cheapie; https://cheapiesystems.com/git/arrowboards/)
* Bakedclay (TenPlus1; https://notabug.org/TenPlus1/bakedclay)
* Basic materials (https://gitlab.com/VanessaE/basic_materials)
* Basic signs (https://gitlab.com/VanessaE/basic_signs)
* Bedrock (Calinou; https://github.com/Calinou/bedrock)
* Bees (bas080; TenPlus1's fork; https://notabug.org/TenPlus1/bees)
* Biome lib (https://gitlab.com/VanessaE/biome_lib) 
* Blox (my fork; https://gitlab.com/VanessaE/blox)
* Bobblocks (RabbiBob; no traps or mesecons support; https://github.com/minetest-mods/BobBlocks)
* Bonemeal (TenPlus1; https://notabug.org/TenPlus1/bonemeal)
* Caverealms lite (Ezhh; https://github.com/Ezhh/caverealms_lite)
* Cblocks (TenPlus1; https://notabug.org/TenPlus1/cblocks)
* Coloredwood (https://gitlab.com/VanessaE/coloredwood)
* Cottages (Sokomine; https://github.com/Sokomine/cottages)
* Currency (DanDuncombe; my fork; https://gitlab.com/VanessaE/currency)
* Datastorage (RealBadAngel; https://github.com/minetest-technic/datastorage)
* Digidisplay (cheapie; https://cheapiesystems.com/git/digidisplay/)
* Digilines (Jeija; https://github.com/minetest-mods/digilines)
* Digistuff (cheapie; https://cheapiesystems.com/git/digistuff/)
* Display blocks (jojoa1997; cheapie's "redo" fork, https://cheapiesystems.com/git/display_blocks_redo/)
* Dreambuilder hotbar (https://gitlab.com/VanessaE/dreambuilder_hotbar)
* Extra stairsplus (deezl)
* Facade (Tumeninodes; https://github.com/TumeniNodes/facade)
* Farming (TenPlus1's "redo" fork; https://notabug.org/TenPlus1/farming)
* Framedglass (RealBadAngel; https://github.com/minetest-mods/framedglass)
* Function delayer (HybridDog; https://github.com/HybridDog/function_delayer)
* Gardening (philipbenr; https://forum.minetest.net/viewtopic.php?t=6575)
* Gloopblocks (Nekogloop; my fork; https://gitlab.com/VanessaE/gloopblocks)
* Glooptest (Nekogloop; https://github.com/GloopMaster/glooptest; no treasure chests)
* Ilights (DanDuncombe; my fork; https://gitlab.com/VanessaE/ilights)
* Invsaw (cheapie; https://cheapiesystems.com/git/invsaw/)
* Item drop (PilzAdam; https://github.com/minetest-mods/item_drop)
* Jumping (Jeija; https://github.com/minetest-mods/jumping)
* Led marquee (https://gitlab.com/VanessaE/led_marquee)
* Locks (Sokomine; https://github.com/Sokomine/locks)
* Maptools (Calinou; https://github.com/minetest-mods/maptools)
* Memorandum (Mossmanikin; https://github.com/Mossmanikin/memorandum)
* Moreblocks (Calinou; https://github.com/minetest-mods/moreblocks)
* Moreores (Calinou; https://github.com/minetest-mods/moreores)
* Moretrees (https://gitlab.com/VanessaE/moretrees)
* Mymillwork (DonBatman; laza83's smooth meshes fork; https://github.com/laza83/mymillwork)
* New campfire (googol; my fork; https://gitlab.com/VanessaE/new_campfire)
* Nixie tubes (https://gitlab.com/VanessaE/nixie_tubes)
* Pipeworks (https://gitlab.com/VanessaE/pipeworks)
* Plasticbox (cheapie; https://cheapiesystems.com/git/plasticbox/)
* Player textures (Pilzadam; CWz's fork, with several default skins; )
* Prefab redo (DanDuncombe; cheapie's "redo" fork; https://cheapiesystems.com/git/prefab_redo/)
* Quartz (4Evergreen4; https://github.com/minetest-mods/quartz)
* Replacer (Sokomine; CWz's fork; https://github.com/ChaosWormz/replacer )
* Rgblightstone (cheapie; https://cheapiesystems.com/git/rgblightstone/)
* Signs lib (https://gitlab.com/VanessaE/signs_lib)
* Simple streetlights (https://gitlab.com/VanessaE/simple_streetlights)
* Solidcolor (cheapie; https://cheapiesystems.com/git/solidcolor/)
* Stained glass (doyousketch2; https://github.com/minetest-mods/stained_glass)
* Steel (Zeg9; my fork; https://gitlab.com/VanessaE/steel)
* Street signs (https://gitlab.com/VanessaE/street_signs)
* Titanium (Aqua; HybridDog's fork; https://github.com/HybridDog/titanium)
* Travelnet (Sokomine; https://github.com/Sokomine/travelnet)
* Ufos (Zeg9; https://github.com/Zeg9/minetest-ufos/)
* Unifiedbricks (wowiamdiamonds; https://github.com/minetest-mods/unifiedbricks)
* Unifieddyes (https://gitlab.com/VanessaE/unifieddyes)
* Unified inventory (RealBadAngel; https://github.com/minetest-mods/unified_inventory)
* Unifiedmesecons (cheapie; https://cheapiesystems.com/git/unifiedmesecons/)
* Windmill (Sokomine; https://github.com/Sokomine/windmill)


Modpacks:


* Castle-Modpack (philipbenr; minus the orbs; https://github.com/minetest-mods/castle)
* Cool trees modpack (runsy; https://github.com/runsy/cool_trees/)
* Homedecor modpack (https://gitlab.com/VanessaE/homedecor_modpack) 
* Mesecons modpack (Jeija; https://github.com/minetest-mods/mesecons)
* Plantlife modpack (https://gitlab.com/VanessaE/plantlife_modpack)
* Roads modpack (cheapie; https://cheapiesystems.com/git/roads/)
* Technic modpack (RealBadAngel; https://github.com/minetest-mods/technic)
* Worldedit modpack (Uberi; https://github.com/Uberi/Minetest-WorldEdit)


Base game content imported from minetest_game:


* beds
* binoculars
* boats
* bucket
* butterflies
* carts
* creative
* default
* doors
* dungeon_loot
* dye
* env_sounds
* fire
* fireflies
* flowers
* game_commands
* give_initial_stuff
* map
* player_api
* screwdriver
* sfinv
* spawn
* stairs
* vessels
* walls
* weather
* wool
* xpanes


### Your Inventory Display

This game, as previously mentioned, replaces the standard inventory with Unified Inventory, which almost defies description here.  Unified Inventory includes waypoints, a crafting guide, set/go home buttons, set day/set night buttons, a full creative inventory on the right if you're playing in that mode - and you only have to click/tap the item once to get the it, instead of multiple clicks/drag and drop, a trash slot, a clear all inventory button, a search feature for the inventory, and more.  Basically, you just need to use it a few times and you'll find yourself wondering how you ever got along with the standard inventory!

### The Table Saw

This game uses the More Blocks mod, which comes with Sokomine's Stairsplus, with its table saw component.  This mod replaces the traditional method of creating stairs, slabs, and the like:  rather that crafting a stairs block by placing several of the material into your crafting grid, you must first craft a table saw, place that on the ground, and then use that to shape the material you had in mind.  It can create dozens of shapes, including the standard stairs and slabs.  Give it a try and see for yourself!

### Land Ownership

This game uses ShadowNinja's areas mod for land protection, and also has cheapie's areasprotector, which supplies simple protection blocks, using areas as the backend.  For more info on the areas mod, visit [url=https://forum.minetest.net/viewtopic.php?t=7239]the forum thread for it[/url].  cheapie's mod can be found on [url=https://cheapiesystems.com/git/areasprotector/]her git repository[/url].  Of course, these mods are only useful if you're running a multi-player server.
What's it look like?  Screenshots or it didn't happen!

These are a few examples of what can be found or built with this game.  Most of these screenshots came from my Creative server, since it has plenty of content just ripe for this purpose. :-)

Wide angle view of Dopium Estate:
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/dopium-estate.png
Close-up view of the reactor on Dopium Estate:
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/dopium-reactor.png
KikaRz's House:
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/kikarz-estate.png
Just a tiny portion of CrazyGinger72's epic racetrack:
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/cg72-racetrack.png
CG72's skyscraper near the racetrack:
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/cg72-tower.png
A cubicle farm in another of CG72's office buildings:
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/cg72-office.png
A cave realm deep underground on one of my test worlds
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/caverealm.png

## Dependencies:
This game requires Minetest 5.4.0 or later.

## Hardware requirements:
This game defines a very large number of items and produces a well-detailed landscape, and so it requires a significant amount of resources.  At least a 2 GHz dual core CPU and 4 GB free RAM are required for good performance.  If you use my HDX texture pack, you'll need a LOT more RAM.

This game is NOT recommended for use on mobile devices (though some newer devices, say from mid-2018 or later, may work okay).

## Download:
...if you're reading this, you're either on the Dreambuilder Gitlab repo page, so clone it from there, or download the ZIP from the button at the top of this repository page... or maybe you already have it. ;-)

## Install:
If you downloaded the zip, just extract it and rename the resultant directory to "dreambuilder_game", if necessary.  If you're using the git repository, just clone it and keep the name as-is.

Move it to your Minetest games directory.  When you start Minetest, you'll notice a little red "house" icon at the bottom of the main menu.  Click that to select Dreambuilder, then create or select a world as you see fit.

Depending on the conditions of the world, this game may take as much as 2 minutes to start, during which time you may see the hotbar and hand, but all-grey window content where the world should be.  Just wait it out, it will eventually start.

## License:
Each of the base mods in this game retains the standard licenses their original authors assigned, even if the license file is missing from the archive.  For all of my Dreambuilder-specific changes and their related assets, LGPL 3.0 for code, CC-by-SA 4.0 for media and such.

## Open Source Software
This game is open source, or at least as much so as I have control over.
