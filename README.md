# Forever Auras

Aura packs for **[ForeverAuras](https://www.curseforge.com/wow/addons/foreverauras)**,
the WoW Forever version of WeakAuras. Made for the Short Royalty guild, usable
by anyone.

> **Status: not tested in game yet.** The pack imports in the right format and
> passes our checks against ForeverAuras' rules, but nobody has tried it in a
> real fight. Please report what you see (see [Testing](#testing-in-game)).

## Shadow Priest (v1.0.0)

![Layout](docs/layout.png)

**What it shows**, built on the
[WarcraftTavern Forever shadow priest guide](https://www.warcrafttavern.com/forever/guides/shadow-priest/)'s
priority:

| Row | Icons | How it behaves |
|---|---|---|
| **Reminders** (top) | Shadowform, Inner Fire, Power Word: Fortitude | Shown only while the buff is **missing**. Any Fortitude counts (yours or another priest's, single or Prayer). |
| **Rotation** (middle, big) | Shadow Word: Pain, Devouring Plague, Mind Blast, Shadow Word: Death, Vampiric Embrace, Shadow Weaving | **DoTs** (Pain, Plague, Embrace): bright with a timer while **your** debuff is on the target, grey while it's missing. **Mind Blast / Shadow Word: Death:** grey with a countdown while cooling down. **Shadow Weaving:** stacks on the target (anyone's counts). Hidden while you have no target. |
| **Cooldowns** (bottom, small) | Silence, Psychic Scream, Fade, Inner Focus | Shown only while cooling down, so the row is empty when everything is ready. |

- **Priests only**, and every icon stays hidden until you know the spell (so
  it works while levelling: Shadow Word: Death appears at 32, Shadowform when
  you take the talent). Any rank of a spell counts.
- It sits just below the middle of your screen. Move it with `/fa`
  (unlock and drag the group named **Short Royalty | Shadow Priest**).

### How to import

1. Install **ForeverAuras** (CurseForge app or curseforge.com), then log in.
2. Out of combat, type `/fa` and press **Import**.
3. Copy the whole text below (the copy button is at the box's top right) and
   paste it into the import window. Press **Import**.
4. Updating later: paste the new version the same way and choose **Update**
   (not "Import as copy").

<!-- pack:ShadowPriest start (written by tools/build.lua) -->
```text
!WA:2!DN1wWTr1zyuustIkTXXbstsbYssWehmgBhBN7uKCKSvW2YzLStCaQ1r7EK21E1UNSxKTCHsJ7T0wkT4sVaL2sf070x0Wa0o8KhMotBzA)hn8yFkp03BM(wFP)NDxjl7etKCOaPzMiVNR7)(9)9)9FUeyIwLE5wU8(njs2Qg6w9NjRQUQLsOi4FSdjAztmX)q0ykKGxLOlPyygZKKNMQiJMj5aIrJoAzVQhZqv3oZarhnvuXfj6Q5j8zSFydXQi7y6wykBCuMwujdDzRLOelAsBtQEoBLnVaVeFsJOBOtJW7iSTi5jQ6XGpjC7WNAZWNg2g0c()nU6AYqCSrdOss8hBbrJIen7Iv8QmbZ97kuLmePzKnnydyOzyEMa4)YKXWuMAQCfV)gXVdSwIOPo)8etzHuggA2QSYEDO2idwYRIOY5OSTN8IoetQqmhnnHZPOAt97ECDlQDWL8kKiBwS0w9hys15PBQehfu9SUm4ZzvZfI1k(GTPHMgvEafvnzeDMMDYv8Hj8KcjviYgZkmMPk1YgllAy7IVl305W3ZXfgdHp2jAIrFAAbdhtv9CcJPrY5qz91edEevDzHiAelB2PwVw8PPeBLMYKNGKNPAQkjenFgKftzhBD8UPKc4hD5SCMnsjj2KG7tvMDWgDQkRQN1W0NXxgFuIgTav32sPCotdhMN7xHTl1C6gMuFsPBxIAAAyAPCvm4HAQt0MadqWgFZiAge52eLq80QnX8oirmugl0k1OzgtmE0KPw0XIoLB7PZWqkOUn7UFFn4sM0C4uZJYeDnlrljIgn4IwuTSUHVWwZyrZxGAk2DND1zxLSCYi6ogRqLSnKk4zBB5HV0c2MQ5YHfhTnt)hJjs5FpLgOgTgAjIdQIadKHPrksnVc3GjAZskAzB6qtVOJU)ydX2oxaQanLx5rmKPbllRAnTJUB99q006XrvUSrswwDJWHp2fjM(MtqZ58W3aMf9F4YDabqLNqqWqWgdvMipTJLnvEeYCBy5cQ6Ba2uq4taBg2cSviexQA1AnB)gR(aTc7aUJqSDKXx2imQ2DAvl(3C)l5PRM0Wbv8uwipzU4yeUvWkwkOht2VBPfLC1wcI)d27EAZusHONJADO2wGHksut7ILKPweBUokvSardrV2GZbBcMCSn2vN92NOKcvAM(HhjimzGfkqmvjz0OlLLWnMWUqiieAbjuqd5d6PxQ6tCnmLkvlLCwvgnn7oQwofDoB0g5ZLCA48kWbdMrHQMtXEYiQ4hs6s8FXVoKWFx3ggYa7dou)WdOaDOapOc05BIIjC3en9vNHszHTyujBrECIc8qtaD1g0DiOh4WLWg00MrhFNV3bGErtGZvOZHW3ul3KIldA5YPH(G2Vccr5mPwwEMXHURBBdWrGmWXcchhDRNaojCQdTtOLkizMNeGZ81LV8UQ4L268(ug)It6xCjVItX8clkzYJ0PC8iYOjgnkBh24JtH5ym4r9sNtv2wjsySyj3gw2FEv3YzvNJk72PlTOxfOopRLyMQZlCwhImxYrivQk1AJNIyVlxKhZAMy8udhF0Ol5wlNeRMTiS1R4wSwiCKWJNkbRfVkDJ(xoVfR16QU6h(kQS6NVNrY)zF3hJT7ALMYtMBkM)dI2Q5PYS2VoDG3YuYf1j5vLMYwb9qkiPAZS7zT6RxPaS7DT6aZKkPYJ4dCDSil)hGT5HpfWEI020Ey4Sy2LZzsylCo)hGwmr(aVn4Hr9m4Z9STbpYFI1cbJxej6ZKKtYIFAR98EhyjEDPWClZGQVz0j8Gj36CjIQYO2OmnJt2SUoPHclosSXhgcNzikkcRuXBaXu1q9DRDMzSHdpzuX0lHRcYKAJ61ZMqVecnZg2vyKDNEnmUfTEZinB71QVADkqlL8QKhKJQS4A1YrTVkgJeLh441pzfiwiyWGWqq8R419yOykpsa1Uot5X7RWGZn(zhovHXzTIdDa)qFucgJtPPHHdkolN4ojmYZSzy0arM3Wipx1P7JUszwiXgGX(GusfoB)GOcKmiKknmEn1ryIdX1(opm5k1aHl4R)bpg84OAh8ePHpVcmvAiTV2fqMeYKgK8KQ2)QKQauIJUszji7gFluncYPakUInG6AQVatF5DbZea0ca5X61bdGbxe8v1TUeydoqH9cZcZbyylmp8fGN0nSeEQaWxma80yOg8LGlblSz4lha(kbGVkcfFT0WxhUmo9FJ6jQW3CpOL9TGNb(2HGNf(oqy47cp3oHftdFp45HVFA4hG0d4hcda)i4fQJcaVORxps0y56jI98jpQo8sCFm8t4(3nI(x4N67CFG)36CR3HUNQo0Q(WGWJvYqVkxCLotLRNZ8axJZu5ADMBzVVuJ4n3JR30hUhfH7)jeMT7QgdUykV8nch0ncR9k5O6uCfOEXYWZVORUWO4sjX3NOnx4aEcOfr3QrhYPz7yvj349vHTDETRyU8td6TOr3x2J6Mg0nq1VAdm9QPQmvPSBUrCC5KKvUADf4ICkvQL5K)Ys7U2rxtlDDCJZuoHXyt4KOx1EhxQEErGpgXlGxUbOd3xJqh21o(p)41lFa(5qjmq7vCNJxL7FHFb33c)sf4xLg(1kWVrb(TkWVtbET0WVFLOC(id1DU822doqX6q5URhKVLwzTTgrzDlN4n(4Q0k30w)ARDj21Xm668ND6ji15DFU)VX7E)nM39fAoVBh3gOTjiF5ijsLkXiIXhCOuRLJE)VVoARMYr)IxJJouJ5LhQNbIm0qYsp6zluNx(FTMEzrIgkyJ28Y(ztVtjdXUBwh(D6EGwWovGpdSly3EiYEGplCxbH7ERW9SPssu(5lWxH6(gwe2BiUF(Epd7W3Ot4OAwplEBQAuDjk74nZGgZQOKIQKqsCLNK8SUAMXgJitzhPzgrCDm9PqmdjhlK3gb3R3SLgkHy8lKy0uHhMFMoT3Wt3QO5IAQ5vT3n8qTvhpVxo5UF4il5Vrh3JvPogEel8LbBdZ9tKOB10YMWpEJaWPcvx6KyiXlc6ohWnbs0vMRy2C20UM1A4bBFMfWK2dZncfoDBemP8)ydFyLno0AK0nADcdVrdTgSt(01lm82nzo3Ry5UYOARm8v4ZxZM)T7bppvTBhRJW6UASBux88d9f50iW6B2ylT9pEZaRW7GijofnlsoyoQwpdA3RML6Tai5B1ii5REGBwGeNHMfhLoOLECPuogjN9waC8p0qmYJ9ZUPzK4u0SiPXOr6jPH2mfuU4AHK7Ffi5hGy4nmnC1eVhN9W3WRwGMxvxMAAvRn(5BjKx1IFjan349ZkQAsRn(t1mJpg2vvBh5AdhzenuU0AtYQjmx3KOWrxbZOHtrQ0T0qjvsf36m9vnXi9JILyhAnw8C86cD(Zn0INp5fRp05DBKqNAlPfhB1L0Aou0HhZ9Wi9xyBfVSNJ47fRFrUN(6Ti3d3xFdEKd31rNFWPRgmfhg512WhX7LPra6)sJa0VZbw34mo0A7C4VT8oh(73yqT9EmsD42VGXfMovDGAGBbW0)AJGPV(iRxm9qV(iBj1XxVW6fs4qnVG4idmXO1bRJxhS2Q8LpWh9s)4EHFB4DJitTKy)7vkG6Dhmcmp5tCldZi4EpSDU8DwFWR5c(74AU1(oQ7Q4746C)6DCnxAEhR6MWBVdbPA7QIGZLVU)dYVMdbZQQ6D6R0BjyORv8ecUNVOLqrdhbzd973wGFlDcfP2c4gFkkOOklt17ePvl6Upj(vHYU)48nMMfnIh39QrFC3Z5Ckp7zQLZ8X5F9FJsJSUtHeVRyY9g)mztn84vtH8m3ER5BvUvlXU7S3opCRf24t9F)d
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

Not tested yet. When you try it, please check and report:

1. The import works with no red error in `/fa`.
2. **Out of combat**, with a target dummy or mob targeted: Pain, Plague and
   Embrace are grey before you cast them, bright with a timer after.
3. **In combat**: the same, and the timers keep counting.
4. Mind Blast and Shadow Word: Death go grey with a countdown after casting.
5. Silence, Psychic Scream, Fade and Inner Focus appear under the row only
   while cooling down.
6. Shadow Weaving shows the stack count (1–5) on the target.
7. Remove Inner Fire (right-click it): the reminder appears. Same for
   Shadowform and Fortitude.
8. On a priest that doesn't know a spell yet, its icon stays hidden.
9. On a non-priest, nothing shows.

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
