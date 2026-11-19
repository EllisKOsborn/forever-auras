-- Checks every pack must pass, whatever its class: the import format, a sound
-- structure, and ForeverAuras 1.4.3's own rules (read from its source:
-- BlizzardAuraDisplay.lua Display.Validate, SecretAuraSingle.lua,
-- SecretAuraConditions.lua, AuraEnvironment.lua). Used by the pack specs:
--   local rules = dofile("tests/rules.lua")
--   setfenv(rules, getfenv(1)) -- busted's describe/it/assert live in the spec's environment
--   rules({ name = ..., pack = <decoded import>, text = <import string>, prefix = ...,
--     verified = { [spellID] = true } })
return function(ctx)
	local pack, prefix = ctx.pack, ctx.prefix

	local function displays()
		local all = { pack.d }
		for _, d in ipairs(pack.c) do all[#all + 1] = d end
		return all
	end
	local function trig(d) return d.triggers and d.triggers[1] and d.triggers[1].trigger end
	local byId = {}
	for _, d in ipairs(displays()) do byId[d.id] = d end

	describe(ctx.name .. ": general rules", function()
		it("is the import format ForeverAuras reads", function()
			assert.truthy(ctx.text:match("^!WA:2!"))
			assert.equal("d", pack.m)
			assert.equal(2000, pack.v)
			assert.equal("group", pack.d.regionType)
		end)

		it("has unique names and 11-character uids, and every group lists its own displays once", function()
			local ids, uids, listed = {}, {}, {}
			for _, d in ipairs(displays()) do
				assert.is_nil(ids[d.id], "duplicate id " .. d.id)
				assert.is_nil(uids[d.uid], "duplicate uid " .. d.id)
				assert.equal(11, #d.uid)
				assert.equal(prefix, d.id:sub(1, #prefix))
				assert.equal("Forever Auras", d.author)
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
				if d == pack.d then assert.is_nil(d.parent) else assert.truthy(listed[id], "not in its group " .. id) end
			end
		end)

		it("lists each group before its displays", function()
			local seen = { [pack.d.id] = true }
			for _, d in ipairs(pack.c) do
				assert.truthy(seen[d.parent], d.id .. " comes before its group")
				seen[d.id] = true
			end
		end)

		it("loads only for priests, on every display", function()
			for _, d in ipairs(displays()) do
				assert.is_true(d.load.use_class, d.id)
				assert.equal("PRIEST", d.load.class.single, d.id)
			end
		end)

		it("loads by talent tree, the same way on every display", function()
			for _, d in ipairs(displays()) do
				assert.is_false(d.load.use_forever_spec, d.id) -- false = the multi-selection
				assert.same(ctx.specLoad, d.load.forever_spec.multi, d.id)
			end
		end)

		it("uses only spell IDs verified in Forever's data", function()
			local used = 0
			for _, d in ipairs(displays()) do
				if d.load.use_spellknown then
					assert.truthy(ctx.verified[d.load.spellknown], d.id .. " load " .. tostring(d.load.spellknown))
					assert.is_false(d.load.use_exact_spellknown, d.id) -- any rank
					used = used + 1
				end
				for _, entry in ipairs(d.triggers or {}) do
					local t = entry.trigger
					if t.type == "spell" then
						assert.truthy(ctx.verified[t.spellName], d.id)
						used = used + 1
					end
					for _, id in ipairs(t.auraRankSpellIDs or {}) do
						assert.truthy(ctx.verified[id], d.id .. " aura " .. tostring(id))
						used = used + 1
					end
				end
			end
			assert.is_true(used > 20)
		end)

		it("gives every icon a thin border", function()
			for _, d in ipairs(pack.c) do
				if d.regionType == "icon" then
					local b
					for _, e in ipairs(d.subRegions) do if e.type == "subborder" then b = e end end
					assert.truthy(b, d.id)
					assert.equal(1, b.border_size)
				end
			end
		end)

		it("cooldown triggers are valid and ignore the global cooldown", function()
			for _, d in ipairs(pack.c) do
				for _, entry in ipairs(d.triggers or {}) do
					local t = entry.trigger
					if t.type == "spell" then
						assert.equal("Cooldown Progress (Spell)", t.event)
						assert.truthy(({ showAlways = true, showOnCooldown = true, showOnReady = true })[t.genericShowOn], d.id)
						assert.is_false(t.use_showgcd)
					end
				end
			end
		end)

		-- Names ForeverAuras 1.4.3 blocks in custom code (AuraEnvironment.lua).
		local BLOCKED = { "getfenv", "setfenv", "loadstring", "pcall", "xpcall", "securecall", "RunScript",
			"EnumerateFrames", "SlashCmdList", "DEFAULT_CHAT_FRAME", "ChatFrame1", "debug", "ConsoleExec",
			"GetButtonMetatable", "GetFrameMetatable", "ForeverAurasSaved", "WeakAurasSaved" }
		it("custom code compiles and uses nothing ForeverAuras blocks", function()
			for _, d in ipairs(pack.c) do
				local code = d.actions.init and d.actions.init.custom
				if code then
					assert(loadstring(code), d.id)
					for _, name in ipairs(BLOCKED) do
						assert.is_nil(code:find("%f[%w_]" .. name .. "%f[^%w_]"), d.id .. " uses " .. name)
					end
				end
			end
		end)

		describe("Aura (Modern) displays", function()
			local units = { player = true, target = true, focus = true, pet = true, mouseover = true, targettarget = true,
				focustarget = true, pettarget = true, group = true, party = true, raid = true, boss = true, arena = true,
				nameplate = true, member = true }
			local single = { player = true, target = true, focus = true, pet = true, targettarget = true,
				focustarget = true, pettarget = true }
			local filters = { PLAYER = true, RAID = true, CANCELABLE = true, EXTERNAL_DEFENSIVE = true, CROWD_CONTROL = true,
				RAID_IN_COMBAT = true, RAID_PLAYER_DISPELLABLE = true, BIG_DEFENSIVE = true, IMPORTANT = true, DISPELLABLE = true }
			local missingLook = { desaturate = true, color = true, zoom = true, alpha = true, displayIcon = true }
			local modern = {}
			for _, d in ipairs(pack.c) do
				if trig(d) and trig(d).type == "secretAura" then modern[#modern + 1] = d end
			end
			local function element(d, property)
				local index, field = property:match("^sub%.(%d+)%.(.+)$")
				return index and d.subRegions[tonumber(index)], field
			end

			it("use a supported display type, unit, buff/debuff, Show On and filters", function()
				assert.is_true(#modern > 0)
				for _, d in ipairs(modern) do
					local t = trig(d)
					assert.equal("icon", d.regionType)
					assert.truthy(units[t.unit], d.id)
					assert.truthy(t.debuffType == "HELPFUL" or t.debuffType == "HARMFUL", d.id)
					assert.truthy(({ showOnActive = true, showOnMissing = true, showAlways = true })[t.secretShowOn], d.id)
					for key, value in pairs(t.nativeFilters) do
						assert.truthy(filters[key], d.id)
						assert.equal("boolean", type(value))
					end
					assert.equal(1, d.triggers.activeTriggerMode, d.id) -- the aura trigger draws the icon
					if t.secretShowOn ~= "showOnActive" then assert.truthy(single[t.unit], d.id) end
				end
			end)

			it("name auras by spell ID, or (debuffs on you) by your own debuffs of a set duration", function()
				for _, d in ipairs(modern) do
					local t = trig(d)
					if t.secretUseRankSpellIDs then
						assert.is_true(#t.auraRankSpellIDs > 0, d.id)
					else
						assert.equal("player", t.unit)
						assert.equal("HARMFUL", t.debuffType)
						assert.is_true(t.secretUseTotal and t.nativeFilters.PLAYER, d.id)
						assert.equal("showOnActive", t.secretShowOn)
					end
					-- Blizzard can't match debuffs on you by spell ID while auras are secret.
					if t.debuffType == "HARMFUL" and (t.unit == "player" or t.unit == "pet") then
						assert.is_not_true(t.secretUseRankSpellIDs, d.id)
					end
				end
			end)

			it("have only a friendly-target check as a second trigger", function()
				for _, d in ipairs(modern) do
					local t2 = d.triggers[2] and d.triggers[2].trigger
					if t2 then
						assert.equal("Unit Characteristics", t2.event, d.id)
						assert.equal("target", t2.unit)
						assert.equal("friendly", t2.hostility)
						assert.equal("all", d.triggers.disjunctive)
						assert.is_nil(d.triggers[3])
					end
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

			it("use only conditions ForeverAuras can draw in combat", function()
				for _, d in ipairs(modern) do
					for _, c in ipairs(d.conditions) do
						local v = c.check.variable
						assert.is_nil(c.linked)
						assert.equal(1, c.check.trigger)
						if v == "faAuraActive" then
							assert.equal(0, c.check.value)
							for _, ch in ipairs(c.changes) do
								local e, field = element(d, ch.property)
								assert.truthy(missingLook[ch.property] or (e and e.type == "subborder" and field == "border_color"),
									d.id .. " " .. ch.property)
							end
						elseif v == "faAuraRemaining" then
							assert.equal("<", c.check.op)
							assert.is_true(tonumber(c.check.value) > 0)
							for _, ch in ipairs(c.changes) do
								local e, field = element(d, ch.property)
								assert.equal("subglow", e.type)
								assert.equal("glow", field)
								assert.is_true(ch.value)
							end
						elseif v == "faAuraApplications" then
							for _, ch in ipairs(c.changes) do
								local e, field = element(d, ch.property)
								assert.equal("%s", e.text_text)
								assert.equal("text_color", field)
							end
						else
							error("unexpected condition " .. tostring(v) .. " on " .. d.id)
						end
					end
				end
			end)

			it("are not inside a dynamic group (ForeverAuras warns about that)", function()
				for _, d in ipairs(modern) do assert.equal("group", byId[d.parent].regionType, d.id) end
			end)
		end)
	end)
end
