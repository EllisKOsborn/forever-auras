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

M.VERSION = "1.0.0"
M.FA_VERSION = "1.4.3" -- the ForeverAuras version the format was read from
M.INTERNAL = 91        -- ForeverAuras.lua internalVersion (1.4.3)
M.TOC = 16001
M.PREFIX = "Short Royalty | Shadow Priest"

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
}

-- Sizes and places (pixels, relative to the screen centre).
M.LAYOUT = {
	rootY = -200,
	big = 44, step = 48,      -- rotation row
	small = 34,               -- cooldown row
	reminder = 36,
}

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
		id = id, uid = M.Uid(id), parent = parent, regionType = regionType,
		internalVersion = M.INTERNAL, tocversion = M.TOC, semver = M.VERSION, version = 1,
		author = "Short Royalty",
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

local function icon(id, parent, size, x, y)
	local d = base(id, parent, "icon")
	d.width, d.height = size, size
	d.xOffset, d.yOffset = x or 0, y or 0
	d.icon, d.iconSource = true, -1
	d.color, d.desaturate, d.zoom, d.keepAspectRatio = color(1, 1, 1, 1), false, 0.18, false
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
	d.triggers = {
		{
			trigger = {
				type = "secretAura", event = "Health", auraTracking = "native",
				unit = o.unit, debuffType = o.debuff and "HARMFUL" or "HELPFUL",
				auraRankSpellIDs = o.spells, secretUseRankSpellIDs = true,
				secretUseSpellIDs = false, auraspellids = {}, useExactSpellId = false,
				nativeFilters = o.mine and { PLAYER = true } or {},
				secretShowOn = o.showOn,
			},
			untrigger = {},
		},
		activeTriggerMode = 1, disjunctive = "all", secretFallback = "none",
	}
	d.subRegions = { { type = "subbackground" } }
	if o.timer ~= false then
		d.subRegions[#d.subRegions + 1] = text("%p", "CENTER", math.floor(size * 0.36), 0, 0)
	end
	if o.stacks then
		d.subRegions[#d.subRegions + 1] = text("%s", "BOTTOMRIGHT", math.floor(size * 0.4), -2, 2)
	end
	if o.showOn == "showAlways" then
		-- Missing: grey and faded, so the gap in the rotation stands out.
		d.conditions = {
			{
				check = { trigger = 1, variable = "faAuraActive", value = 0 },
				changes = { { property = "desaturate", value = true }, { property = "alpha", value = 0.45 } },
			},
		}
	end
	return d
end

-- Spell cooldown icon. showOn: "showAlways" (greyed out while cooling down)
-- or "showOnCooldown" (only while it is cooling down).
local function cooldownIcon(id, parent, size, x, y, spell, showOn)
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
	d.subRegions = { { type = "subbackground" } }
	if showOn == "showAlways" then
		d.conditions = {
			{
				check = { trigger = 1, variable = "onCooldown", value = 1 },
				changes = { { property = "desaturate", value = true } },
			},
		}
	end
	return d
end

function M.Build()
	local S, L, P = M.SPELLS, M.LAYOUT, M.PREFIX
	local rotationID, cooldownID, reminderID = P .. " | Rotation", P .. " | Cooldowns", P .. " | Reminders"
	local children = {}
	local function add(d) children[#children + 1] = d return d.id end

	-- Rotation row, in the guide's priority order: keep both DoTs up, Mind
	-- Blast and Shadow Word: Death on cooldown, keep Vampiric Embrace up;
	-- Shadow Weaving stacks at the end.
	local rotation = group(rotationID, P, 0, 0, {})
	add(rotation)
	local function x(i) return (i - 3.5) * L.step end
	local rot = rotation.controlledChildren
	rot[#rot + 1] = add(auraIcon(rotationID .. " | " .. S.swp.name, rotationID, L.big, x(1), 0,
		{ unit = "target", debuff = true, mine = true, spells = { S.swp.id }, showOn = "showAlways", known = S.swp.id }))
	rot[#rot + 1] = add(auraIcon(rotationID .. " | " .. S.dp.name, rotationID, L.big, x(2), 0,
		{ unit = "target", debuff = true, mine = true, spells = { S.dp.id }, showOn = "showAlways", known = S.dp.id }))
	rot[#rot + 1] = add(cooldownIcon(rotationID .. " | " .. S.mb.name, rotationID, L.big, x(3), 0, S.mb.id, "showAlways"))
	rot[#rot + 1] = add(cooldownIcon(rotationID .. " | " .. S.swd.name, rotationID, L.big, x(4), 0, S.swd.id, "showAlways"))
	rot[#rot + 1] = add(auraIcon(rotationID .. " | " .. S.ve.name, rotationID, L.big, x(5), 0,
		{ unit = "target", debuff = true, mine = true, spells = { S.ve.id }, showOn = "showAlways", known = S.ve.id }))
	-- Any priest's Shadow Weaving counts, so not only mine.
	rot[#rot + 1] = add(auraIcon(rotationID .. " | " .. S.weaving.name, rotationID, L.big, x(6), 0,
		{ unit = "target", debuff = true, mine = false, spells = { S.weaving.id }, showOn = "showAlways",
			known = S.weavingTalent.id, stacks = true, timer = false }))

	-- Cooldown row under it: only while cooling down, so it is empty when
	-- everything is ready.
	local cds = row(cooldownID, P, 0, -(L.big / 2 + 6 + L.small / 2), {})
	add(cds)
	for _, key in ipairs({ "silence", "scream", "fade", "focus" }) do
		local s = S[key]
		cds.controlledChildren[#cds.controlledChildren + 1] =
			add(cooldownIcon(cooldownID .. " | " .. s.name, cooldownID, L.small, 0, 0, s.id, "showOnCooldown"))
	end

	-- Reminders above the rotation row: only while the buff is missing.
	local rem = group(reminderID, P, 0, L.big / 2 + 10 + L.reminder / 2, {})
	add(rem)
	local remStep = L.reminder + 6
	rem.controlledChildren[#rem.controlledChildren + 1] = add(auraIcon(reminderID .. " | " .. S.shadowform.name .. " missing",
		reminderID, L.reminder, -remStep, 0,
		{ unit = "player", spells = { S.shadowform.id }, showOn = "showOnMissing", known = S.shadowform.id, timer = false }))
	rem.controlledChildren[#rem.controlledChildren + 1] = add(auraIcon(reminderID .. " | " .. S.innerFire.name .. " missing",
		reminderID, L.reminder, 0, 0,
		{ unit = "player", spells = { S.innerFire.id }, showOn = "showOnMissing", known = S.innerFire.id, timer = false }))
	-- Either Fortitude counts (yours or another priest's, single or Prayer).
	rem.controlledChildren[#rem.controlledChildren + 1] = add(auraIcon(reminderID .. " | Fortitude missing",
		reminderID, L.reminder, remStep, 0,
		{ unit = "player", spells = { S.fort.id, S.prayerFort.id }, showOn = "showOnMissing", known = S.fort.id, timer = false }))

	-- The root holds the three parts; it is placed below the character.
	local root = group(P, nil, 0, L.rootY, { rotationID, cooldownID, reminderID })
	root.desc = "Short Royalty shadow priest pack " .. M.VERSION .. ". Rotation (Shadow Word: Pain, Devouring Plague, "
		.. "Mind Blast, Shadow Word: Death, Vampiric Embrace, Shadow Weaving), cooldowns and missing-buff reminders. "
		.. "Priests only; spells you don't know yet stay hidden."
	root.groupIcon = "Interface\\Icons\\Spell_Shadow_Shadowform"

	-- Children are listed group first, then that group's displays (the order
	-- ForeverAuras itself exports in).
	local ordered, byId = {}, {}
	for _, d in ipairs(children) do byId[d.id] = d end
	for _, gid in ipairs(root.controlledChildren) do
		local g = byId[gid]
		ordered[#ordered + 1] = g
		for _, cid in ipairs(g.controlledChildren) do ordered[#ordered + 1] = byId[cid] end
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
			if d.regionType == "icon" then
				local x, y, p = d.xOffset, d.yOffset, byId[d.parent]
				local dynamic = p.regionType == "dynamicgroup"
				while p do x, y, p = x + p.xOffset, y + p.yOffset, byId[p.parent] end
				rows[#rows + 1] = ('{"name":"%s","x":%g,"y":%g,"size":%g,"row":"%s","dynamic":%s}'):format(
					d.id:match("| ([^|]+)$"), x, y, d.width, d.parent:match("| ([^|]+)$"), tostring(dynamic))
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
