-- Runs ForeverAuras' OWN validation (Display.Validate, the check behind the
-- editor's red "this won't work" messages) on every Aura (Modern) display in
-- a pack. It needs a ForeverAuras source folder, which is not in this repo:
--
--   git clone --depth 1 https://github.com/neroxrw/foreverauras.git /tmp/fa
--   lua5.1 tests/fa-check.lua /tmp/fa/ForeverAuras packs/ShadowPriest.txt
--
-- The game itself is faked (frames do nothing), so this proves the settings
-- are ones ForeverAuras accepts, not that the icons look right in game.
local source, packFile = arg[1], arg[2] or "packs/ShadowPriest.txt"
assert(source, "Usage: lua5.1 tests/fa-check.lua FOREVERAURAS_DIR [PACK.txt]")

local B = dofile("tools/build.lua")
local f = assert(io.open(packFile, "rb"))
local pack = assert(B.Decode(f:read("*a")))
f:close()

-- A fake game, just enough for the files below to load.
local noop = function() end
local function fake()
	return setmetatable({}, { __index = function(_, key)
		if key == "CreateTexture" or key == "CreateFontString" or key == "CreateAnimationGroup" then return fake end
		return noop
	end })
end
CreateFrame, hooksecurefunc = fake, noop
UIParent = fake()
C_Timer = { After = noop, NewTicker = noop, NewTimer = noop }
C_NamePlate = { GetNamePlateForUnit = noop }
C_Secrets = { ShouldAurasBeSecret = function() return true end }
C_CurveUtil = { CreateColorCurve = fake, CreateCurve = fake }
Enum = setmetatable({}, { __index = function(t, k) local v = {} rawset(t, k, v) return v end })
CreateColor = fake
GetLocale = function() return "enUS" end
GetScreenWidth, GetScreenHeight = function() return 1920 end, function() return 1080 end
GetTime = function() return 0 end
InCombatLockdown = function() return false end
issecretvalue = function() return false end
CopyTable = function(t) local c = {} for k, v in pairs(t) do c[k] = type(v) == "table" and CopyTable(v) or v end return c end
wipe = function(t) for k in pairs(t) do t[k] = nil end return t end
strsplit = noop
local L = setmetatable({}, { __index = function(_, key) return key end })
local media = { Fetch = function() return "Fonts\\FRIZQT__.TTF" end }
local realLibStub = LibStub
LibStub = setmetatable({}, { __call = function(_, name, optional)
	local lib = realLibStub and realLibStub(name, true)
	if lib then return lib end
	if optional then return nil end
	return media
end })
WeakAuras = {
	newFeatureString = "", IsLibsOK = function() return true end, L = L,
	IsOptionsOpen = function() return false end, RegisterRegionType = noop, RegisterSubRegionType = noop,
}
ForeverAuras = WeakAuras
local P = {
	frames = {}, regions = {}, callbacks = fake(), ExecEnv = {}, memoryRootAccessors = {},
	subRegionTypes = { subtext = { default = function() return {} end } },
	TimedAPI = function() return CreateFrame, noop, noop, C_Timer end,
	Profiled = function(_, fn) return fn end,
}
local function loadFA(name)
	local path = source .. "/" .. name .. ".lua"
	local fh = io.open(path)
	if not fh then return false end
	fh:close()
	assert(loadfile(path))("ForeverAuras", P)
	return true
end
for _, name in ipairs({ "BlizzardAuraDisplay", "SecretAuraAppearance", "SecretAuraSingle",
	"SecretAuraConditions", "SecretAuraFlow", "SecretAuraGrid" }) do
	loadFA(name)
end
local D = assert(P.BlizzardAuraDisplay, "BlizzardAuraDisplay did not load")

local saved = { [pack.d.id] = pack.d }
for _, d in ipairs(pack.c) do saved[d.id] = d end
WeakAuras.GetData = function(id) return saved[id] end

local checked, failed = 0, 0
for _, d in ipairs(pack.c) do
	local t = d.triggers and d.triggers[1] and d.triggers[1].trigger
	if t and t.type == "secretAura" then
		local data = CopyTable(d)
		D.Migrate(data) -- what ForeverAuras does on import
		local problem = D.Validate(data)
		checked = checked + 1
		if problem then
			failed = failed + 1
			print("PROBLEM  " .. d.id .. ": " .. tostring(problem))
		else
			print("ok       " .. d.id)
		end
	end
end
print(("%d Aura (Modern) displays checked with ForeverAuras' own rules, %d problems"):format(checked, failed))
os.exit(failed == 0 and checked > 0 and 0 or 1)
