# Forever Auras

Aura packs for **[ForeverAuras](https://www.curseforge.com/wow/addons/foreverauras)**,
the WoW Forever version of WeakAuras.

> **Status:** v1.0.0 imported and "works fine" in game (first report,
> 17 Nov 2026). **Everything added since (cast bar, procs, mana bar, glows,
> borders, tick marks, race spells) is not tested in game yet.** Please
> report what you see (see [Testing](#testing-in-game)).

## Shadow Priest (v1.3.0)

![Layout](docs/layout.png)

**What it shows**, built on the
[WarcraftTavern Forever shadow priest guide](https://www.warcrafttavern.com/forever/guides/shadow-priest/)'s
priority and [Blizzard's Forever priest class deep dive](https://news.blizzard.com/en-us/article/24301514/world-of-warcraft-forever-class-deep-dives-priest-and-warrior):

| Row | Icons | How it behaves |
|---|---|---|
| **Reminders** (top) | Shadowform, Inner Fire, Power Word: Fortitude | Shown only while the buff is **missing**. Any Fortitude counts (yours or another priest's, single or Prayer). |
| **Procs** (left) | Spirit Tap, Inner Focus | Shown only while up, with a gold glow. Spirit Tap (after a kill) is great while levelling. |
| **Rotation** (middle, big) | Shadow Word: Pain, Devouring Plague, Mind Blast, Shadow Word: Death, Vampiric Embrace, Shadow Weaving | **DoTs** (Pain, Plague, Embrace): timer while **your** debuff is on the target; **gold glow** in its last 3 seconds; **grey with a red border** while missing. **Mind Blast / Shadow Word: Death:** grey with a countdown while cooling down, **purple glow** when ready during a fight. **Shadow Weaving:** your stacks on the target, the number turns **gold at 5**. Hidden while you have no target. |
| **Cast bar** (under the rotation) | Whatever you're casting or channelling | Shown only while casting: spell name on the left, time left on the right. While **channelling**, two lines mark Mind Flay's ticks (3 ticks, each hits harder in Forever: don't cut it short). |
| **Mana bar** | Your mana | Thin bar with the percentage. |
| **Cooldowns** (bottom, small) | Silence, Psychic Scream, Fade, Inner Focus, Vampiric Embrace, plus your race's priest spells | Shown only while cooling down, so the row is empty when everything is ready. Race spells: Human Feedback / Divine Grace, Dwarf Desperate Prayer / Chastise, Night Elf Starshards / Elune's Grace, Gnome Confounding Flash / Contingency Plan, Undead Dark Sacrifice. Only yours show. |

- **Priests only**, and every icon stays hidden until you know the spell (so
  it works while levelling: Shadow Word: Death appears at 32, Shadowform when
  you take the talent). Any rank of a spell counts.
- All icons have a thin black border (orange on reminders).
- It sits just below the middle of your screen. Move it with `/fa`
  (unlock and drag the group named **Forever Auras | Shadow Priest**).
- The game's own cast bar still shows as well. The pack doesn't hide it.

### How to import

1. Install **ForeverAuras** (CurseForge app or curseforge.com), then log in.
2. Out of combat, type `/fa` and press **Import**.
3. Copy the whole text below (the copy button is at the box's top right) and
   paste it into the import window. Press **Import**.
4. Updating later: paste the new version the same way and choose **Update**
   (not "Import as copy"). It replaces your copy, including anything you moved.
   - **Coming from v1.1.0 or older:** delete the old group in `/fa` first.
     v1.2.0 was renamed and imports as a new group (only this once).

<!-- pack:ShadowPriest start (written by tools/build.lua) -->
```text
!WA:2!LZ1E0XX1zDpETRT3gQLKJdjoV24yll5OOyT6HL8JKU7QDTw5vRK3D1dBcOD2zU7oJ1SZmAMzx9GMwIOemLqHQaf6lAzH2COeONQK6ukLZjicH3W3rh(db0YddNCYHt5CabhcqHd8DVZSVKLS211Qjc05ODN7DU37CNVVFF)((MV7DwUXAs4Z9ix7rn4fSK1un7jvAzvztj3(XVSChZ0I3a)IxrxI31A8QcsAgHm4ZssmNojv8aXcgm6s2vpIMSQvQabJMiySf5vLZYthXEGDhAfXCgSctAH9YWKiOPkAUmH3Ke3YGOMXsAFlqlrhu)QAQe)0gch0FwEz1qW7fUl47zFW7doi0a()EwFnP4ZzHtGvcPzqYtm84dVCMRyx5W6S7l3RKIxykrdn9aAkAgdYH)LkLMHiXq6g2F73Pb6n4xrE(55ne9KqttXswFj7guQNUkyxrqXme9gJpDoEdINq5uu8mUKSfXP5HvnjwUw2UWWPtJLoGthJlppzVfOsbz7zxk840YzCR3eEGLHMIcrmGKSIikDoPU3QUX88b8exIxuBgpJyitmTWYJyOjWQxx2q2YtcED9oR1(ewvfBvinHCMlLMQzrvcVfVRJklQF8AAqwswnTMHJ6Ej8qbsW8evltPLYyOLt3(Exs)ELZOIJNJgH1KGggAgMsRHihIHkVYyi6ap5R6xrJxS5yck8MMnhlBoul4oLPSAgfsQrIfoy8elMZKmj78jtPJYFvl9h8woBlyqYGdnfIfJnTIzkWRqCTOjrjnd7chiLjjloaX6O9oB)ufmZLkgRpMUlyPjK3EUT)N8zxWYqotgSy0MnComumc9(PqGs6uOb)5qti4PsPRWphX4g0jmVYm8ZzAzKJKCXCQo91TEJuRV8Ke2LhstK4AjrzZRMtLvVxEffV5KfxksWiD1BKj6SxDDdNPJlJzTLVFl3gZzFe31Ad4q7o3Gl3WECVeV4vZzArehIF2DxUGS6UH96cEpW(G9dhaCtnuxVLwJBTTh0eCi4UDRFOuognuHF)YM0B6Ew2MvjUwo0ExAHS8ZggX3MUwXucvzIonlzmbMLLl8p4HDdECVGaA4HQo1Klx8iQTM0kflfFgzDss97Uy5eKzTWrJpfA3KSGiXK3Is5qKGJ5kLeroJK1L9lJx7KfOFItieK(a7cX4WrHM7boHe0Ie0QeCYx1qwLkAjjxBkcr3NPorWkgfBlbp2yqBndpUBOD4jkGNqrzkv8IV)Z(fGtHtgQcMmlElpz5ZjXu7LlNe6ao(n0n0YyqmnTNhN8b21UHoHjGUDb9GQItd9c9n49anScIaP0wu4QQyAhQKjfkXd5W0mjbfoW9VItjnBuqXtAIKnUC44MmVSPmkKscnSiDWzv(M(ZOOntYc0p9BtjUi9yB(oxJSNt1EVEPF2z3UwMEI(DOZDTcTuidY05iQcZrBI3UzdtegP(HzdtezvIzJSdJZS4y9kHKSWu4jm37cSIuZYrKNLOSeT4eoizwHl7uaAWaNZ0AwgfQxO4mm51U3vS9avSxofl2VLTloPUTrEbdnleAqHm(JoC0G6hYcpCs0DHgLdtyCzrlj)(WIfyNOm4Cnw504SuK1ONDr7kqkB9gczipVNlLJxKYE6jrIvkDokB)XlxKERAm8OjIeoAWLz1sTiLtphCGBWkwIqYVVrtmSEd2vY4Yk7csVPkQU4nEvvw823Ess)4Ohxx)(kvAsBs7j1DoiMLCwIOERBqdONzsX5u5ZklmPLecDLq7U9P)qBwBTlXP)iBwd0nicYu(lUnygz6CaCqB5trqRTmCgeIoUbV(cJ7CGnUGEo4mi7mC2pAZW5Ed9g4ryAmE1PItT(c3V5r2)zFXLPvMaJ2zk0zskvEk9kRoMjQSis1lssLlDAMwAGGrgj0OrGZNAacVIL0k2DiKSc6UY09YyKmgeR4sAZmS6YMSV8XyS1pS9Pg1Ku5miPEJLQVyDsqdfSRKYCcpf8(xdr3bP8i2nruc87gc4c6hcEd7wgcDiqjgq63qlLQ7U6lyQWD198ZR3e21aoCIOBeK3cn1hWvSzOW1ldH5Gb58pVMwwQT6P6TAhfWf3ne5oPtbyOEGOsWWUGrscxQc(DiwsiUeKijmAsymkjnmEyyIKWLT5KF01Xjdxjj89vn)l807VVpls7cF)sWpaJvfMCdjspdsKcjtd8Vvhqk4(bboq0fqzaH0VjKjjijbYVvNWvDbtzZGbkhgY2iO6c02lOdtdgCGjY(awqUKvcXGFMJqNeFC4Nf(5CdFc4tcNh(uWN2n8zGFE4ZMe(COUf(fOQuOqfkr4xKP36VRSD3t)DErrJ8WNNQLGVqyMg6BTB4fD0ppAv6N7GAMdZIagUhj47fUx4(yukWrqXZd4cEWdap0EDuupYv1p3wfeymkFkAkx(uulZZ4zem4D9Zwh9UFsE0HiAy6zef(m5i6DxhDgdOr0JFmGql9ZF7oJ7NWJXPwpt5X4ZsJ5wWtWSPqwfIEF3gxBcFE8MgTcOXC3sToaR3g5XAUcRJtrnj8IgdDvLXGBh4Bue(gcrRpjIjEkga1xYkaOHwA0bJCLzgv4ksMJsrMmIJ3jylozZgcs8QziMNP5fWWMqszR5GXILNxbJHUzyjyVWlpIRt1E34X6nH(bA3B7vgNe8YdYcGPBAJyrX0r3UIjireMQh4CUGxMBH88gY0ihxonpvMBZG3m8LpcoK0hcaFyaAqhWlNe(kHoQMEtNJ1XM6eU(A2DjgH(GQuD4gZTD5k42(LRfUT)SJvj12xAtO2g8wtTjXO2wxaC1kp31UxiphmdhmlE1MdMh(bHpa8m2ALp4ZcFi4hcE2Jdla)WWhgBWpc8CWpQnjY14GFmo4JGXAa)4WZd)e7d(OCWpjh8tHk6pwsyr4fWRWp96OrX73ISOgd4l2qmNUuU07j1ir8D5GOm9ZuG6G1h7bOQKCnLfVrgI1gXWQnXqPNstA8Sxiqrgw0h4ZVpelxIH9Demn8Lpdf6ogcPwhegEf4LFRNd(koyt46WR6GeHV6gbaHF9AaY9fRfi3E(Q3XGCV1h)DNOm8wSKV6VMd(c(nqOf81RYD9V5gbMoDKS5tD6wjdQgQsW0EQem9yBVGPkbqhPiaQiwXfC9cAQfd(RAqtZPyeEMNSmS61WdFGDX62cYQcAztHXBFDV(I2F1akPncq9RCtakPni(Sh(txliQZutKyub8PzCyD71LR6mynQ3U3eoV(9vu6qZBf7bW90clg7wxjdrLGUXTdLh(6lYECGO8zj4Drml6ZlaXGgIXQM6Vu)qR7P9PTvsVrATvnwo5fWo1xSl2fz5fGfQUt1AO7EdzrI0sSKfG9lJGO0AvuG(WnsRukvc0lwswgWytTQDDl7DwTPL7z2U6nxLavU3fbuHxBD4t43AJHMWY4))21aI8LQfe59EOV9N6ogK8T(hV9qHWRd)oiFZBWMm)Uuuf87XIa73xc(dsc)HsWFKe8hlb)jsWFAsaQw3gxqtmBC1zhAGlvHUTJ))MdTF1A65dp71))8E0O3J3(U0YDLbY6lx)ZWZBwbA6JTJenP3GDK6Ltzhg5)6c9LH1o6tEEBWw3W11BYjKFDDfzbE782V1WVFTAd(9j(oLRHILABxWm7fMDj)dNiXWdfl8fgiXThSYSUGvFYVdGvPcEjbZudeDyVrRaw9pxjSQVTvy1ALtAUDctzx1UyF2j7ZtB)mHlKI3OCl6UxkmRl6h95AXINYBL5TAmPBquPpR4fm4fLjQwuWH(HY4uAyd6NmCuHbgow4RmC0e(IaJ)iWesuWdBXhQiHYlYkBIU(9hjyOe10J)hGh)cNCBGdV1LbGL0kpDGVjlFaoyqdAgpPJrzKigAdVXujVb7l)kevr6Yq51x)9xGvvGst6LyLhGTOk(CkilksuJfn4ybJTmRg7CppbxLLUm3kSsftGbNEJvvMEbHNZUh0SZNZGO3sy6kdMMxG800BC8rS9ZB80Jg(Xlx6XJt7G9SKLw(gH(UcZQYzjusJsuB0qENLQEsEdcVxQayZm7oaJcVq4OrdgBsQUzZm6o8T0Ot9wz0rVor2f7cTK9f6wAEF4AXRbh7k5ADxjdlBX5cfxz7vCQWEbO8gj(qveKYyW59tfVfkfRPP7I5jAbAqN011S64sAXhFg5wMlFFJ7JzV)6nYszeAv)ICx7yBtjXCXufHPXqZh8bxyEqypPq3LSxHJ9Er7pQL1tuRwwESKfMYthBr(1sLvMU41so5z7TtzVSsslyueEVUmV926hPmy2Foll0zZtp(aHteS3j6DnhfcD9mO3r63DGi(gAKed7pIVaxeTcdNi8ybRqjLFbbC6YwLcAcYujkin93g(VkPPwMTa5oTjj8FxTcRNqEdmtptn(utlZuy7fcpWRDHVi7pQEBBtPb)pRYTR7SAkVBHMAvUDxslTkNlPv52ZnPBwLBVRY9EwLBFvkIxLB)RYDG1jxxLZ9njnpnvAEAQ0uVK089BlnFjM08j2EdJA1n1dh8NpODqRLE05)IQ9Nb)LS4B(gOdIXB0Xnf8xz3M)A4VPMCjneVkFT5scUr1oIG)Ukve)9sfdhN(XA5H)f4FDJzOVFi)5SzoH)TnJVSXBbF5AhNA3q30iAZqmo(XRIMw)jU5vTSIwpPirqolVsLRH5XU19WUUurZLnfXqVLBDJzEQy7uQyPv0W4yxxOAVn8Vd)hW)zfa10W5JncTVlYgbAx5kcxzjnOu13eYD6ykxQJP7V3G5nRK4UnxuI7Qc(pgVICgvuAwg3AyVlVisB)lhvbQ8Hyq5YoAKyfxCQ)HTEBovmLpSZjJomei6NPE60iMZjijl4jUagZqw9tvp9nepYKF66PhvSBS26fERYoEtlevx11eLqePbnR3B90R(LZlRs8Cb21RUMT9tWylOBqh800nhv9nBdird(ZKO3tDP9T4nO77irZTEr6QSFbvYPsoHPZT55RRjQMAAQ1mDjndPWBkvFsjS70yCP7Tg6kIQwFa3(X4H9eNxWqoTSabj59Jbbpd8nPu6TwZd0640JPiNv26(24fBCzNTicB71vbXUFtndl4G0hXqGCadtlE62CJRowosVjUyFNYl)aHhmanc0i0jHuXfM8BSNVBLpt3BsMidwo5aRY9a1uYXp3hQISdSk3JTjPh4K3I0dCZ5v8g27bLIkp4nOxM6nhJ5h(ccxk)vnuNwQ4JVh0EbG)UD6JRjX9dwBRfXxBBqCVkxNOigh66veZhm989W3xkFYE3jiIFOAre)lDSTljmoY1RaoChd1P3WbZoqVKDcc4hUMWWvTFNUZIHXHUEfXJo6ijU8O(pT35cVtqe7PMeXvTKb3zfX4qxVI4axD2HLcK7IrTU4obr8JutI4EgyBteJdD9kI7Ca)rJ2zSCIXf3jiIpATTmNpZ2M3o2yxVc5RyoHwOR0VF1GtStqi)O1gooX2hoor97WB(wVuRHLUCRDXVtqeFSAeh)cBJ44xOUfYz47nCQmzMpU1L3jiKpEnHJp5JVTHJXHUEfXgTmXG9y01fY1XocQIMRfr8R853UKW4ixVcyPPngOfjHrNQZq7eeWNO2ik(GhC7JOah76vi7lEIzj(MrjC0G7eeYTuJc57zBuiFp1TqULW8(UulQcdgBhXdr3An6Y753gD5981TqU)zJ3x4(hzUzgDt5JFN)Du5m6p5w(stqYkRksmkFo6sV4jRSj9TkU(6Vto6LniL6)5RN(JT1s2kNyPU78MF0AnpiBRV6hrdKZxIObcMtsPygwjVl9ffBvo)10wX6CtxLrvWTYOITMP9zVMPD78oJSzMzL2Zu4fzdEtWwXoLSd5OP3Y3kSzn65IrNvWB(w6SI3kSxA3VdVP8QjLrGArz86hR(0f)tU(WBLO)1p2gj5xL7cBT4oKM(edgsqESO(R(LW7D)s7(RfP9Rm0DAP9jFLH2FIZCBlWTMoL5mwrUu4t1Dfc8rRqG3K423MpPMDP8rGJdFj4VDvoUv5URv5EFONyu65xKykmlxWQjQTFDR9OBttRZt38q0FajAV876xl30lgzB30B7yBv8km22g8Ej22nTgVTTU3GWwBdNeAcMT5rO4gKzgzlj7XnKc)CS9ldE6SoBydSHLwWWwynDoCk5Ho2NWS4neBxGz2QhECqCCy9403qApgfDh1UJlktpAQkZDwNEqhlpIAQNWYd9N(apZrWXYcNesSDly7iIEr2kfs)nHq)eL3BuSFJiEA27kXK23Gtw2LnD)3UvB4NBFFFcbYfzeHw6yMRWx033ZFxnLTjXMmJ1r7D1ENnLFppZ)7p
```
<!-- pack:ShadowPriest end -->

The same text is in [packs/ShadowPriest.txt](packs/ShadowPriest.txt).

### What it can't do (Forever's limits)

Forever hides most combat information from addons. ForeverAuras gets around
this by letting **the game draw** the buff, debuff and cooldown icons, so
those keep working in combat. It means:

- Glows and colours are limited to what the game can draw itself: "running
  out" uses ForeverAuras' native Remaining Time glow. No out-of-range or
  out-of-mana colouring during a fight.
- The Mind Flay tick lines show on **any** channel (Mind Control too): in a
  fight the game may hide which spell you're channelling, but not that you
  are. They're fixed at a third and two thirds, which matches Mind Flay's
  3 ticks over 3 seconds.
- Debuffs from other priests don't count (in Forever, Shadow Weaving only
  helps the priest who applied it).

## Testing in game

v1.0.0 "works fine it seems" (17 Nov 2026, one report; items 2–9 not
reported one by one). Please check and report:

1. The import works with no red error in `/fa` (updating: choose **Update**).
2. **Cast bar (v1.1.0):** casting Mind Blast shows the bar filling with the
   name and time; Mind Flay drains from full; the bar disappears when the cast
   ends or is interrupted; **it keeps working in combat**.
3. **v1.3.0, please check each, in and out of combat:**
   - the two tick lines appear on the cast bar only while channelling;
   - the mana bar fills and shows a percentage, also in combat;
   - a DoT glows gold in its last 3 seconds; a missing DoT has a red border;
   - Mind Blast / Shadow Word: Death glow purple when ready, only in a fight;
   - the Shadow Weaving number turns gold at 5;
   - Spirit Tap (after a kill) and Inner Focus (after using it) show on the
     left with a gold glow;
   - Vampiric Embrace and your race's spells show in the cooldown row while
     cooling down.
4. **Out of combat**, with a target dummy or mob targeted: Pain, Plague and
   Embrace are grey before you cast them, bright with a timer after.
5. **In combat**: the same, and the timers keep counting.
6. Mind Blast and Shadow Word: Death go grey with a countdown after casting.
7. Silence, Psychic Scream, Fade and Inner Focus appear under the row only
   while cooling down.
8. Shadow Weaving shows the stack count (1–5) on the target.
9. Remove Inner Fire (right-click it): the reminder appears. Same for
   Shadowform and Fortitude.
10. On a priest that doesn't know a spell yet, its icon stays hidden.
11. On a non-priest, nothing shows.

## For developers

- `tools/build.lua` builds the pack from a list of spell IDs and writes
  `packs/ShadowPriest.txt` and the copy above: `lua5.1 tools/build.lua`
  (`--check` fails if either is out of date).
- Tests: `busted --lua=lua5.1` and `luacheck .`. They check the structure and
  the rules from ForeverAuras 1.4.3's own `Display.Validate`, read from its
  source.
- `tests/fa-check.lua` runs ForeverAuras' real validation code on the pack
  (needs a ForeverAuras source folder; see the file). Not run in CI.
- **Spell IDs come only from Forever's data** (wago.tools, product `wowf`,
  build 1.60.1.70938), cross-checked with ForeverAuras' rank tables and the
  guide. Never Retail or Classic data.

## Credits

- [ForeverAuras](https://github.com/neroxrw/foreverauras) by Neroxrw (GPL v2),
  a modified WeakAuras: the import format and rules were read from its source.
  No code is copied.
- [Forever Aura HUD](https://github.com/tomqwu/wow_forever_weakaura) (GPL v2):
  read as a working example of ForeverAuras displays. No code is copied.
- [WarcraftTavern Forever shadow priest guide](https://www.warcrafttavern.com/forever/guides/shadow-priest/):
  the rotation priority.
- [Blizzard's Forever priest class deep dive](https://news.blizzard.com/en-us/article/24301514/world-of-warcraft-forever-class-deep-dives-priest-and-warrior):
  Shadow Weaving, Vampiric Embrace and the race spells.
- Spell data: [wago.tools](https://wago.tools) (WoW Forever client tables).
- Bundled libraries (only for building the string): LibStub (public domain),
  LibSerialize (MIT), LibDeflate (zlib); licences in `vendor/`.
