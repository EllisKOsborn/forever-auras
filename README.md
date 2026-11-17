# Forever Auras

Aura packs for **[ForeverAuras](https://www.curseforge.com/wow/addons/foreverauras)**,
the WoW Forever version of WeakAuras. Made for the Short Royalty guild, usable
by anyone.

> **Status:** v1.0.0 imported and "works fine" in game (first report,
> 17 Nov 2026). The **cast bar (new in v1.1.0) is not tested in game yet.**
> Please report what you see (see [Testing](#testing-in-game)).

## Shadow Priest (v1.1.0)

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
  (unlock and drag the group named **Short Royalty | Shadow Priest**).
- The game's own cast bar still shows as well. The pack doesn't hide it.

### How to import

1. Install **ForeverAuras** (CurseForge app or curseforge.com), then log in.
2. Out of combat, type `/fa` and press **Import**.
3. Copy the whole text below (the copy button is at the box's top right) and
   paste it into the import window. Press **Import**.
4. Updating later: paste the new version the same way and choose **Update**
   (not "Import as copy").

<!-- pack:ShadowPriest start (written by tools/build.lua) -->
```text
!WA:2!DR1AWTXv1)OOesIO8p2onHKqBZ2Ku34uhxBhBN3LkzlzlxzzNvYoXHWFRR29kTB8QD3S7k5h0sjMxbOuOMYJwkLIA5D5lA6q7WWN80HpFgp9B8yy8hy4lafZhzggo37U6HDItKD6t8mE1EUV3Z53535EU76BSMKEPgV(HSisoQg629KoJQUQTsGq4pobeTDiw4pentfI)Lj6skgwrSi5OjNXKMorVIHdhVKBXJyOQ7KU3WXtgwCEIUAocBe7b2CKfLZBXfMWb7LLnvYqx2EbkXMMWXIQN1rzBZXKydAiDdDAiwdHDgkhrvpc8rH7c(yBd()GDcnG)VLvxsAsEhCbSyc8IJGOXmenNzw0TWHn5pxbwmnrAszldZEn0mSg0h(x60gwYulLLC)nKxdmBiKM6SZsSKfsAyO5OAwYTbv6P)IUfewol1SXexnpXIkejVMMWfuuDOEnpQUn1X)cUcdNjdkTdVoMqDw6wlY0cQURU049zuZgWSj8ghldnnQCVkQAYO25kMNDfpycpUqcfISXucJyPsTDqzrdhU(TAvxaNNtlmcQ(mpZ6O39rlyK3svpRWiAKS5PMDVo68qQ6YcH0i2oMNBJUI7JsCuwxl5Xi5mvTuLecNlnIIPMNAdm3usb8HUuggYgHKehI)dQkBEK6DOkPQNXWYdXxcVvIgUav3XwPuwlJ8MUMFfZ9QMv3WI6bk5njSLLHLTYYOZd1sNOng6GGv(6H0miYnlkH6t7MfZLhbIbsBJRsnA6reJgorY5ZBtNGxFQ0Mieu3X8EVLl4Iw0S4qZ8Ye5llrBjIg1)82uTmC3xyhPTP5kqTe7OToAR9I25tlY7JDGIogsfCxBB)rU2CowQzZIIXB2Y72iIu2ZtXERaRHgcLhzrGEtBQrMHATeBbt0MImJTJvEAQ5ZR713aMnYiGkqt6kpKHm1Fjzv7RKxNxENenToZRkxYiHzgDJGbp1vjwElh)wt7QF9znJ3nxVvWhY8ea8ha2sGse5RK32Hkpez6nxvqvFZWw9dFeyBW2HDabyuvRMRPXBp7d0eSl4UdyUR0E0gbr2U(uTzpZ9SGlVAcJ8iJNYC5ithf9WT9VOTcAXK9Awkrjo3IF8p4a7VzljfIEwQ9rBEotKrIA5mtrzQnXHXJsflq0qTxZWfGTcJpYwAVTU6wusHknzpWJ6hg33CfiwQK0A0fYqylMGCviieyojKqdXd6PwO8DmomLfllLykvtAkZ7USCs60o4AKnwYPGlQahXFAfQAwfNXdPIpiPkYUIpDiG)E2e6YaheoApWdPaTQahtbA71rYeMzIMA5jPuZG2MujhrMFIc8WJbT3m0raOt44fXk00MuhNZ36Wqx4sGHvOtJQVjQwLchbvvof0n0YsOkkRf122DzC07ztBgobKgoLF40Oz9mWzHZD09anSicMzbbyiFD5RV3fDdBDrpiJN44EIl4koHPRBrrlMNoLPpcfF44Hn3LdE7eymgdMxV0fuLDucfeflYROQ9CzUCg1PPY8gDT5Dla55nBiIL6ScNpprMr5iKm5IvQJfI4avfz(SwdpAYyrJhEbEPmqSAMzGDSexSIlCOGJMCyZgClK79xnULzt1uC5h8vuy5hF3fj7YbFatZ9vrAcxAUjm9Ur0rnhv2SLBsdy1mH8m6KCQst4OGwifeuTnZ7BTARRKpZ7FTAGPfvsL5X77MSIS9Ub2PR(Pa2se2MYvhofgD5cweZ5UG3nqdwiEGvh8iiFg8jF6MHh93z2ab9xej6tMGbYI2N9(FRdVaRSKySLjr2306eMZeVmoquvg5gLPPZNjd3inqqXHImAmiy6bOijSYIUDiIQgYVBVN0Jel44HftTaUlilQdYxp1W6frvZub5eJM72TIrTP1Umsz2yLYlxMc0qr3czo5illUxTSuNLrFKWmhh32jRarca97hgaIUKBZJGKPmpbK7AWsJ2DH(NE0ZhlzHrnBc7AVEU(ifm6NstbX8lofd4oom0tTniUVqZAyKJX60Xjxjnlm8MHrENKsfoFpGOcKWpKmfmAf2rySJY4(Uim(k5aHl5X)bFk4YiBh8Ptb))kWePGuECxazCiDkqYLQ6qRIQcqko6kPLGmB5nq2iiRcOWjBa11KFbUY13lmPpqZhKdlxhmat4QGhRU91ahipu4aWuW0a62cZcFg4X5ULWt4d(S(GNeD1GphCnyUTbFEFWxWh8frvXxkf8LHRJd)xPwGk8v3pUY(AWtbF9aWtdFdii8nHNzpW8PGVf8SW3of8Dq4b8DHEHVh8C1abGNNB1dfos2od5mBItQdVaZgd)aM9DlO9fErpJ7d9URXTwd6(lBqlBd9dFQIg6LXIR0yQCZmMh(gmMk3OXC7h4fQhR5(5wtp1DCuD)xGGM7R8Ib3mLB8gHJW9WAzXSuDkUduxFz4zNNZleh3kjoFIomId4tdniYlgni9zURvfCJ1wfZgzLUIXYlmO7Mg5t2JXddYDu9k2adVAPktvkXJnI9lRKSYY1iWi5uwSsKt2KLIV3r(slvnyJblnSXiJLF4Uu7AuPAXf((aeUaEP6ao8a1dCyV76F)93O4b4hbfrhTxMpgVcZ(c)yMTf(jkWpnf8ZuGFUc8luGFPc8QPGF1k1Y5cnqhzZ540FVZuJwUJAvYFOMzT56HzD7N5x)bvQv2sBJZT2Uy7NYO9lE(RmgPgR7Z8)mw3hS(SUp36Z626MaTTc5kfA4KjhEiXO9pqY1YqFOBPH2EDzOF(BWqhO(SYd0zVHgyazPh78fQXk)pR1kFQ3vTYlxnzg3D4ZM127IF948RNGD9KDpxAIv1w09jhXpA1zxoL)5lxvNEOKam7)fvwIQZY5RFlISkMtpddyURSEsdBXUYpRJIdmSy0lnC8KbJbK7hsRWWi8CcRjdO55Y2ymQqXchjzDDWk9sWFWf3nHg)HBUgCwxPkzuD5aVbc16PmuZIThD2yufWHXGjwtMAj(pH0O6YStAOZG91xrEr9wzrxIlpapx3GEcQYYuDX4HhlS4c8sCtw6I(QvACFlYLkF0q(WDUxRmBcHpJBpyPtM3IAEKOSd)jdrIEz2doMMriI1Lhn6XQkDSeSo4Uk55r2iCUb5opEP2Iz)qlNAlm5o4CLfJgpEyXjyA91YxA33sFj9BLVeBEITj(evYDIULET7UEON9XNj)RAMSCCvuZv(Kzx0Ra3u(7mwIHQj68yqWqmfxXkB3Xoaok9YcpphBFpSdLALbKdp45N(iHh7KJpwcUN8B2imeUNNyBgEXvDwsIenCFx4drvhzl3d7gPaVt5T3n)CPH9OaFCyVW(Cvr7h(eW94hU3Da33wlkrzifwIMhmMON769pO5XVT(tEBE1MvNkc8LOMNE90PrSNrsrvsibMajjNz7RN(gHitnpX6Phr1XDbleXqkVns9ecX1tbVbJ4OL6EuwfZHOMAovN9TA2doFXjwW7yk4hkAn0fHSXjd2jJ1qIUdlBhc7Wj9bNlqnWTiyyJqLXxq4vcSMkRdT9PSJ1FltYGEXylcfgeJbVo7wEVAV0bwJTmhUMW6)(6kdQZ(K1gw)pVo3X8s288AQKx3lZgV17UN7O)lsv7iV9jm7OCK3WC9575POupQ1)q9Ly6V5orTc)vutIdX6vt2FwQwN970LMT6hc0K)X6rt(kh(ovrIJW6vpkDeB9OsjZBKyQpeOh)t1fI8u)W7yejoeRxnPr8qDMWqBYckxDT0KhAfAY3b1H32OVLJ3EAZh52(IbP5u1LPw2vQJD60c5uTzVcV1x)9cgQArR0)ZTE6FeSPQo5LR0DeruxXsRmiRgWCtdIcNCfiJ6oePshsdKqjzu7b7UCGr67hjihyns9nAnUo)T6k13ZE1ADDE76X1PscPyFlNqQ1aHJnc)vj4Lw6IUrphYZkwBkQ9DZsr94D3D)N44TFYz7)kLDMIcd9QB(95tIOEu0)96rr)MhEdRNXUwjV)LRM3))62RuBPtJKhVLlzCPRKSgLQVpeOt)h1Jo91gAJQtp6Rn02tE6nQA9sdNNADjXH6DS41OwhTg1AtYx)WVVt9pi0c8BXOHVDizQTK5)zLuOUVdvbtxcumPHjf4FhfTv9Bo5i3WhOtR3WxDtR18P006n57JP1B4JEP1v9LS0sRcsENGcExLeRi4O6fd4ySxyPGvzg(28y9Tfm01M5mc8uNTfMXiVGSH(d6iWEF7cZqDeWKGMrqHFuiTHqS555mX(OgmFWQNIb)JC4Y83yXeURSjQgfKHf752fszdhojA7rK7k6GzsgB0YHtEQ7QPCnj3KTyhT1vBhVPcB5j(V)
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
