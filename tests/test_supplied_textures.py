"""Check registered texture paths against the files shipped with HealBot.

Input: HealBot_Data.lua and the repository's HealBot asset directory.
Output: unittest diagnostics naming any missing texture and its declared path.
Invariant: read-only; no WoW installation, account data or dependencies required.
Run from the repository root: python3 -m unittest discover -s tests -v
"""

import re
import unittest
from pathlib import Path, PureWindowsPath

ADDON = Path(__file__).resolve().parents[1] / "HealBot"


class SuppliedTextureTests(unittest.TestCase):
    def test_registered_textures_resolve_to_shipped_files(self):
        """A catalog path must work as declared, including the Armory entry."""
        source = ADDON / "HealBot_Data.lua"
        self.assertTrue(source.is_file(), f"Missing addon source: {source}")
        text = source.read_text(encoding="utf-8-sig")
        catalog = re.search(
            r"HealBot_Supplied_Textures\s*=\s*\{(.*?)\};", text, re.DOTALL
        )
        self.assertIsNotNone(catalog, "Supplied texture catalog was not found")
        entries = re.findall(
            r'name\s*=\s*"([^"]+)"\s*,\s*file\s*=\s*\[\[(.*?)\]\]',
            catalog.group(1),
        )
        self.assertTrue(entries, "No supplied textures were checked")
        self.assertEqual(
            len(entries),
            len(re.findall(r"\bfile\s*=", catalog.group(1))),
            "Every texture declaration must be covered by this package check",
        )

        # LibSharedMedia receives these paths unchanged. Translate the addon
        # prefix for disk access, retaining all remaining directory segments.
        for name, media_path in entries:
            with self.subTest(texture=name):
                parts = PureWindowsPath(media_path).parts
                self.assertEqual(
                    tuple(part.lower() for part in parts[:3]),
                    ("interface", "addons", "healbot"),
                )
                self.assertNotIn("..", parts)
                self.assertTrue(
                    ADDON.joinpath(*parts[3:]).is_file(),
                    f"{name}: registered texture is not in the package: {media_path}",
                )


if __name__ == "__main__":
    unittest.main()
