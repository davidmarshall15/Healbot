HealBot Continued
-----------------

  - Visit the Healbot website for information: https://healbot.dpm15.net.
  - Questions and bug reports on discord:  https://discord.gg/gwa6rdCeZ4
  - Over 80 extra skins packaged and ready for import in-game.


Installing and Updating
-----------------------
  - Completely log off WoW
  - Unzip the downloaded
  - Copy the HealBot folders into your WoW Addons folder.
  - Logon to WoW as your main Healer.
  - As a priority you should open the options and configure spells, debuffs and buffs.

Package checks
--------------
  - Requires Python 3 only; no running WoW client or additional packages needed.
  - From the repository root, run: `python3 -B -m unittest discover -s tests -v`.
  - Checks that supplied statusbar texture paths resolve to packaged files.
  - On failure, the diagnostic names the texture and its declared path.
