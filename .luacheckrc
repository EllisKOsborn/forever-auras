-- luacheck configuration (the game and these tools run Lua 5.1).
std = "lua51"
max_line_length = 140
exclude_files = { "vendor/**", ".luarocks/**" }
files["tests/fa-check.lua"] = {
	-- It fakes the game's globals on purpose.
	allow_defined_top = true,
	ignore = { "131" }, -- fakes are read by ForeverAuras, not by this file
	globals = { "CreateFrame", "hooksecurefunc", "UIParent", "C_Timer", "C_NamePlate", "C_Secrets", "C_CurveUtil",
		"Enum", "CreateColor", "GetLocale", "GetScreenWidth", "GetScreenHeight", "GetTime", "InCombatLockdown",
		"issecretvalue", "CopyTable", "wipe", "strsplit", "LibStub", "WeakAuras", "ForeverAuras" },
}
files["tools/build.lua"] = { read_globals = { "LibStub" } }
files["tests/**/*_spec.lua"] = { std = "+busted" }
