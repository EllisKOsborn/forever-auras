# Forever Auras: project notes for Claude

Read this first in every session. Keep it current: if you change a decision,
the status or a convention, update this file in the same commit.

## What this is
ForeverAuras import packs for **WoW Forever** (Blizzard's 2026 classic-era
realm, client 1.60.1, level cap 60). ForeverAuras = the Forever port of
WeakAuras (github.com/neroxrw/foreverauras, GPL v2, CurseForge project
1703325). A standalone project.

## The person you're working with
- **Not a developer**, often on their **phone**. Plain language, short
  replies, long material in repo files.
- Wants you to **push back** on bad ideas and to **plan first** for big changes.
- **Never claim anything works in game** until they confirm it. So far
  everything is checked only against ForeverAuras' rules read from its source.

## Status (17 Nov 2026, v1.3.1)
- **Shadow Priest v1.0.0**: owner imported it in game on 17 Nov 2026,
  "works fine it seems" (no item-by-item report yet).
- **Shadow Priest v1.1.0**: cast bar (owner's request). v1.2.0 renamed to
  "Forever Auras | Shadow Priest" (no guild). v1.2.1: own Shadow Weaving only.
- **Shadow Priest v1.3.0** (`packs/ShadowPriest.txt`, 34 displays), owner's
  picks after research (17 Nov): procs, race + VE cooldowns, mana bar,
  coloured feedback, Mind Flay ticks, cleaner icons. Not asked for: food /
  weapon oil reminders. Nothing since v1.0.0 is tested in game. In-game
  checklist: README "Testing in game".
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
- uids come from `M.UID_KEY` + the name after the prefix (`Build.UidKey`), so the
  shown prefix can change; keep the rest of each name stable, or re-imports
  make a copy instead of offering **Update**. v1.2.0 changed uids once (rename).
- **Nothing in this repo refers to any guild** (owner, 17 Nov 2026): it is a
  standalone public project. Bump `M.VERSION` (semver) per release.

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
- Cast bar: `type = "unit"`, `event = "Cast"`, `unit = "player"`,
  `use_unit = true` on an `aurabar`. When cast info is secret in combat, FA
  uses `UnitCastingDuration`/`UnitChannelDuration` and the game drives the
  bar (Prototypes.lua `["Cast"]`). Same setup as Forever Aura HUD's Core cast
  bar. The game's own cast bar is not hidden (would need custom code).
- Looks on Aura (Modern) icons (SecretAuraConditions.lua): `subborder`
  `border_color` may change with Aura Active = false; a `subglow` may be
  turned on by `faAuraRemaining` with op `"<"` and a value > 0 (the game
  draws it: Display.LateGlowSpec); `faAuraApplications` may only change the
  `%s` text (`text_color`). Proc glows: a `subglow` with `glow = true`.
- Tick marks inside a bar are hidden while the bar's values are secret
  (SubRegionTypes/Tick.lua), so Mind Flay ticks are two `texture` displays
  (2 px, strata HIGH) with a Cast trigger `use_castType`/`castType =
  "channel"` (the spell name can be secret; cast type is not).
- Mana bar: `event = "Power"`, `use_powertype = true`, `powertype = 0`;
  `%percentpower` with format Number, precision 0, round "floor" (the floor
  formatter handles secret numbers). `%%` prints a literal %.
- Only with a target (v1.3.1, owner: icons showing without a target looked
  pointless): Mind Blast / SW:Death have a 2nd trigger `Unit Characteristics`
  on `target` (active while it exists), `disjunctive = "all"`, activeTriggerMode
  stays 1. The DoT icons already fade without a target (FA does that for
  Aura (Modern) on optional units).
- Mana amount: `%p` (the power value) with format `BigNumber` /
  `AbbreviateNumbers` → "4.3K". Blizzard's API docs (forever branch,
  LocalizationDocumentation.lua) mark AbbreviateNumbers
  `SecretArguments = "AllowedWhenTainted"`, so it takes combat's hidden numbers.
- Ready glow on legacy cooldown icons: condition `AND` of `onCooldown = 0`
  (trigger 1) and global `incombat = 1` (trigger -1).
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
- v1.3.0 (Blizzard deep dive + data): Vampiric Embrace 30 s debuff, 30 s
  cooldown (data; the beta article said 1 min). Mind Flay 3 s, tick every
  1 s (SpellEffect period 1000, duration 3000). Spirit Tap buff 15271 (15 s,
  talent 15270). Race priest spells with cooldowns: `M.RACIALS` (race masks
  Human 1, Dwarf 4, Night Elf 8, Undead 16, Gnome 64, Troll 128); Touch of
  Weakness, Hex of Weakness and Shadowguard have no cooldown (could become
  missing-buff reminders: Touch of Weakness 2652, Shadowguard 18137).
  Forever-only talents (Improved Mind Flay 1225139, Devouring Contagion
  1309950, Early Demise 1310076) are in SpellName but not in Talent.csv.
  Shadowfiend 401977 is in the data but no source mentions it: left out.
- Shadow Weaving debuff is 15258 (named "Shadow Weaving" in Forever). In
  Forever it helps only the casting priest (Blizzard deep dive), so it uses
  the `PLAYER` filter like the DoTs (fixed in v1.2.1).

## Layout
```
packs/      import strings (generated)
tools/      build.lua (the pack, codec, --check, --layout), layout.js (docs/layout.png from --layout)
tests/      pack_spec.lua (busted), fa-check.lua (optional, needs FA source)
vendor/     LibStub, LibSerialize, LibDeflate (licences inside)
docs/       layout.png
```

## Dev environment (cloud sessions)
- `apt-get install lua5.1 liblua5.1-0-dev luarocks`; `luarocks --lua-version=5.1 install luacheck busted`.
  GitHub archive downloads are blocked by the proxy: `git clone` lua-term
  (tag 0.08) and mediator_lua (tag v1.1.2-0) and `luarocks make` their
  rockspecs first.
- `node tools/layout.js` needs Playwright: run with `NODE_PATH=$(npm root -g)`.
