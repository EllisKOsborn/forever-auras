-- The holy priest pack (packs/HolyPriest.txt, defined in tools/holy.lua).
local B = dofile("tools/build.lua")
local Holy = dofile("tools/holy.lua")(B)

local f = assert(io.open(Holy.FILE, "rb"))
local text = f:read("*a")
f:close()
local pack = assert(B.Decode(text))

local verified = {}
for _, s in pairs(Holy.SPELLS) do if type(s) == "table" and s.id then verified[s.id] = true end end
for _, r in ipairs(Holy.RACIALS) do verified[r.id] = true end

-- The shared rules use busted's describe/it/assert from this file's environment.
local rules = dofile("tests/rules.lua")
setfenv(rules, getfenv(1))
rules({ name = "Holy priest pack", pack = pack, text = text, prefix = Holy.PREFIX, verified = verified,
	specLoad = { PRIEST_HOLY = true, PRIEST_DISCIPLINE = true } })

local function trig(d, i) return d.triggers[i or 1].trigger end
local byName = {}
for _, d in ipairs(pack.c) do byName[d.id] = d end
local function get(name) return (assert(byName[Holy.PREFIX .. " | " .. name], name)) end

describe("Holy priest pack", function()
	it("matches what the builder makes now (run lua5.1 tools/build.lua)", function()
		assert.equal(B.Encode(Holy.Build()), (text:gsub("%s+$", "")))
	end)

	it("has its own name, uids and copy box", function()
		assert.equal("Forever Auras | Holy Priest", Holy.PREFIX)
		assert.equal(B.Uid("HolyPriest"), pack.d.uid)
		assert.are_not.equal(B.Uid("ShadowPriest"), pack.d.uid)
		local readme = assert(B.ReadFile(B.README))
		assert.equal(readme, B.ReadmeWith(readme, (text:gsub("%s+$", "")), "HolyPriest"))
	end)

	it("is never on screen together with the shadow pack, whatever your talents", function()
		-- ForeverAuras 1.4.3's rule (PlayerSpecialization.lua ForeverSpecLoad):
		-- a "never" tree blocks; with any "load" tree you need one of them;
		-- with only "never"s, everything else loads (no spec too).
		local function loads(multi, current)
			local positive = false
			for key, value in pairs(multi) do
				if value == true then positive = true end
				if current and key == current and value == false then return false end
			end
			if positive then return current ~= nil and multi[current] == true end
			return true
		end
		local shadow, holy = B.SPEC_LOAD, Holy.SPEC_LOAD
		local cases = { [false] = { true, false }, PRIEST_SHADOW = { true, false }, PRIEST_HOLY = { false, true },
			PRIEST_DISCIPLINE = { false, true } }
		for spec, want in pairs(cases) do
			local current = spec or nil
			assert.equal(want[1], loads(shadow, current), "shadow, spec " .. tostring(spec))
			assert.equal(want[2], loads(holy, current), "holy, spec " .. tostring(spec))
		end
	end)

	it("doesn't change the shadow pack when built", function()
		local before = B.Encode(B.Build())
		Holy.Build()
		assert.equal(before, B.Encode(B.Build()))
	end)

	it("uses the holy colours: a gold cast bar, dark-gold borders", function()
		local bar = get("Cast bar")
		assert.same(Holy.COLOURS.cast, bar.barColor)
		assert.is_true(bar.barColor[1] > 0.9 and bar.barColor[3] < 0.5) -- gold, not shadow's purple
		local renew = get("Healing | Renew")
		for _, e in ipairs(renew.subRegions) do
			if e.type == "subborder" then assert.same(Holy.COLOURS.border, e.border_color) end
		end
	end)

	describe("healing row", function()
		it("is Renew, Prayer of Mending, Power Word: Shield, Weakened Soul, Inner Focus, left to right", function()
			local row = get("Healing")
			local names, lastX = {}, nil
			for _, id in ipairs(row.controlledChildren) do
				local d = byName[id]
				names[#names + 1] = id:match("| ([^|]+)$")
				if lastX then assert.is_true(d.xOffset - lastX >= d.width) end
				lastX = d.xOffset
			end
			assert.same({ "Renew", "Prayer of Mending", "Power Word: Shield", "Weakened Soul", "Inner Focus" }, names)
		end)

		it("shows your Renew on a friendly target, grey (no red) when missing, glowing in its last 3 s", function()
			local d = get("Healing | Renew")
			local t = trig(d)
			assert.equal("target", t.unit)
			assert.is_true(t.nativeFilters.PLAYER)
			assert.same({ 139 }, t.auraRankSpellIDs)
			assert.equal("showAlways", t.secretShowOn)
			assert.equal("friendly", trig(d, 2).hostility)
			local missing, remaining
			for _, c in ipairs(d.conditions) do
				if c.check.variable == "faAuraActive" then missing = c end
				if c.check.variable == "faAuraRemaining" then remaining = c end
			end
			for _, ch in ipairs(missing.changes) do assert.is_nil(ch.property:match("border_color")) end
			assert.equal("3", remaining.check.value)
		end)

		it("shows anyone's shield and Weakened Soul on a friendly target", function()
			local shield, soul = get("Healing | Power Word: Shield"), get("Healing | Weakened Soul")
			assert.same({}, trig(shield).nativeFilters)
			assert.same({ 17 }, trig(shield).auraRankSpellIDs)
			assert.equal("HARMFUL", trig(soul).debuffType)
			assert.equal("target", trig(soul).unit)
			assert.same({ 6788 }, trig(soul).auraRankSpellIDs) -- on a target, a spell ID works
			assert.same({}, trig(soul).nativeFilters)
			assert.equal("showOnActive", trig(soul).secretShowOn)
			for _, d in ipairs({ shield, soul }) do assert.equal("friendly", trig(d, 2).hostility) end
		end)

		it("shows Prayer of Mending and Inner Focus without a target, glowing when ready in a fight", function()
			for _, name in ipairs({ "Prayer of Mending", "Inner Focus" }) do
				local d = get("Healing | " .. name)
				assert.equal("showAlways", trig(d).genericShowOn)
				assert.is_nil(d.triggers[2])
				assert.equal("AND", d.conditions[2].check.variable)
				assert.same({ trigger = -1, variable = "incombat", value = 1 }, d.conditions[2].check.checks[2])
			end
			assert.equal(401859, trig(get("Healing | Prayer of Mending")).spellName)
		end)
	end)

	it("shows Inner Focus, Power Infusion and the race buffs on the left while up", function()
		for _, name in ipairs({ "Inner Focus", "Power Infusion", "Elune's Light", "Eureka!", "Elune's Grace" }) do
			local d = get("Procs | " .. name)
			assert.equal("player", trig(d).unit)
			assert.equal("showOnActive", trig(d).secretShowOn)
		end
		-- Power Infusion from another priest counts: not tied to knowing it.
		assert.is_nil(get("Procs | Power Infusion").load.use_spellknown)
		assert.equal(get("Procs | Elune's Light").xOffset, get("Procs | Eureka!").xOffset)
	end)

	it("has your own shield and Weakened Soul on the right", function()
		local soul = get("Shield | Weakened Soul")
		assert.is_true(trig(soul).secretUseTotal)
		assert.equal("15", trig(soul).secretTotal)
	end)

	it("has the gold cast bar and a taller mana bar, wide and clear of the icons", function()
		local bar, mana = get("Cast bar"), get("Mana bar")
		assert.equal(Holy.LAYOUT.barWidth, bar.width)
		assert.equal(bar.width, mana.width)
		assert.equal(18, mana.height)
		assert.is_true(bar.actions.init.do_custom) -- hides the game's cast bar too
		for _, groupName in ipairs({ "Healing", "Procs", "Shield" }) do
			local g = get(groupName)
			for _, id in ipairs(g.controlledChildren) do
				local d = byName[id]
				local x, y = g.xOffset + d.xOffset, g.yOffset + d.yOffset
				local overlapX = x + d.width / 2 > -bar.width / 2 and x - d.width / 2 < bar.width / 2
				assert.is_true(not overlapX or y - d.height / 2 > bar.yOffset + bar.height / 2, id)
			end
		end
		assert.is_true(bar.yOffset - bar.height / 2 > mana.yOffset + mana.height / 2)
	end)

	it("has no Mind Flay ticks or execute frame (shadow only)", function()
		for _, d in ipairs(pack.c) do
			assert.is_nil(d.id:match("tick"), d.id)
			assert.is_nil(d.id:match("execute"), d.id)
		end
	end)

	it("has the cooldown row with Fear Ward, Power Infusion and your race's spells", function()
		for _, name in ipairs({ "Fade", "Psychic Scream", "Fear Ward", "Power Infusion", "Eureka!", "Desperate Prayer" }) do
			assert.equal("showOnCooldown", trig(get("Cooldowns | " .. name)).genericShowOn)
		end
		assert.equal(4 + #B.RACIALS, #get("Cooldowns").controlledChildren)
	end)

	it("has clickable missing-buff reminders (no Shadowform)", function()
		local want = {
			["Inner Fire"] = "/cast %s", Fortitude = "/cast [@player] %s", ["Divine Spirit"] = "/cast [@player] %s",
			["Touch of Weakness"] = "/cast %s", Shadowguard = "/cast %s",
		}
		local n = 0
		for name, macro in pairs(want) do
			local d = get("Reminders | " .. name .. " missing")
			assert.is_false(d.load.use_combat)
			assert.truthy(d.actions.init.custom:find(("%q"):format(macro), 1, true), name)
			n = n + 1
		end
		assert.equal(n, #get("Reminders").controlledChildren)
	end)
end)
