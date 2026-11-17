# Forever Auras

Aura packs for **[ForeverAuras](https://www.curseforge.com/wow/addons/foreverauras)**,
the WoW Forever version of WeakAuras.

> **Status:** v1.0.0 imported and "works fine" in game (first report,
> 17 Nov 2026). The **cast bar (new in v1.1.0) is not tested in game yet.**
> Please report what you see (see [Testing](#testing-in-game)).

## Shadow Priest (v1.2.1)

![Layout](docs/layout.png)

**What it shows**, built on the
[WarcraftTavern Forever shadow priest guide](https://www.warcrafttavern.com/forever/guides/shadow-priest/)'s
priority:

| Row | Icons | How it behaves |
|---|---|---|
| **Reminders** (top) | Shadowform, Inner Fire, Power Word: Fortitude | Shown only while the buff is **missing**. Any Fortitude counts (yours or another priest's, single or Prayer). |
| **Rotation** (middle, big) | Shadow Word: Pain, Devouring Plague, Mind Blast, Shadow Word: Death, Vampiric Embrace, Shadow Weaving | **DoTs** (Pain, Plague, Embrace): bright with a timer while **your** debuff is on the target, grey while it's missing. **Mind Blast / Shadow Word: Death:** grey with a countdown while cooling down. **Shadow Weaving:** your stacks on the target. Hidden while you have no target. |
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
!WA:2!DR1wWnX5vyeckGAAX2eOanjOqiogIXfBadMlPrswclhzzZkzBmHuR)D3FPDXR2Dz3vY2KKMI7nABAAJt6LKMMMQKEp9fnzAY0Pp5jtF(mEYB9Y0Xp0PV02u3h7mD65)FxDXgmiBYnQNXR2Z)99C(oFN)Z)U(gPfPxP5REFwejhvdD7UfZQQRAReim(JtabBhIf(drZuH4FrIUKIHvmlsEA6PnPIPIienAYYUfpKHQUJyKOjthvywIUAEcBe7gwFS5LlyXfg3b7LLnvYqx2EokXMMYXIQNZrztZWKydAyDdDAywdHTgoprvpg8XH7a(eBc(KWwHMW)3WYlrKuWbxaZhZWIwKAfmeoD2Z7w4GM8NRaZlsKMq2YWmIHMHv)(W)efnSKPwkl4(ByVgy2uyn1lFzILCW0ggAoQMLDBq1E6VKBbrLZrnBo1LkqSObJvqtl4OkQouVMhx3M64FoxHbZMfL2IxhtPEz6glX0cQURor8(SQ5cy2cEJJLHMgvoIIQMmQDUO5PwYdwWNiykfISXKbhYsLA7GYcgoC9BTQgfNNteCiu9zEYvrV7Lw0OGLQEUGdPrYvGAE0vrNhqvxoyynITJ5PxRR4EPehLv1sEesEtvlvPGrZlIOyQzpRH5MskIp0LZYq2iKK4q8VxvzZ2A0HQSQEwdlpeFz8wjA0IuDhBLY5Smky6A(vm3PAoDCi9aL8Me1YYWYwzr05HAPt0gbDqWkFZWAge5wfKq9PDRc5lGaXaI24QuJkoKq8OPspBbB6486ZiAIqqDhZ7(gUGlzrZHdnZltGVSeSLiAu)ZAt1YYDFHTiAtZJdGqND0vhDwYUGOaVp2bk5yiv0DTT5h6kZ4yPMlhkMSvlVBJjqzppLIufwdnfUaYIaren1ittTwGTGjAtsM22XQanZSf096BaZMzeqfPPDLhWqM6VSSQ9flOZlVlIMwxfuLlpC)jo)KdlDEf7HT8wo(TMYv)6ZAAVBUA7GpK5ja4paSHaLjYxSGTdvEaYuRVMGQ(6Hn6h(yWMGndBbcWOQwoxtZ3C2hOfyBWDgWCBIE0gmDFVQ2SN5UNZLxnLrbKXtzM8KPIJE42(N3wbTyYEnlJGeNBXp(hSND3QLKcrph1(aToJjYirTCMUKm1M4W4rPcfjAO2RvyuyJWydTHd1XroQGKcvAIUHh2pmMVzksSujIA05YsylMqCviemWmsiHgIh0ZmxL7yCykZxrk1KQM0mM3zf500PCW1iBSKZaNtbAZVOcvnNIZyHvXhKmLyxXNoeWFxRdDzG9chOB4bvG2vGdQaD8MizcZmrZS4euQziBtQKJaZprb(mJahQvOZaqxWHlHvOPnHooNVZ(GJGlbgwHofQ(gVwvkCeun5mWrH9VaQIYzrTTDxgh4Uw36HJbIqp(HtGM1tcNco9b2b008iyMfeGH81LV6oN3nS158GmEIJ5joNR44MUUfLSyE6uM(iCYbtg1CBo4TJJXymyE9sJQk7OeoekwIxrn75IC5SQtrL5n6kZ6waYZB2uml1lh8SfiYmkNGPtpF16yHi2tnrMpR1GdNor8KrNJxkdeRMDAyllWfR6cho0WPh0Sj3c5E)1IBz2sDfx5bFjfw5X3DrYUS3730CxvLg3LMBCtVBeCuZtLn3)1PbSAgxEADsEvPXDuqlKccQ2K59SsT1vYN59UsnW0IkPY849DDwr2E3aB1v)ueBjcBZ4QdNeJUmQfXCMr9UbAYcXdS6Ghc5ZGp7Z0k8W)EZMiO)IarFIumqw8ET397SV5yLLgJTmbY(kQtyot8Y4arvzKBuMkwiBwUrQVqcdeB4eqiX(OenhL5D7qmvnKF3EhIdLi0yrfYmhUlilQtkfJjhuVeQAMmeNy0C7UvmSnT(LrgZMRwELYuGMk5wiZjhzzX9QLJ6Si6JeL5442ozfiwa4m(H(G4l428yizkZta5U6VSX5gi7egkJM)mrmBb7AepxFKcg9tPzGe(fMKbChdg4P3eK0x4lByKNX605Xxknlm46HHEVKsfoB3GGcKYpKodmCv2ryKdW4(ohm2s5aHZ7X)bpkCbKTdESmWNtbgpdKXJ7ciJbIzajxQQ7BzuvasXrxkTeKDdVfYgb5uafozdOUI8lWfV6oHj8bA(G8y56Gbycxc8y1TVc4afGI7bMeMcq3w4YWJdpb3TeEsFWN3h8uORg8fGRaZSj4l6d(s(GVmQk(kzGVkCvC4)A1duHV(UXv23aEA4BgaEg4BbHGVn8S7aMnd8CWZdFNmW3fHhW3dIaFF4fQdcaVi3QFSe5lkES9t7h3E9lXSXWpKzF3aAFHx2Z4(GV)ACR3GU7kg0k2q)WJwYqVcwCPgtLRNXCFxJXu5AnMBEpVuJyn3n3A6PUtIQ7)keYCxvwm4MPCJ3eSnUh2(NphvNI7a11xgE(z58cjXTsIZNGdJ4aEmOjbEXObPxZTTSGBS2Qy2mR0LmwEHbD30iFYEeEyqUJQxXgy4vlvzQszESrSF5KKvwSobgjNY8vJCYMSm89oYxAzQdB0Fz1UMY4sQDp1roEH6Xf((ieUaELgaoC)ncCyNB7)8dwR4b4hdLqhTxLpgVgZ(c)eMTf(PkWpld8ZvGFHc8lvGFLc86zGF9s1YPKmKZNsFQb67S1PL7SEL8T1mRT2imRB(K)MpQsTYwARDU1cNVV8Hk07KeIDDw3N9)BSUpqJzDFHvN1T91bABeYxo8GPtp4acXptFPxjd99Ddn02Rkd9lElyOfJEwjBX(soyxjRZq)VQ3q3Z7Rg6fRLpJ7M8zZ6Hoc)6H5xpg76Xp6mIeRAT4OhFi)OHNDPh)ZwPQU8akbyqGZPSavNL23zSiYQyA9myG52Y5jnOf7k)4ok13GcXp)GjthkbqUxquHbt4PfwxsqZYLTXWuHtenw6g6SvIqWFWf31Hj)Z0ADqTJKPSrTLd8wiAR7kOnl220zJrnmhggMynrMf4)ewJQlZoSHUc1BVL4ffP6IUmxUpE6UH8euLLP6cjJosuH54L4MV058vV0y(MNlv50H8HBEVEz2ecpUBpyzuwWIA2wC25)KLirVa7bhZ0imX6cdh)G1KoykwhCxL8ujBgoD)C)hVSBXeGOvYUfMylC6YsXtMmQW4mT(k5oT9BO7K(nYDInpjwhFIk7or3qh3T3im0(4ZK)LntwoUkQzQC4SZ7vGBw)DLi1a1fGEeiuyMIRu1D8yhahLiSi0ZW26d7CPwAm52crYP220f7z0qCp53UzyaCBpjwp8Yl74KeiA4wVWhIAoYwUN3nYcERsDVD(rtd7qb(uWoHD5QI2n8PH7YpC3BbUNnwsIYqkSCn3Bcbp317TFZdFt9N82)kVove4lrnpXQPtdzpTKIQuWuyoKK8MhA103yezQ5Xwn9iUoUr4GXmKkyJupHrC9KWBXio2FdpklJ5qqtnVQZUwo7bNV4yZ5Dsf8ZfTo6IW2gwoWwzSgs0Tyz7qyNpPp40bQdUfdJCeUc(cIUuGvxPFKEouxK(I3Feg0lbBrOWGym41P2WhuBNoWkSR5O1fz)p0qjrDQNQ(i7)Lv5MMxWMNAt1u7Ev24TA3aDXbpJ0zlErl9lPujYBuU(8d8SuAe16FSXYn93EROwH)gQjXHy1QjjrZE5Uj9igsTRBd0K)Pgrt(A77wvrIJWQvpgVZboCxXJMVVJtVnqp(NBiezp)OBzejoeRwn5Wdpu6Xgo8X6A64RKM8(wIM89qD4nn6BL4TNW8HUPVBqAEvDzQvT6yhqDW8Q2S3I3QR)EbdvTOv7)Pxn9hBRJQtb5QDhrenuS0QdYYbmx3GOWXxcYOHdrMmsHqPtgjAbfTkbgPFyKJCGvi73415683BOSFp1LQ315DBexNQ5KI9TsoPw9fnXq83MalZ0aWZnVB0Zb8SI1NIAVxVuuNYQ7hj5usDvSTdxXzkomWRV(pKpmIgrr)pAef9BVV1SEg7A1u)xSQcg(33CLAmdZZ1Fmj1rsgUoLQVBd0P)ZgrN(gdSw1Ph4ngyZPpXAvT6Cjr7jDsC24h6O1PwhUo1AlYxDFFOt93pSF43HrdF3WYuBjZ)7sPqDFnQbnDjqXKgMii)tPOJAF2jTDnFJoTFnF4nTx3xtt7xNprM2VMV7L2x2hZY(BpOK3jOG3vnXkcoQEXaoi7Dwg0QcdFhES(2bn01M(Kb5PoBhCAJcbLn0FaNGSx5EWPPobXKGMoOc)Oq6aHyZYZzI9Dny(a1ofd(35Wf4V0IXDxzJxlkidl29nlKYAoCIuKcjgsQToN88KkHtE67OL8Ti3ITqNDCKooClf3Wt()o
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
- Debuffs from other priests don't count (in Forever, Shadow Weaving only
  helps the priest who applied it).

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
