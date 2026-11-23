HealBot Continued
-----------------

  - Visit the Healbot website for information: https://healbot.dpm15.net.
  - Questions and bug reports on discord:  https://discord.gg/gwa6rdCeZ4
  - Over 80 extra skins packaged and ready for import in-game.
  - Includes Blizzard Forever - Party, Blizzard Forever - Raid 10 and Blizzard Forever - Raid 40: HealBot presets inspired by Blizzard's compact frames.

Blizzard compact-frame skins
---------------------------
  - Open HealBot options, then Skins > Import/Export > Extra Skins.
  - Select Blizzard Forever - Party under Group, Raid 10 under Small Raid, or Raid 40 under Large Raid, then click Import.
  - These presets use class colours, Blizzard raid-bar textures, dark borders, a power bar and corner auras. They retain HealBot click-casting.
  - They are visual approximations, not replacements for Blizzard's entire UI. Existing Blizzard frames remain visible; hide them separately in HealBot's skin settings if desired.
  - Reset combat timer overrides in Skins > Frames > Icons > Native auras: set Countdown numbers to Follow skin.


Role icons on HealBot frames
---------------------------
  - Open Skins > Frames > Icons > Extras > Class / Role and select the frame to configure.
  - Enable Show role (Mostra ruolo). This also enables the shared class/role icon slot.
  - Disable Only show tanks to show tank, healer and DPS icons. Enable Always enabled to keep the icon visible on healthy bars.
  - Use Position, Anchor, Scale and the horizontal/vertical offsets in the same panel to place the icon.
  - The Blizzard Forever presets include visible role icons by default on new imports. For an already imported skin, enable Show Class and Show role in the panel above; no reimport is required.
  - Role icons use the same slot as class icons. Turning off Show role returns to the class icon; turning off Show Class hides the slot.

Debuffs after combat on Forever
-------------------------------
  - Native debuff icons and configured bar colours remain active outside combat, including DoTs left over from a fight. The client updates them when auras expire or are removed.
  - The first debuff icon row uses the same harmful-aura filter and icon limit as in combat, including debuffs you cannot dispel. HealBot's cure warnings and custom icon sets 2/3 retain their own settings.
  - This is enabled by default on Forever. In Skins > Frames > Icons > Native auras, toggle Keep debuffs visible outside combat to change it.
  - Debuff monitoring, bar-colour settings and Enable native buff and debuff icons still control their respective displays. If native icons are unavailable, HealBot keeps its normal icon renderer.

Health text and buff settings on Forever
---------------------------------------
  - Current health and Deficit use the selected number format, including K/M abbreviations and Auto. Deficit uses the client's missing-health API and keeps the minus sign; at full health it can display -0. Include percent remains an independent setting.
  - Open Skins > Frames > Icons > Native auras (Aure native in Italian). These options apply globally to all frames and skins, so this tab does not show the frame selector or Copy to frames controls.
  - On Forever, ordinary bars use legacy buff icons outside combat and native buff rows in combat. Their first-row count follows the skin's Max icons and the global Buff icon cap; zero disables the row. Debuffs likewise respect Max icons and Debuff icon cap.
  - Native Custom Buffs honor Self/Everyone through separate groups without duplicating your own casts. With both scopes configured, Everyone reserves half the existing icon slots (rounded up), and Self receives the rest; unused reserved slots cannot be borrowed. My Class keeps its existing player-only native limitation.
  - ID-only custom buffs remain independent across ranks; name-mode matching includes public spellbook/cache families. With Also in combat enabled, custom selections and exclusions update prepared groups without rebuilding the row.
  - Countdown numbers offers Follow skin, Always show and Always hide. With Follow skin selected, use Duration in the relevant Buffs/Debuffs > Text tab; Count controls stack text independently.
  - Maximum buff duration is in seconds: 120 excludes buffs longer than two minutes and permanent buffs; 0 means no limit, the 26.11.20 default.
  - Use skin icon size follows each frame's skin. Uncheck it to select a global Icon size. The Priest spell filter is available for priests on Forever.
  - Settings save automatically. Changes requiring new icons are deferred until combat ends. UI and `/hbca` commands share the same saved settings and stay synchronized; commands remain optional shortcuts.
  - An explicit Target binding takes priority over SmartCast in this branch. To use SmartCast's out-of-combat buff/cure/resurrection selection, bind a healing spell to unmodified left-click and move Target to a modifier or another button.
  - See [Forever frame and buff reliability](Docs/forever-frame-and-buff-reliability.md) for movement/startup behavior, caster limits and the in-game verification checklist.

Installing and Updating
-----------------------
  - Completely log off WoW
  - Unzip the downloaded
  - Copy the HealBot folders into your WoW Addons folder.
  - Logon to WoW as your main Healer.
  - As a priority you should open the options and configure spells, debuffs and buffs.
