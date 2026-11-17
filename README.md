# Forever Auras

Aura packs for **[ForeverAuras](https://www.curseforge.com/wow/addons/foreverauras)**,
the WoW Forever version of WeakAuras.

> **Status:** v1.0.0 imported and "works fine" in game (first report,
> 17 Nov 2026). The **cast bar (new in v1.1.0) is not tested in game yet.**
> Please report what you see (see [Testing](#testing-in-game)).

## Shadow Priest (v1.2.0)

![Layout](docs/layout.png)

**What it shows**, built on the
[WarcraftTavern Forever shadow priest guide](https://www.warcrafttavern.com/forever/guides/shadow-priest/)'s
priority:

| Row | Icons | How it behaves |
|---|---|---|
| **Reminders** (top) | Shadowform, Inner Fire, Power Word: Fortitude | Shown only while the buff is **missing**. Any Fortitude counts (yours or another priest's, single or Prayer). |
| **Rotation** (middle, big) | Shadow Word: Pain, Devouring Plague, Mind Blast, Shadow Word: Death, Vampiric Embrace, Shadow Weaving | **DoTs** (Pain, Plague, Embrace): bright with a timer while **your** debuff is on the target, grey while it's missing. **Mind Blast / Shadow Word: Death:** grey with a countdown while cooling down. **Shadow Weaving:** stacks on the target (anyone's counts). Hidden while you have no target. |
| **Cast bar** (under the rotation) | Whatever you're casting or channelling | Shown only while casting: spell name on the left, time left on the right. Channels such as Mind Flay drain from full, like the game's own bar. |
| **Cooldowns** (bottom, small) | Silence, Psychic Scream, Fade, Inner Focus | Shown only while cooling down, so the row is empty when everything is ready. |

- **Priests only**, and every icon stays hidden until you know the spell (so
  it works while levelling: Shadow Word: Death appears at 32, Shadowform when
  you take the talent). Any rank of a spell counts.
- It sits just below the middle of your screen. Move it with `/fa`
  (unlock and drag the group named **Forever Auras | Shadow Priest**).
- The game's own cast bar still shows as well. The pack doesn't hide it.

### How to import

1. Install **ForeverAuras** (CurseForge app or curseforge.com), then log in.
2. Out of combat, type `/fa` and press **Import**.
3. Copy the whole text below (the copy button is at the box's top right) and
   paste it into the import window. Press **Import**.
4. Updating later: paste the new version the same way and choose **Update**
   (not "Import as copy").
   - **Coming from v1.1.0 or older:** delete the old group in `/fa` first.
     v1.2.0 was renamed and imports as a new group (only this once).

<!-- pack:ShadowPriest start (written by tools/build.lua) -->
```text
!WA:2!DR1AWnX11FeckGA6FSnbkqtckaXXqCCadyW8insYsy5ilBwjBJj0)wxT7vAx8QDxU7kzBAttX9fTnnTXn9rstFPK(o9lAY0KPt)KNm9ZNXt(wFmD4dD6xABQ7h7mD65E3vpSbdYM8SEgVAp33758787Cp3D9nABY)WwV2(yezhntd7EYMtZqZwnqy8hNas2oeg(dr3sL4FrIHSQjlgJuGMEglA2urKIgnzf3Ih2uZWjBKOjthvAoIHwbcFe7bwFSfukYect4G9IztLnnuSNNsSPPCyuJ8oQBAwUeFqdByAqdZBiS1WfiAgXGpmCxWhztW)hSvOf8)nS8sYsk6GlGfIzYOLOSGHWPZEb3chYs8CfyHSe5jvyMwrm1nzd4d)lBwtMcLPED3Fd71aRwcRRDLRqykbtBAQ7OzvXTb16P)YUfevjp1Q1uxUiHrdgROUEWXu1COEnpUHn1X)8UcdLlhkTfVoMs7k0nwMRf0CxDzX7ZPLpGvB4nomtDDQsevnDfu7CjRtVKhSGFQGPujkMtfCyMg12bLLmDe636vngopNm4WO6Z6uRIE3hTKzrMMr(GdRtYxKADSvrNhuZqjyyDITJ1zwRR4(Oeh1v1sEusblnMMCWOfYIOyQvVRH5MskHp0vYXr2iKK4q8VxnfRoA2HQIMrotMhIVcERmnAjQHJTAL8mZIwUMFvRDQL3ahspqPOjrzmtMT6IOZdLzq0hfDqWkFTW6MeL2LKr9PD7sfkIaXazTXvPon7WsXJMk9CfTPtiQptwlecA4yDV3YfCzgnpo0CVmjXYsYwMOt9pNnvpNW9f2swBAbCaKoCxD31HkBxmRKOp2bk7ykxYDTT5h9QZ6W0YNhft2oZ72ysu(Zt5i1G1qlHlISiqKSw6KzOSRZxWe9PiZy7WksZmxrdV(gWQvobujAAx5bnvO(ROOzFPIgIY7MOR3DrnLkJmqIlm1iYxq1EeM3YXpBAx9Rp2mE3CTobFiZtaWFaydbQquUurBhQYGKPxFDbnJ1dB0p8HGnbBg2ceGtvTCUMwV9SpqBW2G7oG12Y6rBW199PzZFM7zExE1uMfrgp1zlqMoo6HB7FbBv0IP41SmsYcUf)4FWE2D7mzvIrEQ9bBFwlKrIYCMPSc1M4W5rPsLi6O2RDymyJW4dVHd11rpMKSkvEYEGhZpmUVzlryAKS605Zr4lMqcviemWSYiHgIhmYmF174CyQluvk1uAw0mw3Dv500PDW1iFSuYaNxf6WFwvQwEvNXdRHpizkZVIpDiG)Ewh6Ya7foypWdPcDQcpSk01RHKjCZenZItsPwHSTOYosC)ev4rgfou7WHdaDdhPmwHU(Kg4C(M7hokUe4yf60O6BI6vPkqq1LZahdoW1rvuEg122DzCW7zDRhooKf61pCs0SEk40Wzo4oGwwabZ8GaCKVHY125cUHToVhKXtCCpX5DfNWY1TOmJ7Pt56JWjhkzuRT5G3obgJXK71lpMMIJA4qOyzrf1TNlkKZPnnvr0ORoNBbipVvlXyAxj45ksu4uobtNEHA1XdrSN6ICFw2qJKor8KrNxukheRLBgylxxiwZfoCOrspKvlUfk8(Rh3YQTgkU6d(skS6JV7IKFzVpGL1UQjnHln3ewE3i5OvGQyDGBsd41mHYmgKcAYt4OIwiveuTjR7BLARRKpR7FLAGfJkRX949Dtwr2E3aB1v)ucBjcBZ4QdNcJUmgJyn7yE3aTWq8aVo4rr(m4J)mTdp2VZQfc6VirmMmfhKfVp7D)M7FEEzPXyltISVzniCNjrzcGOMcYnQqZwmxoHrQ)qsdgBKeqOS9tj6oQl42HyA6i)U9oYoCIqJhvkZ84UGyuNuQMtnKrzu1mvibXO12DRyeBAJlJmwTwR8QLPcTu2TqUtoYYI7vlp1zr0hjk3XXTDkQqSaWz9d9dXVUBZJHKPCpbK7AGkMNFWCtAQowHZgXQnSRr8C9rky0pLMbs4xAkoWDCyWNEtqsFHVIPzboRZHpXsPzHHwpm8BNuQW56bKuHu(H0zGrQXocJEqo335HXxkhiCbp(p4jGlISDWNid8)RctKbY4XDbKXHSzazxQQ9TmQkaP4OlLwcYTHxhzJG8QGQGSb0wr(f4sxBNWK(aDFqbSCdWeSGldES62xfCGIqP9atbtdOBlCf4tcFkHBj8K(GpTp4Pqxn4ZaxfMDtWN1h858bFEuv8fYaFr4A4W)LAeOcF5DJRSVc80Wxna8mWxdcbFD4z3bmxg4Baph8nZaFleEaFBic8DGNVbia8ccR(XtuOu2JFa6a42RFrUng(EC77gq7l899mUp07Sg3gnO7UQbTQn0p8eLnnQIfxQXu9Mzm3)nymvVrJ5M3Zl2mwZDlSMEQ7KO6(VaHS2v1fdUzk34nb7q4HDGfYtnO4oqD9LHNBobVqsCRK48j5WjoGpb0IKOy0G0N12wwWnEBvTALx6sglVWGUBAumzpUimOWr1Rytm8kttHQwreBe7xEzf1fBqGtYPUqTiN8jlJyVJILwMgWgdurR7PnVSwptF0tuSrCHV3hHlGFytahEGMboSZT9V)URv8a8JGYOJ2ljgJxMBFHFm32c)ev4NMb(zQWpxf(fQWVufELmWVAPA5uYMkfszm9G9FUg0YhUrL8hOzwBVzyw38P(1VFLALV0w7CRfVq)fcvSVPie7gSUp7)ZyDFWMZ6(8RoRBNRd03iuOs4HsNEObLIF2(tVsg69Dln02Rkd9lCdg6anNvoB0ZjBNT)Kd1DYgSY)ZgTY9(oQvEX6jZ4UdF(SEOJkUEeX1JZVEIJnBwcRElo2jg2pA15x61)CvRQBpusaU9)8QxNAWZ57SmIIgMtphdyTT8EsdX4xfN1r5(hsk(fgkz6qjaY9dzv5yeroHnKb0CczBmgv4erJLUPoyLie8hCXDtOXFK2BaND0mvmRVCGxhHA9ufQX47rNpg1bCymycBYmxx8tyDQHc)Kg6ouF9vwuuKAl6kc5(f56gYtqtrHAiLm6OrLMxuIBYsN3xJsJ7BbHu1JgYhUZ9gL5ti8jD7bpDYImQvhX5h(toIm9I8hCmnJWe2fhj(dxx6HtX7G7QuKhzRWzgq484LAlM9dTAQTWKBrWvwoEYKrLMGR1xjFPTFl9LmUv(s85jX6etuf3j6w61U9MHE2NyM8VSzI54QOMT6jZUGxbUP83DIud2q05rHqH5kUY12UJDaCuIWdpplFFp8dLAPbK7iejVwhZuQ3Xcj8KFJwHbX98Ky9W3FzNLKerh33f(qu3rM5Ey3if4DkV92fNlnSdv4Jc7e2LRkA3WhdUh)W9Uf4(2yzzkhPWt0CVjK8CxV)bSoYT1FYBZRI60qGVm16KRMonS9mYQAYbtHjqskyDOvtFJruOwhF10J4g4UGdgZuUOns9egX1tbVoN44an9OSmMdjDTcAo7A5Shc(IJpV3Xuiou0gOlcBBYCGTYznKPBHz7q4hoPp4mbAaUfddBeUk(cIUuGv3PF8Epu3K(Jpqeo0lbFrOYHyC41P3W7w7LoWkSL5Onew)33uzqD6NQXW6)5v5oMVUTiVMA519s8XB1U75sdDw5Zv6smJlRwnYBuH(8D9uuAg16FO5sm93CNOwH)kQjXHy1QjjrZDLEi9MnKw3Faqt(hBgn5lV)7ufjocRw9y8dp4r6oE0c9Fc6ha0J)PMcr27p4ogrIdXQvtoYidNE8rcF8UNj(kPj33s0KVnQdVTrFRgV9Kwp6T9fdslOzOqz1RJF60blOzZFfERU(7fmuJrR1)ZSA6p2whnNIk16oIiAQyP1gKLdyUPbrHtSeKrthImzKIHsNms0IQ6vdmsFVib5aRqQVXBW15V1uP(E6l3ORZB1mUo1sif7B1esz9hnXWIxLGxAPl4g9CqpRyJPO23nlf1Pz984jNwU7sDCKQotXHbFL1)E8jr0mk6)EZOOFJ9VM1ZyxRL3)I1Z7)FD7vQXmTo)aXK1gnz4guQ((aGo9F0m60xDW1Qo9GV6GBo9jxRQvNlN1EkNeNl(HowdQ1rAqT2MY12)75u)daha(Ty0W3kSc1w26)Suku33HAqlxcumPHjdk(ok6Q(3Csh3WhOtN3WxDtNn8P005n57JPZB4JEPZL9LSCGodk7Dck4D1sSIGJQxmGhM)cldYQYW3LhRVDqtd9zovqrQZ2bNXSyqftJh0ji)9ThCgQtqmjOzcQkokKUqi2CICM4Fudwpy9tXq8roCrXBSyc3v2e1JcYXI9C7cPSMdNihPyIHL74WtDbs1Wjp9D1wH2uAZw6WDD0UosBL2Wt(F)
```
<!-- pack:ShadowPriest end -->

The same text is in [packs/ShadowPriest.txt](packs/ShadowPriest.txt).

### What it can't do (Forever's limits)

Forever hides most combat information from addons. ForeverAuras gets around
this by letting **the game draw** the buff, debuff and cooldown icons, so
those keep working in combat. It means:

- No "refresh now" warnings based on your own calculations, and no
  out-of-range or out-of-mana colouring during a fight.
- No Mind Flay or cast-time tracking (Mind Flay is your filler: cast it
  whenever nothing above is lit up).
- Debuffs from other priests don't count for your DoTs (only Shadow Weaving
  counts anyone's).

## Testing in game

v1.0.0 "works fine it seems" (17 Nov 2026, one report; items 2–9 not
reported one by one). Please check and report:

1. The import works with no red error in `/fa` (updating: choose **Update**).
2. **Cast bar (v1.1.0):** casting Mind Blast shows the bar filling with the
   name and time; Mind Flay drains from full; the bar disappears when the cast
   ends or is interrupted; **it keeps working in combat**.
3. **Out of combat**, with a target dummy or mob targeted: Pain, Plague and
   Embrace are grey before you cast them, bright with a timer after.
4. **In combat**: the same, and the timers keep counting.
5. Mind Blast and Shadow Word: Death go grey with a countdown after casting.
6. Silence, Psychic Scream, Fade and Inner Focus appear under the row only
   while cooling down.
7. Shadow Weaving shows the stack count (1–5) on the target.
8. Remove Inner Fire (right-click it): the reminder appears. Same for
   Shadowform and Fortitude.
9. On a priest that doesn't know a spell yet, its icon stays hidden.
10. On a non-priest, nothing shows.

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
- Spell data: [wago.tools](https://wago.tools) (WoW Forever client tables).
- Bundled libraries (only for building the string): LibStub (public domain),
  LibSerialize (MIT), LibDeflate (zlib); licences in `vendor/`.
