-- The holy priest pack (packs/HolyPriest.txt), built with the shared pieces
-- in tools/build.lua: same look and behaviour as the shadow pack, gold
-- instead of purple. tools/build.lua loads this file and passes itself in:
--   local holy = dofile("tools/holy.lua")(B)
--
-- What a holy priest needs (WarcraftTavern's Forever holy guide, Blizzard's
-- Forever priest class deep dive, Forever's own spell data, build
-- 1.60.1.70938): mana above all, Renew kept up, Power Word: Shield (and
-- Weakened Soul) on the tank, Prayer of Mending on cooldown (the Forever Holy
-- capstone), Inner Focus with big heals. Healing has no fixed rotation, so
-- the middle row is "what's on my friendly target, and what's ready".
-- Not here: Binding Heal and Surge of Light (in the client files, but not
-- learnable in Forever: no SkillLineAbility entry), Lightwell (removed in
-- Forever), Spirit of Redemption (you're dead; the game shows it).
return function(B)
	local H = B.H
	local M = {}

	M.KEY = "HolyPriest"
	M.FILE = B.ROOT .. "packs/HolyPriest.txt"
	M.VERSION = "1.0.0"
	M.PREFIX = "Forever Auras | Holy Priest"
	M.UID_KEY = "HolyPriest"
	-- Loads only for Holy or Discipline (21+ points in the tree); the shadow
	-- pack covers Shadow and levelling, so the two never overlap.
	M.SPEC_LOAD = { PRIEST_HOLY = true, PRIEST_DISCIPLINE = true }

	M.SPELLS = {
		renew = { id = 139, name = "Renew" },                       -- 139 … 25315 (L8–60), 15 s
		pom = { id = 401859, name = "Prayer of Mending" },          -- Holy capstone talent: 401859 / 1240826 / 1240827 (L40/50/60), 10 s cooldown
		-- Its aura on the target (30 s per jump): one ID per rank.
		pomAuras = { 401877, 1240848, 1240849 },
		shield = { id = 17, name = "Power Word: Shield" },          -- 30 s, 4 s cooldown
		weakenedSoul = { id = 6788, name = "Weakened Soul" },       -- 15 s
		focus = { id = 14751, name = "Inner Focus" },               -- talent, 3 min; buff until your next spell
		powerInfusion = { id = 10060, name = "Power Infusion" },    -- Discipline talent, 3 min; 15 s buff (anyone's counts)
		fearWard = { id = 6346, name = "Fear Ward" },               -- every race in Forever (L20), 3 min
		fade = { id = 586, name = "Fade" },
		scream = { id = 8122, name = "Psychic Scream" },
		eluneLight = { id = 1259799, name = "Elune's Light" },      -- Night Elf racial
		eluneGrace = { id = 2651, name = "Elune's Grace" },         -- Night Elf priest spell
		eureka = { id = 1259823, name = "Eureka!" },                -- Gnome priest racial (8 s, 2 min)
		innerFire = { id = 588, name = "Inner Fire" },
		fort = { id = 1243, name = "Power Word: Fortitude" },
		prayerFort = { id = 21562, name = "Prayer of Fortitude" },
		divineSpirit = { id = 14752, name = "Divine Spirit" },
		prayerSpirit = { id = 27681, name = "Prayer of Spirit" },
		touchWeakness = { id = 2652, name = "Touch of Weakness" },
		shadowguard = { id = 18137, name = "Shadowguard" },
	}
	M.RACIALS = B.RACIALS -- the same race spells as the shadow pack

	M.LAYOUT = {
		rootY = -200,
		big = 44, step = 48,       -- healing row
		small = 34,                -- cooldown row
		reminder = 36,
		procSmall = 36,
		barWidth = 420,
		cast = 22,
		mana = 18,                 -- a little taller than shadow's: mana is a healer's main resource
		castFont = 13, manaFont = 12,
		gap = 6,
		expire = 3,                -- seconds left when Renew / a shield starts to glow
	}

	-- Holy: gold and warm white instead of shadow's purple.
	M.COLOURS = {
		border = { 0.30, 0.23, 0.06, 1 },     -- thin dark-gold border
		missing = { 0.85, 0.2, 0.15, 1 },     -- red border (Weakened Soul)
		reminder = { 0.95, 0.55, 0.15, 1 },   -- missing buff: orange border
		expiring = { 1, 0.95, 0.6, 1 },       -- running out: pale gold glow
		ready = { 1, 0.84, 0.3, 1 },          -- Prayer of Mending / Inner Focus ready: gold glow
		proc = { 1, 0.97, 0.8, 1 },           -- buff up: warm white glow
		cast = { 1, 0.78, 0.25, 1 },          -- gold cast bar
		barBg = { 0.09, 0.07, 0.02, 0.85 },
		mana = { 0.25, 0.52, 1, 1 },
		tick = { 1, 1, 1, 0.75 },
	}

	local function build()
		local S, L, P, K = M.SPELLS, M.LAYOUT, M.PREFIX, M.COLOURS
		local healID, cooldownID, reminderID = P .. " | Healing", P .. " | Cooldowns", P .. " | Reminders"
		local procID, shieldID, castID, manaID = P .. " | Procs", P .. " | Shield", P .. " | Cast bar", P .. " | Mana bar"
		local children = {}
		local function add(d) children[#children + 1] = d return d.id end
		local rowWidth = 5 * L.step - (L.step - L.big)
		local cell = L.procSmall + L.gap

		-- Healing row. On your friendly target: your Renew (grey when you could
		-- cast it, gold glow in its last 3 s), Power Word: Shield (anyone's)
		-- and Weakened Soul (anyone's: you can't shield them until it ends).
		-- Debuffs on a target can be matched by spell ID (only debuffs on
		-- yourself can't). Then Prayer of Mending and Inner Focus, which don't
		-- need a target: grey while cooling down, gold glow when ready in a fight.
		local heal = H.group(healID, P, 0, 0, {})
		add(heal)
		local function x(i) return (i - 3) * L.step end
		local row = heal.controlledChildren
		row[#row + 1] = add(H.auraIcon(healID .. " | " .. S.renew.name, healID, L.big, x(1), 0,
			{ unit = "target", mine = true, spells = { S.renew.id }, showOn = "showAlways", known = S.renew.id,
				expire = L.expire, calmMissing = true, friendlyTarget = true }))
		row[#row + 1] = add(H.cooldownIcon(healID .. " | " .. S.pom.name, healID, L.big, x(2), 0, S.pom.id, "showAlways"))
		row[#row + 1] = add(H.auraIcon(healID .. " | " .. S.shield.name, healID, L.big, x(3), 0,
			{ unit = "target", spells = { S.shield.id }, showOn = "showAlways", known = S.shield.id,
				expire = L.expire, calmMissing = true, friendlyTarget = true }))
		row[#row + 1] = add(H.auraIcon(healID .. " | " .. S.weakenedSoul.name, healID, L.big, x(4), 0,
			{ unit = "target", debuff = true, spells = { S.weakenedSoul.id }, showOn = "showOnActive", known = S.shield.id,
				borderColour = K.missing, friendlyTarget = true }))
		row[#row + 1] = add(H.cooldownIcon(healID .. " | " .. S.focus.name, healID, L.big, x(5), 0, S.focus.id, "showAlways"))

		-- Buffs on you, left of the row (2 x 2), only while up, glowing.
		local procs = H.group(procID, P, -(rowWidth / 2 + L.gap + 4 + L.procSmall / 2), 0, {})
		add(procs)
		local function proc(spell, px, py, timer)
			procs.controlledChildren[#procs.controlledChildren + 1] = add(H.auraIcon(procID .. " | " .. spell.name, procID,
				L.procSmall, px, py, { unit = "player", spells = { spell.id }, showOn = "showOnActive", known = spell.known,
					glowAlways = true, timer = timer }))
		end
		proc({ id = S.focus.id, name = S.focus.name, known = S.focus.id }, 0, 0, false) -- until your next spell
		-- Power Infusion from another priest counts, so it isn't tied to knowing it.
		proc({ id = S.powerInfusion.id, name = S.powerInfusion.name }, 0, -cell)
		proc({ id = S.eluneLight.id, name = S.eluneLight.name, known = S.eluneLight.id }, -cell, 0)
		proc({ id = S.eureka.id, name = S.eureka.name, known = S.eureka.id }, -cell, 0) -- Gnome: same spot
		proc({ id = S.eluneGrace.id, name = S.eluneGrace.name, known = S.eluneGrace.id }, -cell, -cell)

		-- Your own shield, right of the row (as in the shadow pack).
		local shield = H.group(shieldID, P, rowWidth / 2 + L.gap + 4 + L.procSmall / 2, 0, {})
		add(shield)
		shield.controlledChildren[#shield.controlledChildren + 1] = add(H.auraIcon(shieldID .. " | " .. S.shield.name,
			shieldID, L.procSmall, 0, 0, { unit = "player", spells = { S.shield.id }, showOn = "showOnActive",
				known = S.shield.id }))
		shield.controlledChildren[#shield.controlledChildren + 1] = add(H.auraIcon(shieldID .. " | " .. S.weakenedSoul.name,
			shieldID, L.procSmall, 0, -cell, { unit = "player", debuff = true, mine = true, showOn = "showOnActive",
				total = 15, known = S.shield.id, borderColour = K.missing }))

		-- Gold cast bar and the mana bar under the blocks (no Mind Flay ticks:
		-- holy has no channelled spells).
		local blockBottom = math.min(-L.big / 2, -(cell + L.procSmall / 2))
		local castY = blockBottom - (L.gap + L.cast / 2)
		add(H.castBar(castID, P, L.barWidth, L.cast, 0, castY))
		local manaY = castY - (L.cast / 2 + 2 + L.mana / 2)
		add(H.manaBar(manaID, P, L.barWidth, L.mana, 0, manaY))

		-- Cooldown row: only while cooling down.
		local cds = H.row(cooldownID, P, 0, manaY - (L.mana / 2 + L.gap + L.small / 2), {})
		add(cds)
		local cdSpells = { S.fade, S.scream, S.fearWard, S.powerInfusion }
		for _, r in ipairs(M.RACIALS) do cdSpells[#cdSpells + 1] = r end
		for _, s in ipairs(cdSpells) do
			cds.controlledChildren[#cds.controlledChildren + 1] =
				add(H.cooldownIcon(cooldownID .. " | " .. s.name, cooldownID, L.small, 0, 0, s.id, "showOnCooldown"))
		end

		-- Missing-buff reminders, clickable out of combat (hidden in combat).
		local rem = H.group(reminderID, P, 0, L.big / 2 + 10 + L.reminder / 2, {})
		add(rem)
		local remStep = L.reminder + 6
		local function slot(i) return (i - 2.5) * remStep end
		local function reminder(name, spells, known, xx, macro)
			rem.controlledChildren[#rem.controlledChildren + 1] = add(H.auraIcon(reminderID .. " | " .. name .. " missing",
				reminderID, L.reminder, xx, 0, { unit = "player", spells = spells, showOn = "showOnMissing", known = known,
					timer = false, borderColour = K.reminder, combat = false, click = { macro = macro, cast = spells[1] } }))
		end
		reminder(S.innerFire.name, { S.innerFire.id }, S.innerFire.id, slot(1), "/cast %s")
		reminder("Fortitude", { S.fort.id, S.prayerFort.id }, S.fort.id, slot(2), "/cast [@player] %s")
		reminder(S.divineSpirit.name, { S.divineSpirit.id, S.prayerSpirit.id }, S.divineSpirit.id, slot(3),
			"/cast [@player] %s")
		reminder(S.touchWeakness.name, { S.touchWeakness.id }, S.touchWeakness.id, slot(4), "/cast %s")
		reminder(S.shadowguard.name, { S.shadowguard.id }, S.shadowguard.id, slot(4), "/cast %s")

		local root = H.group(P, nil, 0, L.rootY, { procID, healID, shieldID, castID, manaID, cooldownID, reminderID })
		root.desc = "Forever Auras holy priest pack " .. M.VERSION .. ". On your friendly target: your Renew, Power "
			.. "Word: Shield and Weakened Soul; Prayer of Mending and Inner Focus ready; your buffs and shield, a gold "
			.. "cast bar, a mana bar, cooldowns (with your race's spells) and missing-buff reminders you can click to "
			.. "rebuff out of combat. Priests only; spells you don't know yet stay hidden."
		root.groupIcon = "Interface\\Icons\\Spell_Holy_Renew"
		return B.Ordered(root, children)
	end

	function M.Build()
		local previous = B.UsePack(M)
		local t = build()
		B.UsePack(previous)
		return t
	end

	return M
end
