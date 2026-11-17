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

	it("carries only its own name and author", function()
		for _, d in ipairs(displays(pack)) do
			assert.equal(B.PREFIX, d.id:sub(1, #B.PREFIX))
			assert.equal("Forever Auras", d.author)
		end
		assert.equal("Forever Auras | Shadow Priest", B.PREFIX)
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
		for _, r in ipairs(B.RACIALS) do verified[r.id] = true end
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

		it("there are 17 of them (4 on the target, 7 reminders, 4 procs, 2 shield)", function()
			assert.equal(17, #modern)
		end)

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

		it("name at least one aura as positive whole spell IDs, or filter by duration and caster", function()
			for _, d in ipairs(modern) do
				local t = trig(d)
				if t.secretUseRankSpellIDs then
					assert.is_true(#t.auraRankSpellIDs > 0, d.id)
					for _, id in ipairs(t.auraRankSpellIDs) do
						assert.equal("number", type(id))
						assert.is_true(id > 0 and id == math.floor(id))
					end
				else
					-- Only Weakened Soul: no names (debuffs on you can't be matched by
					-- spell ID in combat), so your own 15 s debuffs.
					assert.truthy(d.id:match("Weakened Soul$"), d.id)
					assert.is_true(t.secretUseTotal)
					assert.equal("=", t.secretTotalOperator)
					assert.equal("15", t.secretTotal)
					assert.is_true(t.nativeFilters.PLAYER)
					assert.equal("showOnActive", t.secretShowOn) -- Total Duration = needs Aura(s) Found
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

		-- The sub-element a "sub.N.field" property points at, and the field.
		local function element(d, property)
			local index, field = property:match("^sub%.(%d+)%.(.+)$")
			return index and d.subRegions[tonumber(index)], field
		end

		it("use only conditions ForeverAuras can draw in combat", function()
			local kinds = {}
			for _, d in ipairs(modern) do
				for _, c in ipairs(d.conditions) do
					local v = c.check.variable
					kinds[v] = true
					assert.is_nil(c.linked) -- no Else If with Aura (Modern) checks
					assert.equal(1, c.check.trigger)
					if v == "faAuraActive" then
						-- Missing look: the icon's own look, or its border colour.
						assert.equal(0, c.check.value) -- 0 = while missing
						for _, ch in ipairs(c.changes) do
							local e, field = element(d, ch.property)
							assert.truthy(missingLook[ch.property] or (e and e.type == "subborder" and field == "border_color"),
								d.id .. " " .. ch.property)
						end
					elseif v == "faAuraRemaining" then
						-- Remaining Time glow: must be "<" and turn a Glow element on.
						assert.equal("<", c.check.op)
						assert.is_true(tonumber(c.check.value) > 0)
						for _, ch in ipairs(c.changes) do
							local e, field = element(d, ch.property)
							assert.equal("subglow", e.type)
							assert.equal("glow", field)
							assert.is_true(ch.value)
						end
					elseif v == "faAuraApplications" then
						-- Stack count: may only change the stack text.
						for _, ch in ipairs(c.changes) do
							local e, field = element(d, ch.property)
							assert.equal("subtext", e.type)
							assert.equal("%s", e.text_text)
							assert.equal("text_color", field)
						end
					else
						error("unexpected condition " .. tostring(v) .. " on " .. d.id)
					end
				end
			end
			assert.truthy(kinds.faAuraActive and kinds.faAuraRemaining and kinds.faAuraApplications)
		end)

		it("glow on the DoTs when fewer than 3 seconds are left, and turn red when missing", function()
			for _, name in ipairs({ "Shadow Word: Pain", "Devouring Plague", "Vampiric Embrace" }) do
				local d
				for _, x in ipairs(modern) do if x.id == B.PREFIX .. " | Rotation | " .. name then d = x end end
				local found = {}
				for _, c in ipairs(d.conditions) do
					found[c.check.variable] = c
				end
				assert.equal(tostring(B.LAYOUT.expire), found.faAuraRemaining.check.value)
				local red
				for _, ch in ipairs(found.faAuraActive.changes) do
					if ch.property:match("border_color$") then red = ch.value end
				end
				assert.same(B.COLOURS.missing, red)
			end
		end)

		it("turn the Shadow Weaving number gold at 5 stacks", function()
			for _, d in ipairs(modern) do
				if d.id:match("Shadow Weaving$") then
					assert.equal("faAuraApplications", d.conditions[2].check.variable)
					assert.equal("5", d.conditions[2].check.value)
					assert.equal(">=", d.conditions[2].check.op)
				end
			end
		end)

		it("are not inside a dynamic group (ForeverAuras warns about that)", function()
			local byId = {}
			for _, d in ipairs(displays(pack)) do byId[d.id] = d end
			for _, d in ipairs(modern) do assert.equal("group", byId[d.parent].regionType, d.id) end
		end)

		it("look only at my own debuffs on the target, Shadow Weaving included", function()
			for _, d in ipairs(modern) do
				local t = trig(d)
				if t.unit == "target" then assert.is_true(t.nativeFilters.PLAYER == true, d.id) end
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
			assert.equal(2 + 5 + #B.RACIALS, n) -- rotation, cooldown row, race spells
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

		it("Mind Blast and Shadow Word: Death show only with a target, like the DoTs", function()
			local n = 0
			for _, d in ipairs(pack.c) do
				if d.parent == B.PREFIX .. " | Rotation" and trig(d).type == "spell" then
					n = n + 1
					assert.equal("all", d.triggers.disjunctive)
					assert.equal(1, d.triggers.activeTriggerMode) -- the cooldown still drives the icon
					local t2 = d.triggers[2].trigger
					assert.equal("Unit Characteristics", t2.event)
					assert.equal("target", t2.unit)
					assert.is_nil(d.triggers[3])
				end
			end
			assert.equal(2, n)
			-- the cooldown row needs no target
			for _, d in ipairs(pack.c) do
				if d.parent == B.PREFIX .. " | Cooldowns" then assert.is_nil(d.triggers[2], d.id) end
			end
		end)

		it("glow purple when ready, but only in combat", function()
			local n = 0
			for _, d in ipairs(pack.c) do
				local t = trig(d)
				if t and t.type == "spell" and t.genericShowOn == "showAlways" then
					n = n + 1
					local c = d.conditions[2]
					assert.equal("AND", c.check.variable)
					assert.same({ trigger = 1, variable = "onCooldown", value = 0 }, c.check.checks[1])
					assert.same({ trigger = -1, variable = "incombat", value = 1 }, c.check.checks[2])
					local index = tonumber(c.changes[1].property:match("^sub%.(%d+)%.glow$"))
					assert.equal("subglow", d.subRegions[index].type)
					assert.is_false(d.subRegions[index].glow) -- off unless the condition holds
					assert.same(B.COLOURS.ready, d.subRegions[index].glowColor)
				end
			end
			assert.equal(2, n) -- Mind Blast, Shadow Word: Death
		end)

		it("include your race's priest spells, each only when known", function()
			local byName = {}
			for _, d in ipairs(pack.c) do byName[d.id] = d end
			assert.equal(10, #B.RACIALS) -- 9 priest race spells + Elune's Light
			for _, r in ipairs(B.RACIALS) do
				local d = byName[B.PREFIX .. " | Cooldowns | " .. r.name]
				assert.truthy(d, r.name)
				assert.equal(r.id, d.load.spellknown)
				assert.equal("showOnCooldown", trig(d).genericShowOn)
			end
			assert.truthy(byName[B.PREFIX .. " | Cooldowns | Vampiric Embrace"])
		end)
	end)

	it("gives every icon a thin border (black, orange on reminders)", function()
		for _, d in ipairs(pack.c) do
			if d.regionType == "icon" then
				local b
				for _, e in ipairs(d.subRegions) do if e.type == "subborder" then b = e end end
				assert.truthy(b, d.id)
				assert.equal(1, b.border_size)
				if d.parent == B.PREFIX .. " | Reminders" then
					assert.same(B.COLOURS.reminder, b.border_color)
				elseif d.id:match("Weakened Soul$") then
					assert.same(B.COLOURS.missing, b.border_color)
				else
					assert.same(B.COLOURS.border, b.border_color)
				end
			end
		end
	end)

	describe("procs", function()
		local byName
		setup(function()
			byName = {}
			for _, d in ipairs(pack.c) do byName[d.id] = d end
		end)

		it("show Spirit Tap and Inner Focus only while up, glowing gold", function()
			for _, name in ipairs({ "Spirit Tap", "Inner Focus" }) do
				local d = byName[B.PREFIX .. " | Procs | " .. name]
				local t = trig(d)
				assert.equal("player", t.unit)
				assert.equal("HELPFUL", t.debuffType)
				assert.equal("showOnActive", t.secretShowOn)
				local g
				for _, e in ipairs(d.subRegions) do if e.type == "subglow" then g = e end end
				assert.is_true(g.glow)
			end
			assert.same({ 15271 }, trig(byName[B.PREFIX .. " | Procs | Spirit Tap"]).auraRankSpellIDs)
			assert.equal(15270, byName[B.PREFIX .. " | Procs | Spirit Tap"].load.spellknown) -- the talent
		end)

		it("sit left of the rotation row without touching it", function()
			local procs, rot = byName[B.PREFIX .. " | Procs"], byName[B.PREFIX .. " | Rotation"]
			local first = byName[rot.controlledChildren[1]]
			local tap = byName[procs.controlledChildren[1]]
			assert.is_true(procs.xOffset + tap.width / 2 < first.xOffset - first.width / 2)
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
			if d.regionType == "icon" then
			order[#order + 1] = id:match("| ([^|]+)$")
			if lastX then assert.is_true(d.xOffset - lastX >= d.width) end
			lastX = d.xOffset
			end
		end
		assert.same({ "Shadow Word: Pain", "Devouring Plague", "Mind Blast", "Shadow Word: Death",
			"Vampiric Embrace", "Shadow Weaving" }, order)
	end)

	describe("cast bar", function()
		local bar, byId
		setup(function()
			byId = {}
			for _, d in ipairs(pack.c) do byId[d.id] = d end
			bar = byId[B.PREFIX .. " | Cast bar"]
		end)

		it("is a bar with ForeverAuras' Cast trigger on you", function()
			assert.truthy(bar)
			assert.equal("aurabar", bar.regionType)
			local t = trig(bar)
			assert.equal("unit", t.type)
			assert.equal("Cast", t.event)
			assert.equal("player", t.unit)
			assert.is_true(t.use_unit)
			assert.equal(B.PREFIX, bar.parent)
		end)

		it("shows the spell name and the time left", function()
			local texts = {}
			for _, s in ipairs(bar.subRegions) do if s.type == "subtext" then texts[s.text_text] = s.anchor_point end end
			assert.equal("INNER_LEFT", texts["%n"])
			assert.equal("INNER_RIGHT", texts["%p"])
		end)

		it("loads for every priest, with no spell needed", function()
			assert.is_nil(bar.load.use_spellknown)
		end)

		it("is wider than the rotation row, centred, and clear of everything above and below", function()
			local rot = byId[B.PREFIX .. " | Rotation"]
			local first, last = byId[rot.controlledChildren[1]], byId[rot.controlledChildren[#rot.controlledChildren]]
			local left, right = first.xOffset - first.width / 2, last.xOffset + last.width / 2
			assert.is_true(bar.width > right - left)
			assert.equal(B.LAYOUT.barWidth, bar.width)
			assert.equal(0, bar.xOffset)
			local barTop, barLeft, barRight = bar.yOffset + bar.height / 2, -bar.width / 2, bar.width / 2
			-- Nothing in the rotation row, the procs block or the shield block overlaps it.
			for _, groupName in ipairs({ "Rotation", "Procs", "Shield" }) do
				local g = byId[B.PREFIX .. " | " .. groupName]
				for _, id in ipairs(g.controlledChildren) do
					local d = byId[id]
					local x, y = g.xOffset + d.xOffset, g.yOffset + d.yOffset
					local overlapX = x + d.width / 2 > barLeft and x - d.width / 2 < barRight
					assert.is_true(not overlapX or y - d.height / 2 > barTop, id .. " overlaps the cast bar")
				end
			end
			local mana = byId[B.PREFIX .. " | Mana bar"]
			assert.equal(bar.width, mana.width)
			assert.is_true(bar.yOffset - bar.height / 2 > mana.yOffset + mana.height / 2, "overlaps the mana bar")
			local cds = byId[B.PREFIX .. " | Cooldowns"]
			local cdTop = cds.yOffset + byId[cds.controlledChildren[1]].height / 2
			assert.is_true(mana.yOffset - mana.height / 2 > cdTop, "mana bar overlaps the cooldown row")
		end)

		it("has two tick lines at a third and two thirds, only while channelling", function()
			for i = 1, 2 do
				local tick = byId[B.PREFIX .. " | Cast bar tick " .. i]
				assert.equal("texture", tick.regionType)
				local t = trig(tick)
				assert.equal("Cast", t.event)
				assert.is_true(t.use_castType)
				assert.equal("channel", t.castType)
				assert.is_nil(t.use_spellNames) -- the name can be secret in combat
				local left = bar.xOffset - bar.width / 2
				assert.is_true(math.abs(tick.xOffset - (left + bar.width * i / 3)) < 0.001)
				assert.equal(bar.yOffset, tick.yOffset)
				assert.equal(bar.height, tick.height)
				assert.is_true(tick.frameStrata > bar.frameStrata) -- drawn over the bar
			end
		end)
	end)

	describe("mana bar", function()
		local mana
		setup(function()
			for _, d in ipairs(pack.c) do if d.id == B.PREFIX .. " | Mana bar" then mana = d end end
		end)

		it("is a bar with ForeverAuras' Power trigger for your mana", function()
			assert.equal("aurabar", mana.regionType)
			local t = trig(mana)
			assert.equal("Power", t.event)
			assert.equal("player", t.unit)
			assert.is_true(t.use_powertype)
			assert.equal(0, t.powertype) -- mana
			assert.is_nil(mana.load.use_spellknown)
		end)

		it("shows your mana shortened (4.3K) on the left", function()
			local amount
			for _, e in ipairs(mana.subRegions) do if e.type == "subtext" and e.text_text == "%p" then amount = e end end
			assert.equal("INNER_LEFT", amount.anchor_point)
			assert.equal("BigNumber", amount.text_text_format_p_format)
			assert.equal("AbbreviateNumbers", amount.text_text_format_p_big_number_format)
		end)

		it("shows the percentage as a whole number on the right (a format that copes with hidden values)", function()
			local pct
			for _, e in ipairs(mana.subRegions) do
				if e.type == "subtext" and e.text_text == "%percentpower%%" then pct = e end
			end
			assert.equal("INNER_RIGHT", pct.anchor_point)
			assert.equal("Number", pct.text_text_format_percentpower_format)
			assert.equal(0, pct.text_text_format_percentpower_decimal_precision)
			assert.equal("floor", pct.text_text_format_percentpower_round_type)
		end)
	end)

	describe("v1.4.0", function()
		local byName
		setup(function()
			byName = {}
			for _, d in ipairs(pack.c) do byName[d.id] = d end
		end)
		local function get(name) return assert(byName[B.PREFIX .. " | " .. name], name) end

		it("shows Elune's Light and Elune's Grace while up, for Night Elves only", function()
			for _, spell in ipairs({ B.SPELLS.eluneLight, B.SPELLS.eluneGrace }) do
				local d = get("Procs | " .. spell.name)
				assert.same({ spell.id }, trig(d).auraRankSpellIDs)
				assert.equal(spell.id, d.load.spellknown)
				assert.equal("showOnActive", trig(d).secretShowOn)
			end
			assert.equal(1259799, B.SPELLS.eluneLight.id)
			assert.truthy(get("Cooldowns | Elune's Light"))
			assert.truthy(get("Cooldowns | Elune's Grace"))
		end)

		it("shows Power Word: Shield on you, and Weakened Soul under it", function()
			local shield = get("Shield | Power Word: Shield")
			assert.equal("player", trig(shield).unit)
			assert.equal("HELPFUL", trig(shield).debuffType)
			assert.same({ 17 }, trig(shield).auraRankSpellIDs)
			assert.same({}, trig(shield).nativeFilters) -- anyone's shield counts
			local soul = get("Shield | Weakened Soul")
			assert.equal("HARMFUL", trig(soul).debuffType)
			assert.equal("player", trig(soul).unit)
			assert.is_true(soul.yOffset < shield.yOffset)
		end)

		it("frames Shadow Word: Death in red below 20% target health, only when it's ready", function()
			local swd = get("Rotation | Shadow Word: Death")
			local ex = get("Rotation | Shadow Word: Death execute")
			assert.equal("texture", ex.regionType)
			assert.equal(swd.xOffset, ex.xOffset)
			assert.equal(swd.yOffset, ex.yOffset)
			assert.is_true(ex.width > swd.width)
			assert.equal(0, ex.alpha) -- invisible unless the condition holds
			assert.is_true(ex.frameStrata < 4 and ex.frameStrata > 1) -- below the icon (inherits MEDIUM)
			local t1, t2 = ex.triggers[1].trigger, ex.triggers[2].trigger
			assert.equal("Health", t1.event)
			assert.equal("target", t1.unit)
			assert.equal("showOnReady", t2.genericShowOn)
			assert.equal(B.SPELLS.swd.id, t2.spellName)
			assert.equal("all", ex.triggers.disjunctive)
			-- A health-% condition on trigger 1 changing alpha: ForeverAuras turns
			-- that into a game curve (works with hidden health).
			local c = ex.conditions[1].check
			assert.same({ trigger = 1, variable = "percenthealth", op = "<", value = 20 }, c)
			assert.same({ { property = "alpha", value = 1 } }, ex.conditions[1].changes)
		end)

		it("has a reminder for each buff, the race buffs sharing a spot", function()
			for _, name in ipairs({ "Shadowform", "Inner Fire", "Fortitude", "Divine Spirit", "Touch of Weakness",
				"Shadowguard" }) do
				local d = get("Reminders | " .. name .. " missing")
				assert.equal("showOnMissing", trig(d).secretShowOn)
				assert.is_false(d.load.use_combat) -- clickable: out of combat only
				assert.is_true(d.actions.init.do_custom)
			end
			assert.equal(get("Reminders | Touch of Weakness missing").xOffset, get("Reminders | Shadowguard missing").xOffset)
			assert.same({ 14752, 27681 }, trig(get("Reminders | Divine Spirit missing")).auraRankSpellIDs)
		end)

		it("keeps an unclickable Shadowform warning for combat, on the same spot", function()
			local out, inside = get("Reminders | Shadowform missing"), get("Reminders | Shadowform missing (in combat)")
			assert.is_true(inside.load.use_combat)
			assert.is_nil(inside.actions.init.do_custom)
			assert.equal(out.xOffset, inside.xOffset)
		end)

		it("uses only Custom Init on Aura (Modern) displays (ForeverAuras' rule)", function()
			for _, d in ipairs(pack.c) do
				for when, action in pairs(d.actions) do
					if when ~= "init" then assert.is_nil(action.do_custom, d.id) end
				end
			end
		end)

		-- Names ForeverAuras 1.4.3 blocks in custom code (AuraEnvironment.lua
		-- blockedFunctions / blockedTables): calling one does nothing there.
		local BLOCKED = { "getfenv", "setfenv", "loadstring", "pcall", "xpcall", "securecall", "RunScript",
			"EnumerateFrames", "SlashCmdList", "DEFAULT_CHAT_FRAME", "ChatFrame1", "debug", "ConsoleExec",
			"GetButtonMetatable", "GetFrameMetatable", "ForeverAurasSaved", "WeakAurasSaved" }

		it("custom code uses nothing ForeverAuras blocks", function()
			for _, d in ipairs(pack.c) do
				local code = d.actions.init and d.actions.init.custom
				if code then
					for _, name in ipairs(BLOCKED) do
						assert.is_nil(code:find("%f[%w_]" .. name .. "%f[^%w_]"), d.id .. " uses " .. name)
					end
				end
			end
		end)

		describe("click to rebuff (the Init code, run against a fake game)", function()
			local function run(name, auras, inCombat)
				local d = get("Reminders | " .. name .. " missing")
				local code = d.actions.init.custom
				local made, events = {}, {}
				local region = {}
				local function frame(kind, _, parent, template)
					local f = { kind = kind, parent = parent, template = template, attr = {}, shown = true, events = {} }
					function f.SetAllPoints(self, r) self.points = r end
					function f.RegisterForClicks(self, ...) self.clicks = { ... } end
					function f.SetAttribute(self, k, v) self.attr[k] = v end
					function f.SetShown(self, v) self.shown = v end
					function f.UnregisterAllEvents(self) self.events = {} end
					function f.RegisterEvent(self, e) self.events[e] = true end
					function f.RegisterUnitEvent(self, e, u) self.events[e] = u end
					function f.SetScript(self, _, fn) self.onEvent = fn; events[#events + 1] = fn end
					made[#made + 1] = f
					return f
				end
				local names = { [15473] = "Shadowform", [588] = "Inner Fire", [1243] = "Power Word: Fortitude",
					[21562] = "Prayer of Fortitude", [14752] = "Divine Spirit", [27681] = "Prayer of Spirit",
					[2652] = "Touch of Weakness", [18137] = "Shadowguard" }
				local env = setmetatable({
					aura_env = { region = region },
					CreateFrame = frame,
					InCombatLockdown = function() return inCombat end,
					C_Spell = { GetSpellName = function(id) return names[id] end },
					C_UnitAuras = { GetAuraDataBySpellName = function(unit, n, filter)
						assert.equal("player", unit)
						assert.equal("HELPFUL", filter)
						return auras[n] and { name = n } or nil
					end },
				}, { __index = _G })
				for _, blockedName in ipairs(BLOCKED) do
					rawset(env, blockedName, function() error(blockedName .. " is blocked by ForeverAuras") end)
				end
				local fn = assert(loadstring(code))
				setfenv(fn, env)
				fn()
				return region, made, env
			end

			it("compiles and makes a secure macro button over the reminder", function()
				local region = run("Inner Fire", {})
				local b = region.faRebuff
				assert.equal("SecureActionButtonTemplate", b.template)
				assert.equal(region, b.parent)
				assert.equal(region, b.points)
				assert.equal("macro", b.attr.type)
				assert.equal("/cast Inner Fire", b.attr.macrotext)
				assert.is_true(b.shown)
			end)

			it("casts Fortitude and Divine Spirit on yourself, and never toggles Shadowform off", function()
				assert.equal("/cast [@player] Power Word: Fortitude", run("Fortitude", {}).faRebuff.attr.macrotext)
				assert.equal("/cast [@player] Divine Spirit", run("Divine Spirit", {}).faRebuff.attr.macrotext)
				assert.equal("/cast !Shadowform", run("Shadowform", {}).faRebuff.attr.macrotext)
				assert.equal("/cast Shadowguard", run("Shadowguard", {}).faRebuff.attr.macrotext)
			end)

			it("hides the button while the buff is up (Prayer counts too)", function()
				assert.is_false(run("Inner Fire", { ["Inner Fire"] = true }).faRebuff.shown)
				assert.is_false(run("Fortitude", { ["Prayer of Fortitude"] = true }).faRebuff.shown)
				assert.is_false(run("Divine Spirit", { ["Prayer of Spirit"] = true }).faRebuff.shown)
			end)

			it("re-checks on aura changes and after combat", function()
				local region = run("Inner Fire", {})
				local w = region.faRebuffWatcher
				assert.equal("player", w.events.UNIT_AURA)
				assert.is_true(w.events.PLAYER_REGEN_ENABLED)
				assert.is_true(w.events.PLAYER_ENTERING_WORLD)
				assert.is_function(w.onEvent)
			end)

			it("touches nothing in combat (secure buttons can't change then)", function()
				local region, made = run("Inner Fire", {}, true)
				assert.is_nil(region.faRebuff)
				assert.equal(1, #made) -- only the event watcher
			end)

			it("reuses its button and watcher when the display loads again", function()
				local d = get("Reminders | Inner Fire missing")
				local region = {}
				local count = 0
				local env = setmetatable({
					aura_env = { region = region },
					CreateFrame = function()
						count = count + 1
						local f = { attr = {} }
						for _, m in ipairs({ "SetAllPoints", "RegisterForClicks", "SetShown", "UnregisterAllEvents",
							"RegisterEvent", "RegisterUnitEvent", "SetScript" }) do f[m] = function() end end
						function f.SetAttribute(self, k, v) self.attr[k] = v end
						return f
					end,
					InCombatLockdown = function() return false end,
					C_Spell = { GetSpellName = function() return "Inner Fire" end },
					C_UnitAuras = { GetAuraDataBySpellName = function() return nil end },
				}, { __index = _G })
				for _ = 1, 3 do
					local fn = assert(loadstring(d.actions.init.custom))
					setfenv(fn, env)
					fn()
				end
				assert.equal(2, count) -- one button, one watcher
			end)
		end)
	end)

	it("gives the same uid to the same name every time (imports offer Update)", function()
		assert.equal(B.Uid("x"), B.Uid("x"))
		assert.are_not.equal(B.Uid(B.UidKey(B.PREFIX)), B.Uid(B.UidKey(B.PREFIX .. " | Rotation")))
		-- independent of the shown name
		assert.equal("ShadowPriest | Rotation", B.UidKey(B.PREFIX .. " | Rotation"))
		assert.equal(B.Uid("ShadowPriest"), pack.d.uid)
	end)
end)
