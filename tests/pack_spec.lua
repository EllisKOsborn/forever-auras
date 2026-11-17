-- Checks packs/ShadowPriest.txt without the game: it decodes, it matches the
-- builder, its structure is sound, and its Aura (Modern) settings follow the
-- rules in ForeverAuras 1.4.3's own Display.Validate (BlizzardAuraDisplay.lua,
-- SecretAuraSingle.lua, SecretAuraConditions.lua), read from its source.
local B = dofile("tools/build.lua")

local function readPack()
	local f = assert(io.open(B.FILE, "rb"))
	local s = f:read("*a")
	f:close()
	return s
end

local function displays(pack)
	local all = { pack.d }
	for _, d in ipairs(pack.c) do all[#all + 1] = d end
	return all
end

local function trig(d) return d.triggers and d.triggers[1] and d.triggers[1].trigger end

describe("Shadow priest pack", function()
	local text, pack
	setup(function()
		text = readPack()
		pack = assert(B.Decode(text))
	end)

	it("is the import format ForeverAuras reads", function()
		assert.truthy(text:match("^!WA:2!"))
		assert.equal("d", pack.m)
		assert.equal(2000, pack.v) -- groups use transmission version 2000
		assert.equal("group", pack.d.regionType)
	end)

	it("matches what the builder makes now (run lua5.1 tools/build.lua)", function()
		assert.equal(B.Encode(B.Build()), (text:gsub("%s+$", "")))
	end)

	it("has the same import string in the README (for the copy button)", function()
		local readme = assert(B.ReadFile(B.README))
		assert.equal(readme, B.ReadmeWith(readme, (text:gsub("%s+$", ""))))
	end)

	it("survives a round trip", function()
		assert.same(B.Build(), assert(B.Decode(B.Encode(B.Build()))))
	end)

	it("has unique names and ids, and every group lists its own displays once", function()
		local ids, uids, listed = {}, {}, {}
		for _, d in ipairs(displays(pack)) do
			assert.is_nil(ids[d.id], "duplicate id " .. d.id)
			assert.is_nil(uids[d.uid], "duplicate uid " .. d.id)
			assert.equal(11, #d.uid)
			ids[d.id], uids[d.uid] = d, true
		end
		for _, d in pairs(ids) do
			for _, child in ipairs(d.controlledChildren or {}) do
				assert.truthy(ids[child], "missing child " .. child)
				assert.equal(d.id, ids[child].parent)
				assert.is_nil(listed[child], "listed twice " .. child)
				listed[child] = true
			end
		end
		for id, d in pairs(ids) do
			if d == pack.d then assert.is_nil(d.parent) else
				assert.truthy(listed[id], "not in its group " .. id)
				assert.truthy(ids[d.parent], "missing parent " .. id)
			end
		end
	end)

	it("lists each group before its displays", function()
		local seen = { [pack.d.id] = true }
		for _, d in ipairs(pack.c) do
			assert.truthy(seen[d.parent], d.id .. " comes before its group")
			seen[d.id] = true
		end
	end)

	it("loads only for priests, every display (groups don't pass it on)", function()
		for _, d in ipairs(displays(pack)) do
			assert.is_true(d.load.use_class, d.id)
			assert.equal("PRIEST", d.load.class.single, d.id)
		end
	end)

	it("uses only the spell IDs verified in Forever's data", function()
		local verified = {}
		for _, s in pairs(B.SPELLS) do verified[s.id] = true end
		local used = 0
		for _, d in ipairs(displays(pack)) do
			if d.load.use_spellknown then
				assert.truthy(verified[d.load.spellknown], d.id .. " load " .. tostring(d.load.spellknown))
				used = used + 1
			end
			local t = trig(d)
			if t and t.type == "spell" then
				assert.truthy(verified[t.spellName], d.id)
				used = used + 1
			end
			for _, id in ipairs(t and t.auraRankSpellIDs or {}) do
				assert.truthy(verified[id], d.id .. " aura " .. tostring(id))
				used = used + 1
			end
		end
		assert.is_true(used > 20)
	end)

	it("keeps the ranks' first IDs, so it works while levelling", function()
		assert.equal(589, B.SPELLS.swp.id)
		assert.equal(2944, B.SPELLS.dp.id)
		assert.equal(8092, B.SPELLS.mb.id)
		assert.equal(1309595, B.SPELLS.swd.id)
	end)

	it("hides each spell display until the spell is known", function()
		for _, d in ipairs(pack.c) do
			if d.regionType == "icon" then
				assert.is_true(d.load.use_spellknown, d.id)
				assert.is_false(d.load.use_exact_spellknown, d.id) -- any rank
			end
		end
	end)

	describe("Aura (Modern) displays follow ForeverAuras' rules", function()
		local units = { player = true, target = true, focus = true, pet = true, mouseover = true, targettarget = true,
			focustarget = true, pettarget = true, group = true, party = true, raid = true, boss = true, arena = true,
			nameplate = true, member = true }
		local filters = { PLAYER = true, RAID = true, CANCELABLE = true, EXTERNAL_DEFENSIVE = true, CROWD_CONTROL = true,
			RAID_IN_COMBAT = true, RAID_PLAYER_DISPELLABLE = true, BIG_DEFENSIVE = true, IMPORTANT = true, DISPELLABLE = true }
		local showOn = { showOnActive = true, showOnMissing = true, showAlways = true }
		local missingLook = { desaturate = true, color = true, zoom = true, alpha = true, displayIcon = true }

		local modern
		setup(function()
			modern = {}
			for _, d in ipairs(pack.c) do
				if trig(d) and trig(d).type == "secretAura" then modern[#modern + 1] = d end
			end
		end)

		it("there are seven of them (4 on the target, 3 reminders)", function() assert.equal(7, #modern) end)

		it("use a supported display type, unit, buff/debuff and filters", function()
			for _, d in ipairs(modern) do
				local t = trig(d)
				assert.equal("icon", d.regionType)
				assert.truthy(units[t.unit], d.id)
				assert.truthy(t.debuffType == "HELPFUL" or t.debuffType == "HARMFUL", d.id)
				assert.truthy(showOn[t.secretShowOn], d.id)
				for key, value in pairs(t.nativeFilters) do
					assert.truthy(filters[key], d.id)
					assert.equal("boolean", type(value))
				end
			end
		end)

		it("name at least one aura, as positive whole spell IDs", function()
			for _, d in ipairs(modern) do
				local t = trig(d)
				assert.is_true(t.secretUseRankSpellIDs)
				assert.is_true(#t.auraRankSpellIDs > 0, d.id)
				for _, id in ipairs(t.auraRankSpellIDs) do
					assert.equal("number", type(id))
					assert.is_true(id > 0 and id == math.floor(id))
				end
			end
		end)

		it("are the trigger that draws the display (Dynamic Information)", function()
			for _, d in ipairs(modern) do assert.equal(1, d.triggers.activeTriggerMode, d.id) end
		end)

		it("never look for a missing DEBUFF on the player by spell ID (Blizzard can't match it in combat)", function()
			for _, d in ipairs(modern) do
				local t = trig(d)
				if t.secretShowOn ~= "showOnActive" and t.debuffType == "HARMFUL" then
					assert.truthy(t.unit ~= "player" and t.unit ~= "pet", d.id)
				end
			end
		end)

		it("watch one unit when they show Missing or Always", function()
			local single = { player = true, target = true, focus = true, pet = true, targettarget = true,
				focustarget = true, pettarget = true }
			for _, d in ipairs(modern) do
				if trig(d).secretShowOn ~= "showOnActive" then assert.truthy(single[trig(d).unit], d.id) end
			end
		end)

		it("have no display animations and no actions except sounds", function()
			for _, d in ipairs(modern) do
				for _, a in pairs(d.animation) do assert.equal("none", a.type) end
				for when, action in pairs(d.actions) do
					if when ~= "init" then
						for key, value in pairs(action) do
							if key:match("^do_") and value then assert.truthy(key == "do_sound" or key == "do_message") end
						end
					end
				end
			end
		end)

		it("change only what the Missing look allows", function()
			for _, d in ipairs(modern) do
				for _, c in ipairs(d.conditions) do
					assert.equal("faAuraActive", c.check.variable)
					assert.equal(0, c.check.value) -- 0 = while missing
					assert.is_nil(c.linked)
					for _, change in ipairs(c.changes) do assert.truthy(missingLook[change.property], d.id) end
				end
			end
		end)

		it("are not inside a dynamic group (ForeverAuras warns about that)", function()
			local byId = {}
			for _, d in ipairs(displays(pack)) do byId[d.id] = d end
			for _, d in ipairs(modern) do assert.equal("group", byId[d.parent].regionType, d.id) end
		end)

		it("look only at my own DoTs, but anyone's Shadow Weaving", function()
			for _, d in ipairs(modern) do
				local t = trig(d)
				if t.unit == "target" then
					local mine = t.nativeFilters.PLAYER == true
					assert.equal(not d.id:match("Shadow Weaving$"), mine, d.id)
				end
			end
		end)
	end)

	describe("cooldown displays", function()
		it("use the spell cooldown trigger with a valid Show On", function()
			local n = 0
			for _, d in ipairs(pack.c) do
				local t = trig(d)
				if t and t.type == "spell" then
					n = n + 1
					assert.equal("Cooldown Progress (Spell)", t.event)
					assert.truthy(t.genericShowOn == "showAlways" or t.genericShowOn == "showOnCooldown", d.id)
					assert.is_false(t.use_showgcd) -- the global cooldown would flash every icon
				end
			end
			assert.equal(6, n)
		end)

		it("grey out while cooling down when they are always shown", function()
			for _, d in ipairs(pack.c) do
				local t = trig(d)
				if t and t.type == "spell" and t.genericShowOn == "showAlways" then
					assert.equal("onCooldown", d.conditions[1].check.variable)
					assert.equal("desaturate", d.conditions[1].changes[1].property)
				end
			end
		end)
	end)

	it("lays the rotation row out without overlaps, in the guide's order", function()
		local row
		for _, d in ipairs(pack.c) do if d.id == B.PREFIX .. " | Rotation" then row = d end end
		local order, byId = {}, {}
		for _, d in ipairs(pack.c) do byId[d.id] = d end
		local lastX
		for _, id in ipairs(row.controlledChildren) do
			local d = byId[id]
			order[#order + 1] = id:match("| ([^|]+)$")
			if lastX then assert.is_true(d.xOffset - lastX >= d.width) end
			lastX = d.xOffset
		end
		assert.same({ "Shadow Word: Pain", "Devouring Plague", "Mind Blast", "Shadow Word: Death",
			"Vampiric Embrace", "Shadow Weaving" }, order)
	end)

	it("gives the same uid to the same name every time (imports offer Update)", function()
		assert.equal(B.Uid("x"), B.Uid("x"))
		assert.are_not.equal(B.Uid("Short Royalty | Shadow Priest"), B.Uid("Short Royalty | Shadow Priest | Rotation"))
	end)
end)
