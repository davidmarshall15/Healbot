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
  - Combat timer overrides can be reset to the skin preference with `/hbca nums skin`.


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
  - This is enabled by default on Forever. Use `/hbca persist off` for the previous out-of-combat filtering, or `/hbca persist on` to restore it.
  - Debuff monitoring, bar-colour settings and `/hbca off` still control their respective displays. If native icons are unavailable, HealBot keeps its normal icon renderer.

Installing and Updating
-----------------------
  - Completely log off WoW
  - Unzip the downloaded
  - Copy the HealBot folders into your WoW Addons folder.
  - Logon to WoW as your main Healer.
  - As a priority you should open the options and configure spells, debuffs and buffs.
