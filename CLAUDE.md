# Forever Auras: project notes for Claude

Read this first in every session. Keep it current: if you change a decision,
the status or a convention, update this file in the same commit.

## What this is
ForeverAuras import packs for **WoW Forever** (Blizzard's 2026 classic-era
realm, client 1.60.1, level cap 60). ForeverAuras = the Forever port of
WeakAuras (github.com/neroxrw/foreverauras, GPL v2, CurseForge project
1703325). Made for the guild **Short Royalty** (its addon lives in
`EllisKOsborn/forever-shortroyalty`; this repo was split off from it on
17 Nov 2026 and shares no code with it).

## The person you're working with
- **Not a developer**, often on their **phone**. Plain language, short
  replies, long material in repo files.
- Wants you to **push back** on bad ideas and to **plan first** for big changes.
- **Never claim anything works in game** until they confirm it. So far
  everything is checked only against ForeverAuras' rules read from its source.

## Status (17 Nov 2026)
- **Shadow Priest v1.0.0** (`packs/ShadowPriest.txt`, 17 displays), not
  tested in game. In-game checklist: README "Testing in game".
- `tests/fa-check.lua` (runs FA's real `Display.Validate`) was written but
  **not run**: running downloaded third-party code was blocked in the cloud
  session. Ask the owner before running it, or before adding it to CI.

## Rules
- **Forever data only** (owner's rule): spell IDs from wago.tools product
  `wowf` (SkillLineAbility + SpellName CSVs, `https://wago.tools/db2/<Table>/csv?build=<build>`),
  never Retail/Classic. Cross-check with FA's `SecretAuraRanks.lua` /
  `SpellNameData.lua` and a Forever guide. Never guess an ID.
  Entries with AcquireMethod 3 in SkillLineAbility (Dispersion 425294,
  Vampiric Touch 402668, Mind Sear, Void Plague…) are rune leftovers in the
  client files, not Forever priest spells.
- Use **rank 1** IDs: FA matches an ID to every rank of the same spell.
- **Don't copy code** from ForeverAuras, Forever Aura HUD (both GPL v2) or
  other packs. Reading them to learn the format is fine; credit in README.
- Edit `tools/build.lua`, then `lua5.1 tools/build.lua` (writes the pack and
  the README copy). Never hand-edit an import string.
- Every change: `busted --lua=lua5.1`, `luacheck .`, `lua5.1 tools/build.lua --check`
  green; README and CHANGELOG updated; `node tools/layout.js` when positions change.
- Keep display names (and so uids, `Build.Uid(name)`) stable: re-imports then
  offer **Update** instead of a copy. Bump `M.VERSION` (semver) per release.

## ForeverAuras facts (read from its 1.4.3 source, 15 Nov 2026 commit c421b5f)
- Import string: `"!WA:2!" .. LibDeflate:EncodeForPrint(CompressDeflate(LibSerialize(t), {level = 9}))`,
  `t = { m = "d", v = 2000 (has children) or 1421, s = version, d = root, c = children }`
  (`Transmission.lua` TableToString / Private.DisplayToString). Children are
  listed after their parent. `internalVersion` 91.
- Forever hides auras and cooldowns from addons in combat ("secret values").
  FA's answer: **Aura (Modern)** trigger `type = "secretAura"` (Blizzard draws
  the icon). Fields: `unit`, `debuffType` HELPFUL/HARMFUL,
  `auraRankSpellIDs` + `secretUseRankSpellIDs = true` (name/ID matching all
  ranks), `nativeFilters = { PLAYER = true }` (own only),
  `secretShowOn` = showOnActive | showOnMissing | showAlways.
- `Display.Validate` rules (BlizzardAuraDisplay.lua 778+): icon/aurabar/text/
  progresstexture/texture only; Missing/Always need one unit; no Missing
  DEBUFF by spell ID on player/pet; no display animations; actions only sounds;
  conditions: `faAuraActive` value 0 = Missing look (desaturate, color, zoom,
  alpha, displayIcon), no Else If. A Modern display inside a **dynamic group**
  only gets a warning, so we keep them in plain groups with fixed positions.
- Spell cooldowns: `type = "spell"`, event "Cooldown Progress (Spell)";
  native swipe and the game's countdown numbers work in combat; condition
  `onCooldown`.
- Load: `use_class` + `class.single = "PRIEST"` on **every** display (a
  group's load doesn't pass to children); `use_spellknown` + `spellknown` +
  `use_exact_spellknown = false` hides unknown spells.
- Forever Aura HUD (github.com/tomqwu/wow_forever_weakaura) already ships a
  full priest HUD (needs its companion addon). Ours is a small standalone pack.

## Shadow priest decisions (v1.0.0)
- Priority from WarcraftTavern's Forever guide (author Cyradys): SW:Pain →
  Devouring Plague → Mind Blast → SW:Death → Vampiric Embrace → Mind Flay
  filler. Forever changes: Devouring Plague is for **every race** (race mask
  -1), 24 s cooldown; **Shadow Word: Death** is new (1309595…1309636, L32–56,
  18 s); Vampiric Embrace can be kept up; Devouring Contagion talent spreads DP.
- Not tracked: Mind Flay (no cooldown/aura worth it), Shadowfiend 401977
  (not in the guide), Power Infusion (Discipline).
- Shadow Weaving debuff is 15258 (named "Shadow Weaving" in Forever); anyone's
  counts. DoTs count only our own (`PLAYER` filter).

## Layout
```
packs/      import strings (generated)
tools/      build.lua (the pack, codec, --check, --layout), layout.js (docs/layout.png)
tests/      pack_spec.lua (busted), fa-check.lua (optional, needs FA source)
vendor/     LibStub, LibSerialize, LibDeflate (from forever-shortroyalty's Libs/)
docs/       layout.png
```

## Dev environment (cloud sessions)
- `apt-get install lua5.1 liblua5.1-0-dev luarocks`; `luarocks --lua-version=5.1 install luacheck busted`.
  GitHub archive downloads are blocked by the proxy: `git clone` lua-term
  (tag 0.08) and mediator_lua (tag v1.1.2-0) and `luarocks make` their
  rockspecs first.
- `node tools/layout.js` needs Playwright: run with `NODE_PATH=$(npm root -g)`.
