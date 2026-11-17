-- Builds packs/ShadowPriest.txt: a ForeverAuras import (shadow priest core
-- spells). ForeverAuras is the WoW Forever port of WeakAuras
-- (github.com/neroxrw/foreverauras, GPL v2); this file writes our own data in
-- its import format, it copies no code from it.
--
-- Usage (from the repository root):
--   lua5.1 tools/build.lua           write packs/ShadowPriest.txt
--   lua5.1 tools/build.lua --check   fail if the file is out of date
--
-- Import format (ForeverAuras 1.4.3, Transmission.lua): "!WA:2!" followed by
-- LibDeflate:EncodeForPrint(CompressDeflate(LibSerialize(t))), where
-- t = { m = "d", v = 2000, s = <FA version>, d = <root group>, c = { children } }.
-- Children come after their group, every display has a fixed uid so that
-- importing a newer version offers "Update" instead of making a copy.
--
-- Spell IDs: checked in Forever's own data (wago.tools product "wowf", build
-- 1.60.1.70938: SkillLineAbility + SpellName), in ForeverAuras' rank tables
-- (SecretAuraRanks.lua / SpellNameData.lua) and against the WarcraftTavern
-- Forever shadow priest guide. Lowest ranks are used: ForeverAuras matches a
-- spell ID to every rank of the same spell, so the pack works while levelling.
local M = {}

local ROOT = (debug.getinfo(1, "S").source:match("^@(.*)tools[/\\]build%.lua$")) or "./"
M.ROOT = ROOT
M.FILE = ROOT .. "packs/ShadowPriest.txt"

M.VERSION = "1.4.0"
M.FA_VERSION = "1.4.3" -- the ForeverAuras version the format was read from
M.INTERNAL = 91        -- ForeverAuras.lua internalVersion (1.4.3)
M.TOC = 16001
M.PREFIX = "Forever Auras | Shadow Priest"
-- uids come from this key, not the shown name, so renaming the pack later
-- still lets ForeverAuras offer "Update".
M.UID_KEY = "ShadowPriest"

-- Every spell the pack uses. `rank1` is what goes into the triggers.
M.SPELLS = {
	swp = { id = 589, name = "Shadow Word: Pain" },      -- ranks 589 … 10894 (L4–58)
	dp = { id = 2944, name = "Devouring Plague" },       -- 2944 … 19280 (L20–60), every race in Forever, 24 s cooldown
	mb = { id = 8092, name = "Mind Blast" },             -- 8092 … 10947 (L10–58), 8 s cooldown
	swd = { id = 1309595, name = "Shadow Word: Death" }, -- 1309595 … 1309636 (L32–56), new in Forever, 18 s cooldown
	ve = { id = 15286, name = "Vampiric Embrace" },      -- talent, debuff on the target
	weaving = { id = 15258, name = "Shadow Weaving" },   -- the debuff (stacks to 5); the talent is 15257
	weavingTalent = { id = 15257, name = "Shadow Weaving" },
	silence = { id = 15487, name = "Silence" },          -- talent, 45 s
	scream = { id = 8122, name = "Psychic Scream" },     -- 30 s
	fade = { id = 586, name = "Fade" },                  -- 30 s
	focus = { id = 14751, name = "Inner Focus" },        -- talent, 3 min
	shadowform = { id = 15473, name = "Shadowform" },
	innerFire = { id = 588, name = "Inner Fire" },
	fort = { id = 1243, name = "Power Word: Fortitude" },
	prayerFort = { id = 21562, name = "Prayer of Fortitude" },
	-- Procs (player buffs).
	spiritTap = { id = 15271, name = "Spirit Tap" },            -- the buff (15 s); the talent is 15270
	spiritTapTalent = { id = 15270, name = "Spirit Tap" },
	-- Inner Focus's buff has the spell's own ID (14751), until the next spell.
	-- Night Elf: Elune's Light is the racial every Night Elf has (+10% crit,
	-- 15 s, 3 min; SkillLine 126, race mask 8); Elune's Grace is the Night Elf
	-- priest spell (15 s, 5 min). Their buffs carry the spells' own IDs.
	eluneLight = { id = 1259799, name = "Elune's Light" },
	eluneGrace = { id = 2651, name = "Elune's Grace" },
	-- Power Word: Shield (30 s, 4 s cooldown) and Weakened Soul (6788, 15 s:
	-- can't be shielded again).
	shield = { id = 17, name = "Power Word: Shield" },
	weakenedSoul = { id = 6788, name = "Weakened Soul" },
	-- Buffs for the reminders (all 1 h or 10 min, cast on yourself).
	divineSpirit = { id = 14752, name = "Divine Spirit" },        -- baseline at 30 in Forever
	prayerSpirit = { id = 27681, name = "Prayer of Spirit" },
	touchWeakness = { id = 2652, name = "Touch of Weakness" },    -- Undead priests
	shadowguard = { id = 18137, name = "Shadowguard" },           -- Troll priests
}

-- Priest spells each race gets in Forever, with a cooldown (Blizzard's
-- priest class deep dive; race masks and cooldowns checked in
-- SkillLineAbility / SpellCooldowns). Spells without a cooldown (Touch of
-- Weakness, Hex of Weakness, Shadowguard) are left out. Each icon only loads
-- for a priest who knows the spell, so only your race's show.
M.RACIALS = {
	{ id = 13896, name = "Feedback", race = "Human" },             -- 3 min
	{ id = 1277370, name = "Divine Grace", race = "Human" },       -- 10 min
	{ id = 13908, name = "Desperate Prayer", race = "Dwarf" },     -- 10 min
	{ id = 1277331, name = "Chastise", race = "Dwarf" },           -- 2 min
	{ id = 10797, name = "Starshards", race = "Night Elf" },       -- 30 s
	{ id = 2651, name = "Elune's Grace", race = "Night Elf" },     -- 5 min
	{ id = 1277455, name = "Confounding Flash", race = "Gnome" },  -- 2 min
	{ id = 1277462, name = "Contingency Plan", race = "Gnome" },   -- 10 min
	{ id = 1277324, name = "Dark Sacrifice", race = "Undead" },    -- 10 min
	{ id = 1259799, name = "Elune's Light", race = "Night Elf" },  -- 3 min (the Night Elf racial)
}

-- Sizes and places (pixels, relative to the screen centre).
M.LAYOUT = {
	rootY = -200,
	big = 44, step = 48,      -- rotation row
	small = 34,               -- cooldown row
	reminder = 36,
	proc = 44, procSmall = 36, -- procs, left of the rotation row
	cast = 16,                -- cast bar height (as wide as the rotation row)
	mana = 12,                -- mana bar height (room for the numbers)
	gap = 6,                  -- between rows
	expire = 3,               -- seconds left when a DoT starts to glow
	execute = 20,             -- target health % below which SW: Death gets the execute frame
}

-- Colours (r, g, b, a).
M.COLOURS = {
	border = { 0, 0, 0, 1 },
	missing = { 0.85, 0.2, 0.15, 1 },     -- missing DoT: red border
	reminder = { 0.95, 0.55, 0.15, 1 },   -- missing buff: orange border
	expiring = { 1, 0.82, 0.35, 1 },      -- DoT running out: gold glow
	ready = { 0.72, 0.52, 1, 1 },         -- Mind Blast / SW: Death ready: purple glow
	proc = { 1, 0.82, 0.35, 1 },          -- proc up: gold glow
	stackFull = { 1, 0.82, 0.35, 1 },     -- 5 Shadow Weaving stacks: gold number
	cast = { 0.58, 0.40, 0.90, 1 },
	mana = { 0.25, 0.52, 1, 1 },
	tick = { 1, 1, 1, 0.75 },
	execute = { 0.95, 0.12, 0.12, 1 },   -- SW: Death execute frame
}

-- Click to rebuff (custom Init code, run by ForeverAuras when the display
-- loads). It puts the game's own secure spell button over the reminder; the
-- display loads only out of combat, and ForeverAuras hides clickable
-- displays in combat with the game's "[combat] hide" driver
-- (RegionPrototype.lua). Out of combat, auras are readable, so the button is
-- hidden while the buff is up (no recasting by clicking an empty spot).
-- %s placeholders: the macro (with %%s for the spell name), the spell to
-- cast, the buffs that count as present.
M.CLICK_CODE = [[
local region = aura_env.region
local macro, castID, buffIDs = %q, %d, { %s }
local function present()
  for _, id in ipairs(buffIDs) do
    local name = C_Spell.GetSpellName(id)
    if name then
      -- Out of combat only, so the result is readable. (Called directly: ForeverAuras
      -- blocks protected calls in custom code.)
      if C_UnitAuras.GetAuraDataBySpellName("player", name, "HELPFUL") then return true end
    end
  end
  return false
end
local function update()
  if InCombatLockdown() then return end
  local button = region.faRebuff
  if not button then
    button = CreateFrame("Button", nil, region, "SecureActionButtonTemplate")
    button:SetAllPoints(region)
    button:RegisterForClicks("AnyUp", "AnyDown")
    region.faRebuff = button
  end
  local spell = C_Spell.GetSpellName(castID)
  if spell then
    button:SetAttribute("type", "macro")
    button:SetAttribute("macrotext", macro:format(spell))
  end
  button:SetShown(not present())
end
local watcher = region.faRebuffWatcher or CreateFrame("Frame")
region.faRebuffWatcher = watcher
watcher:UnregisterAllEvents()
watcher:RegisterEvent("PLAYER_REGEN_ENABLED")
watcher:RegisterEvent("PLAYER_ENTERING_WORLD")
watcher:RegisterUnitEvent("UNIT_AURA", "player")
watcher:SetScript("OnEvent", update)
update()
]]

function M.ClickCode(macro, castID, buffIDs)
	local ids = {}
	for i, id in ipairs(buffIDs) do ids[i] = tostring(id) end
	return M.CLICK_CODE:format(macro, castID, table.concat(ids, ", "))
end
M.WEAVING_MAX = 5

-- uid: 11 characters like ForeverAuras' own, but fixed per display name.
local ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()"
function M.Uid(id)
	local a, b = 5381, 52711
	for i = 1, #id do
		local c = id:byte(i)
		a = (a * 33 + c) % 4294967296
		b = (b * 31 + c * 7) % 4294967296
	end
	local out = {}
	for i = 1, 11 do
		local v = (i <= 6) and a or b
		local n = math.floor(v / (64 ^ ((i - 1) % 5))) % 64
		out[i] = ALPHABET:sub(n + 1, n + 1)
	end
	return table.concat(out)
end

-- The uid key of a display: its name with the shown prefix swapped for UID_KEY.
function M.UidKey(id)
	if id:sub(1, #M.PREFIX) == M.PREFIX then return M.UID_KEY .. id:sub(#M.PREFIX + 1) end
	return id
end

local function color(r, g, b, a) return { r, g, b, a or 1 } end

local function noAnimation()
	local none = { type = "none", easeType = "none", easeStrength = 3, duration_type = "seconds" }
	local function copy() local t = {} for k, v in pairs(none) do t[k] = v end return t end
	return { start = copy(), main = copy(), finish = copy() }
end

local function load(spellID)
	local l = { use_class = true, class = { single = "PRIEST", multi = {} } }
	if spellID then
		l.use_spellknown = true
		l.spellknown = spellID
		l.use_exact_spellknown = false -- any rank counts
	end
	return l
end

-- Fields every display carries (ForeverAuras' own defaults for them).
local function base(id, parent, regionType)
	return {
		id = id, uid = M.Uid(M.UidKey(id)), parent = parent, regionType = regionType,
		internalVersion = M.INTERNAL, tocversion = M.TOC, semver = M.VERSION, version = 1,
		author = "Forever Auras",
		anchorFrameType = "SCREEN", anchorPoint = "CENTER", selfPoint = "CENTER",
		xOffset = 0, yOffset = 0, alpha = 1, scale = 1, frameStrata = 1,
		actions = { start = {}, init = {}, finish = {} },
		animation = noAnimation(),
		conditions = {}, config = {}, authorOptions = {}, subRegions = {},
		information = { forceEvents = false, groupOffset = false, ignoreOptionsEventErrors = false },
		load = load(),
	}
end

-- A trigger that is always on: groups use it, as ForeverAuras' own new groups do.
local function alwaysTrigger()
	return {
		{ trigger = { type = "unit", event = "Conditions", unit = "player", use_alwaystrue = true }, untrigger = {} },
		activeTriggerMode = 1, disjunctive = "all",
	}
end

local function group(id, parent, x, y, children)
	local g = base(id, parent, "group")
	g.xOffset, g.yOffset = x, y
	g.controlledChildren = children
	g.triggers = alwaysTrigger()
	g.border = false
	g.borderBackdrop, g.borderEdge = "Blizzard Tooltip", "Square Full White"
	g.borderColor, g.backdropColor = color(0, 0, 0, 1), color(0, 0, 0, 0)
	g.borderInset, g.borderOffset, g.borderSize = 1, 4, 2
	return g
end

-- A row that closes up when an icon is hidden (cooldown icons only: Aura
-- (Modern) icons get a warning inside a dynamic group).
local function row(id, parent, x, y, children)
	local g = base(id, parent, "dynamicgroup")
	g.xOffset, g.yOffset = x, y
	g.controlledChildren = children
	g.triggers = alwaysTrigger()
	g.grow, g.align, g.space, g.stagger = "HORIZONTAL", "CENTER", 4, 0
	g.centerType, g.sort, g.animate = "LR", "none", false
	g.useLimit, g.limit = false, 12
	g.border = false
	g.borderBackdrop, g.borderEdge = "Blizzard Tooltip", "Square Full White"
	g.borderColor, g.backdropColor = color(0, 0, 0, 1), color(0, 0, 0, 0)
	g.borderInset, g.borderOffset, g.borderSize = 1, 4, 2
	return g
end

local function text(fmt, point, size, x, y, visible)
	return {
		type = "subtext", text_text = fmt, text_visible = visible ~= false,
		anchor_point = point, anchorXOffset = x or 0, anchorYOffset = y or 0,
		text_font = "Friz Quadrata TT", text_fontSize = size, text_fontType = "OUTLINE",
		text_color = color(1, 1, 1, 1), text_justify = "CENTER", text_selfPoint = "AUTO",
		text_shadowColor = color(0, 0, 0, 1), text_shadowXOffset = 0, text_shadowYOffset = 0,
		text_automaticWidth = "Auto", text_fixedWidth = 64, text_wordWrap = "WordWrap", rotateText = "NONE",
		text_text_format_p_format = "timed", text_text_format_p_time_format = 0,
		text_text_format_p_time_precision = 0, text_text_format_p_time_dynamic_threshold = 3,
		text_text_format_s_format = "none",
	}
end

-- A thin border round icons and bars (black unless a colour is given).
local function border(c, parentType)
	local b = { type = "subborder", border_visible = true, border_edge = "Square Full White",
		border_color = c or M.COLOURS.border, border_offset = 0, border_size = 1 }
	if parentType == "aurabar" then b.anchor_area = "bar" end
	return b
end

-- A pixel glow, off unless a condition turns it on (or `on`).
local function glow(c, on)
	return { type = "subglow", glow = on == true, glowType = "Pixel", useGlowColor = true, glowColor = c,
		glowLines = 8, glowFrequency = 0.25, glowDuration = 1, glowLength = 10, glowThickness = 2, glowScale = 1,
		glowBorder = false, glowXOffset = 0, glowYOffset = 0 }
end

-- Adds sub-elements in order and returns each one's index ("sub.N.…").
local function elements(d, list)
	d.subRegions = {}
	local at = {}
	for _, e in ipairs(list) do
		if e[2] then
			d.subRegions[#d.subRegions + 1] = e[2]
			at[e[1]] = #d.subRegions
		end
	end
	return at
end

local function icon(id, parent, size, x, y)
	local d = base(id, parent, "icon")
	d.width, d.height = size, size
	d.xOffset, d.yOffset = x or 0, y or 0
	d.icon, d.iconSource = true, -1
	-- Slight zoom crops the icon's own frame; the thin black border replaces it.
	d.color, d.desaturate, d.zoom, d.keepAspectRatio = color(1, 1, 1, 1), false, 0.08, false
	d.cooldown, d.cooldownSwipe, d.cooldownEdge = true, true, false
	d.useCooldownModRate = true
	d.progressSource = { -1, "" }
	d.adjustedMin, d.adjustedMax = "", ""
	return d
end

-- Aura (Modern) icon: Blizzard draws it, so it keeps working in combat.
-- showOn: "showAlways" (greyed out while missing), "showOnMissing" or "showOnActive".
local function auraIcon(id, parent, size, x, y, o)
	local d = icon(id, parent, size, x, y)
	d.inverse = true
	d.cooldownTextDisabled = true
	d.blizzardAuraDisplay = { maxIcons = 1, sharedDisplay = true, actionSounds = false }
	d.load = load(o.known)
	-- o.combat: true = only in combat, false = only out of combat.
	if o.combat ~= nil then d.load.use_combat = o.combat end
	local trigger = {
		type = "secretAura", event = "Health", auraTracking = "native",
		unit = o.unit, debuffType = o.debuff and "HARMFUL" or "HELPFUL",
		-- Without names (o.spells nil), every aura passes the other filters.
		auraRankSpellIDs = o.spells or {}, secretUseRankSpellIDs = o.spells ~= nil,
		secretUseSpellIDs = false, auraspellids = {}, useExactSpellId = false,
		nativeFilters = o.mine and { PLAYER = true } or {},
		secretShowOn = o.showOn,
	}
	if o.total then
		-- Total Duration = n seconds (ForeverAuras' native gate).
		trigger.secretUseTotal, trigger.secretTotalOperator, trigger.secretTotal = true, "=", tostring(o.total)
	end
	d.triggers = {
		{ trigger = trigger, untrigger = {} },
		activeTriggerMode = 1, disjunctive = "all", secretFallback = "none",
	}
	if o.click then
		d.actions.init = { do_custom = true, custom = M.ClickCode(o.click.macro, o.click.cast, o.spells) }
	end
	local C = M.COLOURS
	local at = elements(d, {
		{ "bg", { type = "subbackground" } },
		{ "border", border(o.borderColour) },
		{ "glow", (o.expire or o.glowAlways) and glow(o.glowAlways and C.proc or C.expiring, o.glowAlways) },
		{ "timer", o.timer ~= false and text("%p", "CENTER", math.floor(size * 0.42), 0, 0) },
		{ "stacks", o.stacks and text("%s", "BOTTOMRIGHT", math.floor(size * 0.42), -2, 2) },
	})
	d.conditions = {}
	if o.showOn == "showAlways" then
		-- Missing: grey, faded and a red border, so the gap in the rotation stands out.
		d.conditions[#d.conditions + 1] = {
			check = { trigger = 1, variable = "faAuraActive", value = 0 },
			changes = {
				{ property = "desaturate", value = true },
				{ property = "alpha", value = 0.5 },
				{ property = "sub." .. at.border .. ".border_color", value = C.missing },
			},
		}
	end
	if o.expire then
		-- Running out: the game lights the glow when fewer than `expire`
		-- seconds are left (ForeverAuras' native Remaining Time glow).
		d.conditions[#d.conditions + 1] = {
			check = { trigger = 1, variable = "faAuraRemaining", op = "<", value = tostring(o.expire) },
			changes = { { property = "sub." .. at.glow .. ".glow", value = true } },
		}
	end
	if o.stackFull then
		-- Full stacks: the stack number turns gold.
		d.conditions[#d.conditions + 1] = {
			check = { trigger = 1, variable = "faAuraApplications", op = ">=", value = tostring(o.stackFull) },
			changes = { { property = "sub." .. at.stacks .. ".text_color", value = C.stackFull } },
		}
	end
	return d
end

-- Spell cooldown icon. showOn: "showAlways" (greyed out while cooling down)
-- or "showOnCooldown" (only while it is cooling down).
local function cooldownIcon(id, parent, size, x, y, spell, showOn, needsTarget)
	local d = icon(id, parent, size, x, y)
	d.inverse = false
	d.cooldownTextDisabled = false -- the game's own countdown numbers
	d.load = load(spell)
	d.triggers = {
		{
			trigger = {
				type = "spell", event = "Cooldown Progress (Spell)", unit = "player",
				spellName = spell, use_spellName = true, use_exact_spellName = false,
				track = "cooldown", use_track = true,
				genericShowOn = showOn, use_genericShowOn = true,
				use_ignoreSpellKnown = false, use_ignoreoverride = false,
				use_showgcd = false, use_showgcdtext = false,
			},
			untrigger = {},
		},
		activeTriggerMode = 1, disjunctive = "all",
	}
	if needsTarget then
		-- Only while you have a target, like the DoT icons beside it: a second
		-- trigger that is active while "target" exists ("all" triggers needed).
		d.triggers[2] = { trigger = { type = "unit", event = "Unit Characteristics", unit = "target", use_unit = true },
			untrigger = {} }
	end
	local always = showOn == "showAlways"
	local at = elements(d, {
		{ "bg", { type = "subbackground" } },
		{ "border", border() },
		{ "glow", always and glow(M.COLOURS.ready) },
	})
	if always then
		d.conditions = {
			{
				check = { trigger = 1, variable = "onCooldown", value = 1 },
				changes = { { property = "desaturate", value = true } },
			},
			{
				-- Ready, and you're in a fight: purple glow. (Not out of
				-- combat, or it would glow all the time.)
				check = { variable = "AND", checks = {
					{ trigger = 1, variable = "onCooldown", value = 0 },
					{ trigger = -1, variable = "incombat", value = 1 },
				} },
				changes = { { property = "sub." .. at.glow .. ".glow", value = true } },
			},
		}
	end
	return d
end

-- Cast bar: ForeverAuras' "Cast" trigger. When Forever hides a cast's
-- details in combat, ForeverAuras hands the game a duration object and the
-- game moves the bar itself (Prototypes.lua, UnitCastingDuration /
-- UnitChannelDuration), so it keeps working in fights. Channels such as Mind
-- Flay drain from full, as the game's own bar does.
local function castBar(id, parent, width, height, x, y)
	local d = base(id, parent, "aurabar")
	d.width, d.height = width, height
	d.xOffset, d.yOffset = x, y
	d.load = load()
	d.orientation, d.inverse = "HORIZONTAL", false
	d.texture, d.textureSource = "Blizzard", "LSM"
	d.barColor, d.barColor2 = color(0.58, 0.40, 0.90, 1), color(1, 1, 1, 1)
	d.backgroundColor = color(0.04, 0.03, 0.07, 0.85)
	d.enableGradient, d.gradientOrientation = false, "HORIZONTAL"
	d.icon, d.iconSource, d.icon_side, d.icon_color = false, -1, "LEFT", color(1, 1, 1, 1)
	d.desaturate, d.zoom = false, 0
	d.spark, d.sparkTexture, d.sparkColor = true, "Interface\\CastingBar\\UI-CastingBar-Spark", color(1, 1, 1, 1)
	d.sparkBlendMode, d.sparkWidth, d.sparkHeight = "ADD", 8, height * 2
	d.sparkOffsetX, d.sparkOffsetY, d.sparkRotation, d.sparkRotationMode, d.sparkHidden = 0, 0, 0, "AUTO", "NEVER"
	d.progressSource = { -1, "" }
	d.adjustedMin, d.adjustedMax = "", ""
	d.triggers = {
		{ trigger = { type = "unit", event = "Cast", unit = "player", use_unit = true, spellNames = {} }, untrigger = {} },
		activeTriggerMode = 1, disjunctive = "all",
	}
	local name = text("%n", "INNER_LEFT", 10, 4, 0)
	local time = text("%p", "INNER_RIGHT", 10, -4, 0)
	time.text_text_format_p_time_precision = 1 -- 1.4 rather than 1
	time.text_text_format_p_time_dynamic_threshold = 0
	d.subRegions = { { type = "subbackground" }, { type = "subforeground" }, border(nil, "aurabar"), name, time }
	return d
end

-- Mana bar: ForeverAuras' Power trigger (mana = power type 0). When Forever
-- hides the numbers in combat, ForeverAuras asks the game for the
-- percentage (UnitPowerPercent) and the game fills the bar.
local function manaBar(id, parent, width, height, x, y)
	local d = base(id, parent, "aurabar")
	d.width, d.height = width, height
	d.xOffset, d.yOffset = x, y
	d.load = load()
	d.orientation, d.inverse = "HORIZONTAL", false
	d.texture, d.textureSource = "Blizzard", "LSM"
	d.barColor, d.barColor2 = color(unpack(M.COLOURS.mana)), color(1, 1, 1, 1)
	d.backgroundColor = color(0.04, 0.03, 0.07, 0.85)
	d.enableGradient, d.gradientOrientation = false, "HORIZONTAL"
	d.icon, d.iconSource, d.icon_side, d.icon_color = false, -1, "LEFT", color(1, 1, 1, 1)
	d.desaturate, d.zoom, d.spark = false, 0, false
	d.progressSource = { -1, "" }
	d.adjustedMin, d.adjustedMax = "", ""
	d.triggers = {
		{ trigger = { type = "unit", event = "Power", unit = "player", use_unit = true,
			use_powertype = true, powertype = 0 }, untrigger = {} },
		activeTriggerMode = 1, disjunctive = "all",
	}
	-- Left: your mana, shortened by the game (4,300 -> "4.3K"); Blizzard's
	-- AbbreviateNumbers accepts the hidden numbers of combat
	-- (SecretArguments = "AllowedWhenTainted" in its API documentation).
	local amount = text("%p", "INNER_LEFT", 9, 3, 0)
	amount.text_text_format_p_format = "BigNumber"
	amount.text_text_format_p_big_number_format = "AbbreviateNumbers"
	-- Right: the percentage.
	local pct = text("%percentpower%%", "INNER_RIGHT", 9, -3, 0)
	pct.text_text_format_percentpower_format = "Number"
	pct.text_text_format_percentpower_decimal_precision = 0
	pct.text_text_format_percentpower_round_type = "floor"
	d.subRegions = { { type = "subbackground" }, { type = "subforeground" }, border(nil, "aurabar"), amount, pct }
	return d
end

-- A thin line over the cast bar, shown only while channelling (Mind Flay
-- ticks). It is its own display because ForeverAuras hides tick marks inside
-- a bar while the game keeps the cast's timing secret (SubRegionTypes/Tick.lua).
-- Only "is it a channel" is checked: the spell's name can be secret in combat.
local function tickLine(id, parent, height, x, y)
	local d = base(id, parent, "texture")
	d.width, d.height = 2, height
	d.xOffset, d.yOffset = x, y
	d.load = load()
	d.frameStrata = 5 -- above the cast bar
	d.texture = "Interface\\Buttons\\WHITE8X8"
	d.color = color(unpack(M.COLOURS.tick))
	d.desaturate, d.blendMode, d.textureWrapMode = false, "BLEND", "CLAMPTOBLACKADDITIVE"
	d.rotation, d.rotate, d.mirror = 0, false, false
	d.triggers = {
		{ trigger = { type = "unit", event = "Cast", unit = "player", use_unit = true, spellNames = {},
			use_castType = true, castType = "channel" }, untrigger = {} },
		activeTriggerMode = 1, disjunctive = "all",
	}
	return d
end

-- Execute frame: a red square just larger than Shadow Word: Death's icon,
-- drawn behind it (strata LOW), so it shows as a red frame. It is invisible
-- (alpha 0) unless your target's health is below `percent`: ForeverAuras
-- compares the hidden health percentage through the game's own curves
-- (Conditions.lua, PowerCurve), which may change alpha but not glows.
-- Only while Shadow Word: Death is ready (second trigger).
local function executeFrame(id, parent, size, x, y, spell, percent)
	local d = base(id, parent, "texture")
	d.width, d.height = size + 6, size + 6
	d.xOffset, d.yOffset = x, y
	d.load = load(spell)
	d.frameStrata = 3 -- LOW: behind the icon (which inherits MEDIUM)
	d.alpha = 0
	d.texture = "Interface\\Buttons\\WHITE8X8"
	d.color = color(unpack(M.COLOURS.execute))
	d.desaturate, d.blendMode, d.textureWrapMode = false, "BLEND", "CLAMPTOBLACKADDITIVE"
	d.rotation, d.rotate, d.mirror = 0, false, false
	d.triggers = {
		{ trigger = { type = "unit", event = "Health", unit = "target", use_unit = true }, untrigger = {} },
		{ trigger = { type = "spell", event = "Cooldown Progress (Spell)", unit = "player",
			spellName = spell, use_spellName = true, use_exact_spellName = false,
			track = "cooldown", use_track = true, genericShowOn = "showOnReady", use_genericShowOn = true,
			use_ignoreSpellKnown = false, use_ignoreoverride = false, use_showgcd = false, use_showgcdtext = false },
			untrigger = {} },
		activeTriggerMode = 1, disjunctive = "all",
	}
	d.conditions = {
		{ check = { trigger = 1, variable = "percenthealth", op = "<", value = percent },
			changes = { { property = "alpha", value = 1 } } },
	}
	return d
end

function M.Build()
	local S, L, P = M.SPELLS, M.LAYOUT, M.PREFIX
	local rotationID, cooldownID, reminderID = P .. " | Rotation", P .. " | Cooldowns", P .. " | Reminders"
	local procID, castID, manaID = P .. " | Procs", P .. " | Cast bar", P .. " | Mana bar"
	local children = {}
	local function add(d) children[#children + 1] = d return d.id end
	local rowWidth = 6 * L.step - (L.step - L.big) -- the rotation row, edge to edge

	-- Rotation row, in the guide's priority order: keep both DoTs up, Mind
	-- Blast and Shadow Word: Death on cooldown, keep Vampiric Embrace up;
	-- Shadow Weaving stacks at the end.
	local rotation = group(rotationID, P, 0, 0, {})
	add(rotation)
	local function x(i) return (i - 3.5) * L.step end
	local rot = rotation.controlledChildren
	local function dot(spell, i)
		rot[#rot + 1] = add(auraIcon(rotationID .. " | " .. spell.name, rotationID, L.big, x(i), 0,
			{ unit = "target", debuff = true, mine = true, spells = { spell.id }, showOn = "showAlways",
				known = spell.id, expire = L.expire }))
	end
	dot(S.swp, 1)
	dot(S.dp, 2)
	rot[#rot + 1] = add(cooldownIcon(rotationID .. " | " .. S.mb.name, rotationID, L.big, x(3), 0, S.mb.id, "showAlways", true))
	rot[#rot + 1] = add(cooldownIcon(rotationID .. " | " .. S.swd.name, rotationID, L.big, x(4), 0, S.swd.id, "showAlways",
		true))
	-- Red frame round Shadow Word: Death below 20% target health (Early
	-- Demise's threshold). A % is the only health the game lets addons use in
	-- combat, so this marks an execute window, not a guaranteed kill.
	rot[#rot + 1] = add(executeFrame(rotationID .. " | " .. S.swd.name .. " execute", rotationID, L.big, x(4), 0,
		S.swd.id, L.execute))
	dot(S.ve, 5)
	-- Only my own Shadow Weaving counts: in Forever it boosts only the priest
	-- who applied it (Blizzard's class deep dive; the debuff text reads
	-- "Taking x% increased Shadow damage from the caster").
	rot[#rot + 1] = add(auraIcon(rotationID .. " | " .. S.weaving.name, rotationID, L.big, x(6), 0,
		{ unit = "target", debuff = true, mine = true, spells = { S.weaving.id }, showOn = "showAlways",
			known = S.weavingTalent.id, stacks = true, timer = false, stackFull = M.WEAVING_MAX }))

	-- Procs and short buffs, left of the rotation row in a 2 x 2 block, only
	-- while up (with a gold glow). Elune's Light and Elune's Grace only load
	-- for Night Elves (who know them).
	local cell = L.procSmall + L.gap
	local procs = group(procID, P, -(rowWidth / 2 + L.gap + 4 + L.procSmall / 2), 0, {})
	add(procs)
	local function proc(spell, known, px, py, timer)
		procs.controlledChildren[#procs.controlledChildren + 1] = add(auraIcon(procID .. " | " .. spell.name, procID,
			L.procSmall, px, py, { unit = "player", spells = { spell.id }, showOn = "showOnActive", known = known,
				glowAlways = true, timer = timer }))
	end
	proc(S.spiritTap, S.spiritTapTalent.id, 0, 0)
	proc(S.focus, S.focus.id, 0, -cell, false) -- lasts until your next spell: no timer
	proc(S.eluneLight, S.eluneLight.id, -cell, 0)
	proc(S.eluneGrace, S.eluneGrace.id, -cell, -cell)

	-- Shield, right of the rotation row: Power Word: Shield on you (anyone's)
	-- and, under it, Weakened Soul. Debuffs on you can't be matched by spell ID
	-- in combat (ForeverAuras' rule), so Weakened Soul is "a debuff you cast
	-- on yourself that lasts exactly 15 seconds". Another priest's Weakened
	-- Soul is not shown.
	local shieldID = P .. " | Shield"
	local shield = group(shieldID, P, rowWidth / 2 + L.gap + 4 + L.procSmall / 2, 0, {})
	add(shield)
	shield.controlledChildren[#shield.controlledChildren + 1] = add(auraIcon(shieldID .. " | " .. S.shield.name, shieldID,
		L.procSmall, 0, 0, { unit = "player", spells = { S.shield.id }, showOn = "showOnActive", known = S.shield.id }))
	shield.controlledChildren[#shield.controlledChildren + 1] = add(auraIcon(shieldID .. " | " .. S.weakenedSoul.name,
		shieldID, L.procSmall, 0, -cell, { unit = "player", debuff = true, mine = true, showOn = "showOnActive",
			total = 15, known = S.shield.id, borderColour = M.COLOURS.missing }))

	-- Cast bar right under the rotation row, as wide as the row, with two
	-- lines at a third and two thirds while channelling (Mind Flay: 3 s,
	-- one tick a second in Forever's data).
	local castY = -(L.big / 2 + L.gap + L.cast / 2)
	add(castBar(castID, P, rowWidth, L.cast, 0, castY))
	local tickIDs = {}
	for i = 1, 2 do
		tickIDs[i] = add(tickLine(P .. " | Cast bar tick " .. i, P, L.cast, -rowWidth / 2 + rowWidth * i / 3, castY))
	end

	-- Mana bar, thin, right under the cast bar.
	local manaY = castY - (L.cast / 2 + 2 + L.mana / 2)
	add(manaBar(manaID, P, rowWidth, L.mana, 0, manaY))

	-- Cooldown row under the bars: only while cooling down, so it is empty
	-- when everything is ready. Your race's priest spells join it.
	local cds = row(cooldownID, P, 0, manaY - (L.mana / 2 + L.gap + L.small / 2), {})
	add(cds)
	local cdSpells = { S.silence, S.scream, S.fade, S.focus, S.ve }
	for _, r in ipairs(M.RACIALS) do cdSpells[#cdSpells + 1] = r end
	for _, s in ipairs(cdSpells) do
		cds.controlledChildren[#cds.controlledChildren + 1] =
			add(cooldownIcon(cooldownID .. " | " .. s.name, cooldownID, L.small, 0, 0, s.id, "showOnCooldown"))
	end

	-- Reminders above the rotation row: only while the buff is missing, with
	-- an orange border.
	local rem = group(reminderID, P, 0, L.big / 2 + 10 + L.reminder / 2, {})
	add(rem)
	local remStep = L.reminder + 6
	local function slot(i) return (i - 3) * remStep end
	-- Out of combat each reminder is clickable: it casts the buff on you.
	-- macro: "%s" is the spell's name in your game's language.
	local function reminder(name, spells, known, xx, macro, inCombat)
		local o = { unit = "player", spells = spells, showOn = "showOnMissing", known = known,
			timer = false, borderColour = M.COLOURS.reminder }
		if inCombat then
			o.combat = true
		else
			o.combat, o.click = false, { macro = macro, cast = spells[1] }
		end
		rem.controlledChildren[#rem.controlledChildren + 1] = add(auraIcon(reminderID .. " | " .. name .. " missing"
			.. (inCombat and " (in combat)" or ""), reminderID, L.reminder, xx, 0, o))
	end
	-- "!" makes /cast never switch you out of Shadowform.
	reminder(S.shadowform.name, { S.shadowform.id }, S.shadowform.id, slot(1), "/cast !%s")
	-- In combat the clickable reminders hide; Shadowform still warns, unclickable.
	reminder(S.shadowform.name, { S.shadowform.id }, S.shadowform.id, slot(1), nil, true)
	reminder(S.innerFire.name, { S.innerFire.id }, S.innerFire.id, slot(2), "/cast %s")
	-- Either Fortitude / Spirit counts (yours or another priest's, single or Prayer).
	reminder("Fortitude", { S.fort.id, S.prayerFort.id }, S.fort.id, slot(3), "/cast [@player] %s")
	reminder(S.divineSpirit.name, { S.divineSpirit.id, S.prayerSpirit.id }, S.divineSpirit.id, slot(4),
		"/cast [@player] %s")
	-- Race self-buffs share a spot (no priest has both).
	reminder(S.touchWeakness.name, { S.touchWeakness.id }, S.touchWeakness.id, slot(5), "/cast %s")
	reminder(S.shadowguard.name, { S.shadowguard.id }, S.shadowguard.id, slot(5), "/cast %s")

	-- The root holds the parts; it is placed below the character.
	local parts = { procID, rotationID, shieldID, castID, tickIDs[1], tickIDs[2], manaID, cooldownID, reminderID }
	local root = group(P, nil, 0, L.rootY, parts)
	root.desc = "Forever Auras shadow priest pack " .. M.VERSION .. ". Rotation (Shadow Word: Pain, Devouring Plague, "
		.. "Mind Blast, Shadow Word: Death with an execute frame, Vampiric Embrace, Shadow Weaving), procs, Power Word: "
		.. "Shield and Weakened Soul, cast bar with Mind Flay ticks, mana bar, cooldowns (with your race's spells) and "
		.. "missing-buff reminders you can click to rebuff out of combat. Priests only; spells you don't know yet stay "
		.. "hidden."
	root.groupIcon = "Interface\\Icons\\Spell_Shadow_Shadowform"

	-- Children are listed group first, then that group's displays (the order
	-- ForeverAuras itself exports in).
	local ordered, byId = {}, {}
	for _, d in ipairs(children) do byId[d.id] = d end
	for _, gid in ipairs(root.controlledChildren) do
		local g = byId[gid]
		ordered[#ordered + 1] = g
		for _, cid in ipairs(g.controlledChildren or {}) do ordered[#ordered + 1] = byId[cid] end
	end
	return { m = "d", v = 2000, s = M.FA_VERSION, d = root, c = ordered }
end

-- Codec ----------------------------------------------------------------------
local libs
local function Libs()
	if libs then return libs end
	if not LibStub then dofile(ROOT .. "vendor/LibStub/LibStub.lua") end
	if not LibStub("LibSerialize", true) then dofile(ROOT .. "vendor/LibSerialize/LibSerialize.lua") end
	if not LibStub("LibDeflate", true) then dofile(ROOT .. "vendor/LibDeflate/LibDeflate.lua") end
	libs = { LS = LibStub("LibSerialize"), LD = LibStub("LibDeflate") }
	return libs
end

function M.Encode(t)
	local l = Libs()
	local raw = l.LS:SerializeEx({ errorOnUnserializableType = true, stable = true }, t)
	return "!WA:2!" .. l.LD:EncodeForPrint(l.LD:CompressDeflate(raw, { level = 9 }))
end

function M.Decode(s)
	local l = Libs()
	local enc = s:match("^%s*!WA:2!(.-)%s*$")
	if not enc then return nil, "not a ForeverAuras import" end
	local bytes = l.LD:DecodeForPrint(enc)
	if not bytes then return nil, "bad encoding" end
	local raw = l.LD:DecompressDeflate(bytes)
	if not raw then return nil, "bad compression" end
	local ok, t = l.LS:Deserialize(raw)
	if not ok then return nil, t end
	return t
end

-- The README carries a copy of the import string between these markers, so
-- it can be copied with GitHub's copy button (easier on a phone).
M.README = ROOT .. "README.md"
M.MARK_START = "<!-- pack:ShadowPriest start (written by tools/build.lua) -->"
M.MARK_END = "<!-- pack:ShadowPriest end -->"

local function readFile(path)
	local f = io.open(path, "rb")
	if not f then return nil end
	local s = f:read("*a")
	f:close()
	return s
end
M.ReadFile = readFile

local function plain(s) return (s:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0")) end

-- The README with the import string block replaced (nil if no markers).
function M.ReadmeWith(readme, s)
	local block = M.MARK_START .. "\n```text\n" .. s .. "\n```\n" .. M.MARK_END
	local out, n = readme:gsub(plain(M.MARK_START) .. ".-" .. plain(M.MARK_END), function() return block end)
	if n ~= 1 then return nil end
	return out
end

local function main(args)
	local s = M.Encode(M.Build())
	local readme = readFile(M.README)
	local newReadme = readme and M.ReadmeWith(readme, s)
	if args[1] == "--layout" then
		-- Icon places on screen, for tools/layout.js (the README picture).
		local t = M.Build()
		local byId = { [t.d.id] = t.d }
		for _, d in ipairs(t.c) do byId[d.id] = d end
		local rows = {}
		for _, d in ipairs(t.c) do
			if d.regionType == "icon" or d.regionType == "aurabar" or d.regionType == "texture" then
				local x, y, p = d.xOffset, d.yOffset, byId[d.parent]
				local dynamic = p.regionType == "dynamicgroup"
				local rowName = p == t.d and d.id:match("| ([^|]+)$") or d.parent:match("| ([^|]+)$")
				while p do x, y, p = x + p.xOffset, y + p.yOffset, byId[p.parent] end
				rows[#rows + 1] = ('{"name":"%s","x":%g,"y":%g,"w":%g,"h":%g,"row":"%s","dynamic":%s}'):format(
					d.id:match("| ([^|]+)$"), x, y, d.width, d.height, rowName, tostring(dynamic))
			end
		end
		print("[" .. table.concat(rows, ",") .. "]")
		return
	end
	if args[1] == "--check" then
		local old = readFile(M.FILE) or ""
		if old:gsub("%s+$", "") ~= s or newReadme ~= readme then
			io.stderr:write("packs/ShadowPriest.txt or README.md is out of date: run lua5.1 tools/build.lua\n")
			os.exit(1)
		end
		print("packs/ShadowPriest.txt and README.md are up to date")
		return
	end
	local f = assert(io.open(M.FILE, "wb"))
	f:write(s, "\n")
	f:close()
	if newReadme then
		f = assert(io.open(M.README, "wb"))
		f:write(newReadme)
		f:close()
	elseif readme then
		io.stderr:write("README.md has no pack markers: its copy was not updated\n")
	end
	local t = M.Build()
	print(("Wrote %s: %d displays, %d characters"):format(M.FILE, #t.c + 1, #s))
end

if arg and arg[0] and arg[0]:match("build%.lua$") then main(arg) end

return M
