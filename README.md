# Forever Auras

Aura packs for **[ForeverAuras](https://www.curseforge.com/wow/addons/foreverauras)**,
the WoW Forever version of WeakAuras.

> **Status:** v1.0.0 imported and "works fine" in game (first report,
> 17 Nov 2026). **Everything added since (cast bar, procs, mana bar, glows,
> borders, tick marks, race spells, shield, execute frame, clickable
> reminders) is not tested in game yet.** Please report what you see (see
> [Testing](#testing-in-game)).

## Shadow Priest (v1.4.1)

![Layout](docs/layout.png)

**What it shows**, built on the
[WarcraftTavern Forever shadow priest guide](https://www.warcrafttavern.com/forever/guides/shadow-priest/)'s
priority and [Blizzard's Forever priest class deep dive](https://news.blizzard.com/en-us/article/24301514/world-of-warcraft-forever-class-deep-dives-priest-and-warrior):

| Row | Icons | How it behaves |
|---|---|---|
| **Reminders** (top) | Shadowform, Inner Fire, Power Word: Fortitude, Divine Spirit, your race's self-buff (Undead Touch of Weakness, Troll Shadowguard) | Shown only while the buff is **missing**. **Out of combat, click one to cast it on yourself** (Shadowform uses `/cast !Shadowform`, so it can never switch you out). In combat they hide (the game doesn't let addons change clickable things mid-fight), except a non-clickable Shadowform warning. Any Fortitude / Spirit counts (yours or another priest's, single or Prayer). |
| **Procs** (left, 2 × 2) | Spirit Tap, Inner Focus, Elune's Light, Elune's Grace | Shown only while up, with a gold glow. Spirit Tap (after a kill) is great while levelling. Elune's Light (Night Elf racial: +10% crit) and Elune's Grace only for Night Elves. |
| **Shield** (right) | Power Word: Shield, Weakened Soul | Your shield with its timer (anyone's shield counts), and under it Weakened Soul (15 s, red border): you can't be shielded again until it ends. Only **your own** Weakened Soul shows (see the limits below). |
| **Rotation** (middle, big) | Shadow Word: Pain, Devouring Plague, Mind Blast, Shadow Word: Death, Vampiric Embrace, Shadow Weaving | **DoTs** (Pain, Plague, Embrace): timer while **your** debuff is on the target; **gold glow** in its last 3 seconds; **grey with a red border** while missing. **Mind Blast / Shadow Word: Death:** grey with a countdown while cooling down, **purple glow** when ready during a fight. **Red frame round Shadow Word: Death** when it's ready and your target is **below 20% health** (the execute window; Early Demise's threshold). **Shadow Weaving:** your stacks on the target, the number turns **gold at 5**. The whole row is hidden while you have no target. |
| **Cast bar** (under the rotation, wider than it) | Whatever you're casting or channelling | Shown only while casting: spell name on the left, time left on the right. While **channelling**, two lines mark Mind Flay's ticks (3 ticks, each hits harder in Forever: don't cut it short). |
| **Mana bar** | Your mana | Thin bar: your mana on the left, shortened by the game (4,300 shows as **4.3K**), the percentage on the right. |
| **Cooldowns** (bottom, small) | Silence, Psychic Scream, Fade, Inner Focus, Vampiric Embrace, plus your race's priest spells | Shown only while cooling down, so the row is empty when everything is ready. Race spells: Human Feedback / Divine Grace, Dwarf Desperate Prayer / Chastise, Night Elf Starshards / Elune's Grace / Elune's Light, Gnome Confounding Flash / Contingency Plan, Undead Dark Sacrifice. Only yours show. |

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
!WA:2!T3xdWTXX19ByiflJKglr5pLDIptlrdQqrlc(TKLvaabeHeiifaOeLIDaoC3cCN5H7oD3b(vItQz)3w)V1jTHPTP5J24Wg30mt6xSEsCJ7xHtsAAt)4v20w2VsBvNjJNPnZKQPnTjPF92DpqaqrkcqtglMsodbUDVD3B33737929TVBHNl0K0Z32Z(WwIsoQg629KlVQUQTIVq4xo(sA7iAHFjQzQi69AI6skgwrTelsspTjjxQWjJejXc8ShXqv3jx4ijshj5CI6QffPTypWTgDj5swSezCWAzztKm0LTxKiAts5yr0l4OCBZstrB0q6g6Kq0cc3rOIIQ6rHxp8gGVVBdEJWDa7h)FpRoNCILCWoWsrnSitqSecIpo7L4zoSjBC5BPCIsJlBzyg2qZW6SEW)YLZWsMyPCv(3HClG5(dPPoZmIwYcPnm0CunxGxGvQP355zerUaX8aPUsjrlIq0sAAcxur1H4w8y62ehVlYtmC(8yQB3TIPuNHS35PubvEVlhEDE1c(mBcVWXYqtJihwrvtgPoN1mqndmH3PqkfrzJjfgXsLy7GPhXYqILVPQLQJqArtZoR36etxhlvudPs2MDxVvkIwjDYJylexTGItJxTZGWnYc5P4ieai6i6TzvzZJuxnZcQ65nSCbxlGxkrImbr3XwzHcwgLm5uAfZ7vTGo2EU8FwrIyzzyzRCneNsS0f1UaIfXB(zcPzik3ssjnrB7wswSeYZ9LZwvVGgj3ijJfjv65kztYWUF2CMi3w3X8nDd7TZBrkGnnfqNK1TsAljQr8oNnrlptsbU9C2KIydKSJ27Q9oM3UuUKS6y7BEhdPj49T994pZSowQfkGjt0IL7LrtsOJN5dVccc2FOsOalemNPM40eRRs7WIAtkoTTJvjs25kP7wxFMhGkRpbjnp9qgYeVliRA)uL0z5hqutlqjv5fIhjEx9fFSo7Z00YT741Ako99t5ZAA(vEE22apOuUpWRpyp(wqu(Pkz7qKhsCQBTscv9Bf2Rx41b3gSp42bFu1cRwU(aBSKo0eCq4o9zEWCUIOuI)aQ20bDplY1HLYOeQDrz2IItfdLMS9UKTcYYKDlw2Ksm5yV4FWd6de8nRekMJSo9Slw(kQKTYsLtLAsvtswZ7SC60KPCWwtmhkLMDEzITOdvbhrbAXBofcvMiwiv8zNDE6NyhcbPpWTGyCOzWFpqRkWrvG3Ic02NXsvNsAjzV24eIzqBtIKtsk2wbo2fG2BbEuFWXbeDys00gxhF477K)8qaSZqzWKPWHCMk3tHX2RKol0j8ix10YOGfX2M3po6dCl3k0nCzOxVqFiROF4eWjp7Dd7FjebsvssHR6Y5DvCLrAfTEU61YqqIdC)l5MYGJckFtBu1MxxnQzMq1wfjszH9phTXzz(1cvqZyYSZt)mexb8C0R5Ax9oYEoE79fG(zND7Dr6ngW14H3LOPIArUsjIU000IeOBwZeNzc5UyntCvDI9byxMIjXXQvAfvPXXByV3zzjPILJOofrBbAYXCrYSexYnbSFlSptZzrKOEMY9WSp79Ue3Ex5A5MSC9wKNmJjxiFEldheAqHmHsmCIiMh0bVmdACYGQdt6IQYokHcIjNNDJkGZRXsNh7LYSc9mZXZanqyU)OwQZiC(sIYuTNcPtV0k3JAB5bRKKouTgE00XJLiYISCPsKQ5NgU9RYsUIcPqbhn9WM7NNjtxwfdEMnvv2Lh41Kz5HpVts)O5JyAEFRKkdxPDgt3ls6OwKiB26Aua6DYipTUyrvPmoki0vbL7UnZ386vwEkpMp06vatlIKkv)LN1Ohz7EbChC6tzqlNgojcrVOLO5Sx09coUGEp4XqTZWPEVTap(x0C)IimnPO(4POsFXgW(q77KFIfPzMgn2noAmjNUiv9klpMiQQmQQxMKRu(8mU0GrIps0rJdNo3GernhLL4viQQgAUY23I48MSioPumMCy9fTzFfKPX28U43AuBs19GSMhyL8lNNcS)55zs1CcbHqxdr3rO6r4frwbgWheXlefoZv5LmkAqGQyav)o4c56UR(JKlwxDpZmMnHvnSRor0mcQ3cf1pR3KtsHRXGZ5bI7j0mggfPYQhVVAnuadDRqITsJcWW9aJOaN3lKmlKQk97q6SWOkWfYcxmlmgvjnCPyWLZcVnUo5hEv6KHNil8K1Q)fE77R)pkQ2fYOazzAvbX1ur6jqfPqU8G0R0bid3pq8a59cfqnGGYxduZcpLcm(R0jO5fkY1Gb63fyCaW0lCL9cwGnGQEkHAFGjGjZwned(ahI2j(PHpi8H8bFy4JaNg(zGFwFWhfEE4JLfMh5TWphLLcF8QyIWlW4Bd0vXU7zGopNS1eWNGYLGFboh6tDRWN8MB(ZHRh(Z9EW(VN6HbD2Twg0ZEVWuEGP9aZGpG3b8oHNgExW7Mp4((Fg4zGzHFGhe()b)GWpewGFy4zH))mfQWpIh4h1d8COss49aVx4h72GFCpW7ZdmhsVE)zHFc4NeFc)uRI)ZgKBsaqrJJpLwXX06E0Zvfaa5(X9CZoa4i1da4fFHVNN9JdXnjZpqxZiPfiuxK02RI5xL4)dxd3FlKVFxSLBd3TcCpW9c3hNcCiK6)aEH30TdV596cdEOzmFSnAnGjPtNcTKx5wudZNqyervDZt2a1EaYe48Hr7YcJOjwOezJxfBvvgxpJSqiC9GoMNAZ2JhGiIltnYRQQlqMIivYH0qJ8liwK6NajHifZrxiUz)BI(arCcK2HIQ0vU7VEBGvliFSwQseoavWTluKTNAez95kfKaLcIIO(3kcTcYa6HZwfqFWfg9SXV8KJkDzf7rPiC20pETqL2rBXssruVaX(eTmlU4lCQDotdJLCcrnCL4TaFgyVWlnI3J3E341MnHZMS9aTx9QTGx6SSLb1nTqS1c1r3EtkPqKgVh4X9cVKNzNq0sLU(ZfZlsP585b2c8Ppe2Kuxj0ENTtx6c8szHpB0MnmB6XyvSPoHx(A8QKKqDUgLhU2kGVuvkG)fRhfWFLdxTc4xCZPawHPaEvldCRuB8r2Y0gJJ3YAJTgmyYHytDNQt(UZns8GxkcIi(OZtNMEqMByQwjDohrRceN1stTXydLFCdLlw8mHlRP(sW5EUB71yZ0hfXwNGcDhdHuRccd)6Wl9kFj4Z6InHxg(nCrIWV5AbaHFR6aY9lvpqU98sBzqUxz5Borz4qCfB()2U4l43bHwWNRgZ(lUwGPEJxCIC92k5S6rRgmTNQbtVLTxWu1aOdvgavgR4fE55n0lVeYAbnTKJPWZ(OvGvFb8Yh4wyvBwvDjJI5WvT)YbcMyGAbukRfG6x(6aukRXQ8EWps9GOorDPeJsG7LPdR7aE92Gl57TJ8)VgCAZ7Rm1H69BMB8e8ZwPERlvGOtqZ4ChcaFU5yoviHyrcoks6q96aKg2Fsw2u7LMhCv(mKwwfZdqZTM2Y17IChOZEyNJ5Dr2c(DZ2an3BPktuwG5YrSEfKKvUwvjOUirzPvCij9HLL5hDwxJA6MBq38ohvx1riSIiDtOWEHTJQKTRr(fNLwdQRTR1wVAGPmUIApt1vFLQgz75MiKn8fwfGg(IRnwg(DX))s1be(xPEGW37b)oF4Tmm83WZJU5WTWVh87JAO(YSEZFafhc)HS5S9hPa)Xzbqb(tuGLuG)uf4RKf(ZQGgG)8YCE4VOwwEkjd5IP0NAObpFvS8oQMJF4AxbJNTkE9C4mT0LP7usYqXJGQBsXeU7VB2CZ4Zqlacfouzo(EPm2QT71k8YlHZduIO7OWCUhLDtzX3gCjcL3(REDtnE95Q5kQs3jlfg3TBlQGwjlsoUNMvM1YDY2Ew10O)QMhkgDNVYJZ5)jcvYXXq3(jU4GXshPVX67AUTc1fN0bQ5DgoEWHgj9WHIhm85coWaXsh7crQIjhLzmQgEvfw)cC3tMKikpDdbcQWUJQuymsuPexzM(z8AcNx))jM8Zc1Lhjp5N(75N9dDmU5N(tPlpyXGLgysrr7Q0y8(2rovAZ9ZxvxLnjcxL4QwMedR18JFkoyRB4LnBYD5HMMAQsI8DkEJHF)A1h87d(Q1mdfl12TatVxyMfcnC60dpuYyNzW0BoyLDdbR(qVkGv5ICEj7CdMy4ajQcw9VunS61ExPD0n2LqPuujAY04QWysSyC3kXZ0SN6UYxKiooo5rzHugL0C9hul1xT3w9g0u9Qoq0P6tzgJqmVb9X99AK1J6Xd3)t1Je3dxT82xFtkV9DpVv)WBwNvFH8D403fc60Fc9A3QQB63OI)5Tb24x61q243e(a(wpfLp)c8DhonoBtTM7OBZdwv6HX56k6yy10PGpMcYUV6kBen72zVrS)E6x(Is94eTRCK1DNk7FBL)FTkHbdpeiyp1UyF2j7ZE5(ND2CIwvkr39rnJ3f9J(9ox5BfOA8ZykxLOt9B7zSeLvPlgaXqMhSGBQHTOFYStp)GdNm2Lhor6GXHlDm4YkumglCIQkerMJL2gxgoUSKOPRlxXhwe)c7CRXAjxL(3fmQ0DGVftBSly1Igdd02OcKnPTPO14zVk7RqLxUuaCHdZZYk8kD6fyPhKfMuxYnHQSmrpzIixisYfz5WJMKX8uDQl5zjwQYBMGhZdutA6deEwEnsZxnJP)kR4HoWv1les06jgn2XQK6yPOvG3lzbAZbGtEzM4NBqrLhPOC0WeUH6AgrlIyakby9uZ(6zYNZhlrIijZq5nRNG69Fdfu1VrcQ0NZtClSh0c8h0nC6t3F9OsWd7j5D1Qe(QZwoMyxYDDI8Gjlq8udvLb5laNoeLWo)kE8X23k2Nx1Y59huSGQ)PNO)lgKjJpWHyc5)n7b(KEw9c5360S)xb)1Cn6mNZ19kILqlVEumJka9O1RaKGJQ04cDSrtI5VvXDEmFv4Vtb(7VUfLd)dWvH)XQiItmRe(eyreeDBK0jAWPx2ZDVSN7zfA5ISWr1TuzxnLTNObcpzpJFXXVIkJYUx4CA7Hsz3brwdS1twx2ZHw2Z9FD0YL98axhfSxkfSxkf0Smf89WiGp6278o(xxxlnW)2z5loFf3j)nR1Uc8VZMoY)bQO(spKR5c4BZlZ3b(pRltddjQlwFMgG)7Ania)pvr)x2ZTOuLk0L98grA)DSSN9V2AlVpyQBNPeBzphy90DDp3yDxMhEnI8VCQfYOxQyoILBEMhiyUCifqv0HKGDdCnJZfsTapX6QM9(HPIFlU9WM2m9WRDexx)zsxO1rosnk1nF0RVVxvPZitKulkQvDmmE4BCn45LJpQm9FJlmZUg79YizEnddRRtZ)YEo4YEUZL9CxvjlLhoDs2IgNJ1i0A7PS8eZJ)RK91jADLKANVJRmqFrMWUA1(T96OQ9RzA9jf1ulOJe0kcyw8xReIY2)6ONNsIiwufSnhpz5vv)T343RIY7xd7EQ4eHKiMNOrQ0i2tlPOkjKcNXSyrZJ3i1nQOmXS3gPgv)6F8ynsfVUOiPRgQJsiY0zzB2xJuRbuNqvNWF9rASE7aeB2ssi4TPVFenwVnScD2I2Kn2Ti1W9DeTOV6bY2BCe2uD9Q5TKzJJVOA6Og65Pc00WAkQMOTsJrLWQtNumn86PrfLEJbChaNaTqkrjl18Q1tufTwJz2lueAileoH7jHVf1SvR1D7Sk7wj1ulQ6CFRTBLw0naZzVCovz8kKTHLdCh0LZirUDlBhr6ljJNgWXtbsFU(pEaXbJD2W0nVmoTtOuoGKEG99DRTL036SHIrQ4VIL90rDTP4p27UkxwSSNGRJplo6nW1tvr8C3IORY3IOYmp4ltFmn6MenXWNr68t8uw6xrPSVcISkxfDZe5oq9fdcF2TbY9YEIHKySPBusSyK8Z0Jy)5cQgyNajUZ6He)Xp82ffgB5gLahRJH6mqSifhSpYobcCx1fgUM3wITwmm20nkjE0rhj9LgnuVbMo2obsC31fjUMT)DRLeJnDJsId)utnSs4sNlHZ52jqI7PUiX9m42gjgB6gLe35GHsKOZKLKtjVtGe3B9fTsp92M1owB3Oe5lBpMr0lpqi9iJTtGi3x9HJtV9HJt34g8MP1Z3AmLl1AxI7eiX9xN443)2io(93We5cI9flxHcZKY5s7eiYNOUWXh9yBB4ySPBusSL)XoBpwDDMsDSJqvXjRhsCnVfDBPuySLBucSYvSg0VI0OJ3z0Dce4hR(uu8UUJTpffyB3Oe5GPspfj4KAXsezNar(u1jr(U3gjY3DdtK9htm459RlD2K7iwe9JxNM8EUTrtEpxdtKhyQu9hBGrMEYr3rOp(01hrUMxR9TyIm22nmroEYa(hy6CT216sKVz49i(X3W3ivsrvDzIvL7r3DmHIQ20d(jZZ(QR(c(v1f4VGsT2y9f39Jr1ISsF5uns9XY6O6usUs1d2iv3DhwCpiXk3erAKMiTrjjfbJ8SidLEM7SsZC6gNOwOe9CyZTbCJU0wR7MzBnatteUuW0jchPKIwzV7tQSdMTKtQKTJrXP27DQzijQjWpqWeoLan2PYq0NODEo(43UOOKLrBc0G6i2aTjqpuyInGnw8MFuAEcp0rSBUnHo6URE7SnH3b)cHN2TY5zhDxyRBArSj6o(B1NGaIhfY0MGQSaIfvnfvTS972STkiBGLqqGxDDXIe8jfod7D9Q9Zq4Nfm043XVQCRSsQMNxmhfIoldbHJDmHHl5q50CKUGHU20TjyBqleoETlP5iOAJxjktJ5T2f8hwKEY2jiJWBjhTPpHGlRKXjR0S5W(1424OXWblhwbSxQzthhCIk(aLjT3QBfWUw4m03HmwRq7(StfmrhXqtxzG0m)GrdjI0XrBcn7EC70CRSXe2lDkzPlqpT0ei6YS2M)n)t37NxuZM4JM1Qi9LmLfDimkp2HIPhMrtIJde62B4V2NcVj5Tqo2BIds)54H2ZlMKDMaXBiDdNYLyfs)k1imsADiSZJr)nZFJEOJpvT2CBmCyMIivYIeK1j5fjnPislCin3AvT2jsHKnnn2jbLTFETR5(0dNoBhIfYXcRPISh)nhuF6rnXhi9IbWbPBdUQXb2p5nXkKs(4MfJyRhSJlh4sm5LCvdFwh2XXsftIJEAWgq7km5ORFKvPGScWoFQAJl0DcEyr4N9uAT1v6LvQn9TIu3pLtSI8vRvbbMu0rsbvhDDCWl6EduqSgof7lSpUof)uLBrFUFFIr1TCP(ilIFAhIaTY3TmNHDd)nZF5ZZKmYzIKitKebdfpYanVrLMDQDglXzYCXHtgFTkov(YTkJMiw6mbhnzqk92vQQsfO0ljlvtSGdRZQbwmUWrR(wrizozJmCz5S3mfb3l75sRtiCNV2De9kO5J5zrHhtmxPYe0YUrtqRQxDWU729WDy9MY2kVWk4dCnIM(L47H6qUMh3WiRFkREoxIPKcmH)oRk0QJV3B(dT(L9C56NXSShs2gGH8n2ZtUjP)l7j)gt074PuZ1thbjJmw(nMO3YYEYn1EVJTKPmWMXq391hD(c4x7oBHDNTWUZwy3zlSdC2cl7r(MSPj82QhRrF(dZngPS1Am6ZF4nTTOOgMJD2OsQxirOn(qaKBlQ5TeBrVT3kN1)KCRsDeOl(YyzFhOJU7jWUMN2180UMN2180UMN2cmp9e1J5PxCOTdZth9fhAFPpXM2cLZvYzpPt8Zh74DVHV83CduhEBXavx92DaMfk(fb6TN(6yxtu7AIAxtu7AIAxtuBbMOEY6YFE9)8Bl2OW2DFAp0M2ivNfZ1BUofde7mjQYi1O3aJuhyRZJEb6HBzI(9UwK21I0UwK21I0UwK2cSi92RlF69cBp(07f20gJcyMk4ybs5CCS3xXy0N8gym6GBDgJ6OVo6Sx26KOxSR5ODnhTR5ODnhTR5OTaZrzQRfif9VCBXEeTD30gKMPvXcbotejZWRJbPMK3(okQQ7Ge(dbpc8IWxh(Vw2Z9TSN38YEew2tqK6fsMylnLNNV2OmL)RCikVXIXutr6r)f93T12R8JJJ)R7hKO2UUFLHARQF6GABT(b9zsv8dr9Y)W(iW(rYTTR70wPTv9dXtRTrnojz32ACyUInNCThtRCR6StBl2ZJ1NIIcoSdFlBQEi(jbfwWvoKo8Zk604WrG2dEeBUAq02nT9Ddr3JXuWATsC8IfhFwOzsQgAbhd8wSsyuTD62DdDxBMb7t62US6kBO)ioc0FmtfMM4iy7G9rf2Pfy7OeZCStVd6VYRMpsLd6p2V6Rpbt1DgovktLi0MEmD21gfxWB6ycwkCP4Ji5VJjVSy5yc(5EdnvSj5MSz)m)2zttSNN()n
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
- **Shadow Word: Death can't predict an exact kill.** In combat the game only
  gives addons your target's health as a **percentage**, and the same % means
  very different health on a small mob and an elite. The red frame marks the
  execute window (below 20%); change the number in `/fa` (the display named
  "Shadow Word: Death execute", Conditions tab) if you like.
- **Weakened Soul:** debuffs on you can't be recognised by name in combat, so
  the pack looks for "a debuff you cast on yourself lasting exactly 15
  seconds". A Weakened Soul from **another** priest's shield doesn't show.
- **Clickable reminders work out of combat only.** ForeverAuras marks them
  with a yellow "Secure frame detected" note in `/fa`: that's expected.
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
   - the mana bar fills and shows your mana (e.g. 4.3K) and a percentage,
     also in combat;
   - with no target, the whole rotation row is hidden (Mind Blast and
     Shadow Word: Death too, since v1.3.1);
   - a DoT glows gold in its last 3 seconds; a missing DoT has a red border;
   - Mind Blast / Shadow Word: Death glow purple when ready, only in a fight;
   - the Shadow Weaving number turns gold at 5;
   - Spirit Tap (after a kill) and Inner Focus (after using it) show on the
     left with a gold glow;
   - Vampiric Embrace and your race's spells show in the cooldown row while
     cooling down.
4. **v1.4.0, please check:**
   - click a missing-buff reminder out of combat: it casts the buff on you and
     disappears; clicking where a reminder isn't does nothing;
   - in combat, reminders are gone except Shadowform's (if you leave the form);
   - Power Word: Shield shows with a timer, Weakened Soul under it;
   - the red frame round Shadow Word: Death appears below 20% target health,
     only while it's ready, also in combat;
   - Night Elf: Elune's Light and Elune's Grace show on the left while active.
5. **Out of combat**, with a target dummy or mob targeted: Pain, Plague and
   Embrace are grey before you cast them, bright with a timer after.
6. **In combat**: the same, and the timers keep counting.
7. Mind Blast and Shadow Word: Death go grey with a countdown after casting.
8. Silence, Psychic Scream, Fade and Inner Focus appear under the row only
   while cooling down.
9. Shadow Weaving shows the stack count (1–5) on the target.
10. Remove Inner Fire (right-click it): the reminder appears. Same for
   Shadowform and Fortitude.
11. On a priest that doesn't know a spell yet, its icon stays hidden.
12. On a non-priest, nothing shows.

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
