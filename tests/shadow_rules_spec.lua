-- The shared ForeverAuras rules (tests/rules.lua), run on the shadow pack.
-- tests/pack_spec.lua has the shadow-specific checks.
local B = dofile("tools/build.lua")
local f = assert(io.open(B.FILE, "rb"))
local text = f:read("*a")
f:close()
local verified = {}
for _, s in pairs(B.SPELLS) do verified[s.id] = true end
for _, r in ipairs(B.RACIALS) do verified[r.id] = true end
local rules = dofile("tests/rules.lua")
setfenv(rules, getfenv(1)) -- busted's describe/it/assert live in this file's environment
rules({ name = "Shadow priest pack", pack = assert(B.Decode(text)), text = text, prefix = B.PREFIX,
	verified = verified, specLoad = { PRIEST_HOLY = false, PRIEST_DISCIPLINE = false } })
