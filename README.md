# Forever Auras

Aura packs for **[ForeverAuras](https://www.curseforge.com/wow/addons/foreverauras)**,
the WoW Forever version of WeakAuras.

> **Status:** v1.0.0 imported and "works fine" in game (first report,
> 17 Nov 2026). **Everything added since (cast bar, procs, mana bar, glows,
> borders, tick marks, race spells, shield, execute frame, clickable
> reminders) is not tested in game yet.** Please report what you see (see
> [Testing](#testing-in-game)).

## Shadow Priest (v1.5.0)

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
- **The game's own cast bar is hidden** while the pack is loaded (the game
  has no setting for it). To bring it back: `/fa`, select the display
  **Cast bar**, **Custom Options** tab, untick **Hide the game's cast bar**.
  Removing the pack also brings it back after a `/reload`.

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
!WA:2!T31EWTXX5DFgsXsWP1su2o2YoXNPLOavOOfbFlBzf8KeuGGuGGsukoH4WDlWDMhU70Dh4lhNuZ(YT1jTHPTP5rBCyJBsMj9fRNe34(kCsstB6JVYM2I(kTvDMmEM2mtQMoz608p9B37Wl(qeGImwkLCgcC7E7U33(99TF)29B)UfCxSjXxQTx4XmfeTv01S6jtwfnflzVbXVS9M0YwWe)sq1qwWZ1f0eL1nJAkKNKAodsMXcLmsKel7K9O6kA2zcfjrQijxuqtjVaTf7bUZORkvWKLysBSwMwerDnjRvicwKXSnjA5SLVRfOPOnAqnDnsqAbH7jyEbfTOWDdVz4h6UGFy4EGdH)VV1MtgHc2ibSAuDtY0et(a4JZAvNmhXG1V8UAgbXPKm1ncPRQBoeh(xMm6Mset5R58Dq3cyCOGQkZpVGPeFkDDvBfJLDkq5A6zjNmIiLJyC4XUAbbtcF0cQQ8xswXM4w8yAweBpR4KyKSzXuh0TIJPmpz)lr5ckouxg86Sk58A0eEHTPUQkrkKSIQeYDgYWFnDm(3d)yYcs6ZWpQPcXYgtpQPUilFdftfB(ucggDwV1jMMgwQO6IfSm6UERue1cAKtyXhxjNSDJxTbq1nYYzP6rOcGGTGNMvKmoED1mlROLv30v5Az8srsKPjA2wYlNZuVGHdNw24buYPHTNR8NvKiMM6MwYxh1tjMAcQxe1fXB(fcQQli1ssrvblRwsMVakZ9MXsrlNkjZOjJfzSulwWImj7(PZyGsBnBJ36nKAxYKKdBAQcDsgzL0suqL4zrlIAw2if4GzSi5XgizhT3D7NEjRczsYQJL3LS1fN2H2oWt98lyBQKlhMmrlMUxgnjH2Fwkuzni4qblGdyHazmufMJyEnkblOoJWCw2MfiPxSGMBD9ACy6y9PjPCspSUeXZYskwptbnw((fuv9xqrA54rI3vFXNOZ(mmmDjhpMZ6WF)CEnNZ5kUxOnGdhL7f84f2N3LfKEMcw2ePHfM9oRKqr7oH97bEtWDbhaoi4LAwyTJRp8wpshAcocCVEnosg3HOuMFyflANUNvCSHnMEb06I8c5fMngoAYYZQwYOitYTyPtkYgh7b)dEeVaV3feXH5OOtl9kLUIoYwE1sPgBgfdsAJ7Tu6uKzTXwtidokn9sselbBQboIm0INmYe6yIybvWND6LOFIeeQK(W3bQJdnd(6bAvgoPm82LH2(cMkAuwlj91NIqmcyzqeTts1TLHtDrO9wGh3lCAOJLWBOQoLg(WpWt8Rb(rIHkGjZID5jRCpzMyVs60qNWjUMHPEotILLdDCYh(oUtOB4kqVEG(qrr)WzGNyO7ho0QOgi1ijvDvtkRRHRjflB1Z1U2KeK5ap0QUP0D0ckDtl00MhxlQtoTILcYKsdhArAJZY8BfmNQ(mPxI(zqhdWlsV2X6QNr33PBVp)0p7SBpRqVryxWdpRstf1KC1cenX5OfXF3SMjodc5(yntCfnI1HzxogBehRwPKveNcVH1(xGLKoSCuLzjQlttoHRMmlXLDtahYePzAoRGm1bkrHPFHhyvh8Us1YnzP6TItYjnCgKVKPUnQAqvzcMyKermoInE5Ki4Ko1gM4LuKSLdgatUe7gvuoVolDwKkLyf65x0jdeGW4qrnvMN)cfeKOwp5tLA1Y3JIT8ivss7QMJmEQ4XsezfwU0rKkzNdo41yjlBqkyGXtnIXHCYKzlRcGNrtvLDPoEnzwQ77qK0pA(4ggpy5ut6y0Esd3lsARKNiz06gua6DMuAonH8kItAlJQUY44U7Y4TTzL1jfNXJUzfWWKiQqTFXTbuKL7fW94WFkP06WdNbvrVKPGXcxY9ch9c69GNeTodN9d0c8uFvJdjGQPjf0MAm6OVyHTo6bEIp9k0mtHGDtHGjz0eOMxz5XgIQiHM6LizkKnltknyK4JgD84W5Ymirq1wEvNkevrfHRS8UcoVjtI9yY6ZmI2kwSVcWSyBCFo3ACls1uqAJdxo)s5jdhAjNmPwoHaqWRJA3rO2rCkIKme2leXdefg4AoLmkciqnmGMFhC5mD3v)rYeRRUNFEJMWQgY1MicJG2TWH6d5j5mu11yW55G4CbNxxppDS6P7RwGcy47esStckaJ0dmQmCbpqY0WyvzFhsLggxgUyA4sPHjOgPHlhdUsA4D6yt(XwJnz4PtdVRAT)cV7d0)Nan7ctkdPzwvbHn0q6zqdPqMSG4R3bibpeq4GSEGCOfqq(BbkPHNrgM617eu9a5DSGbA3hOFyWWdC19dMGfGMEkGwFGPHzsxTkg8HpkLi(LGpc8r9cFm4JdNd(LHFfVWNaEj4tMgwcLTWVkvKcFQQeIWlZKBH7kF39eUZZlzon8PPsj4Z4iH(C3j8zV1w(CS6r(8ahP)3s9iGgANva9cpamlhmhhmp(aEw49aph8EH3NtN7h55HNhwa(rFe4hd(XHFcSa)KWla)umdQWpnh8ZWbViAKeE)Wha(zVl4NJd(GCWIi)6dLg(5HFb8j8lUg5pRtUnvaYRF6zvZpHA3JF(QuaqPFCUB1vaoE9Oa8kV8pWl(XU42u47VR5fv9hSlskR1i8RA4)JvJ0FhuUFFSLBd3Vm8wGhaEqhoWrrU)d7bERheEB73vn4rN34j3Q1aMKoDkejVYTOaZNHFubfnJNObQDyY048HrCz(rvfYvGS1RITQkJRNrIpiUEqBJZUDP4WebCzQrUPQopzwIybBsd1ZVOqEQFce5JKpdDH4g9VnObIW0iVdhQsx5UV6Tbw7a5t1svdH9th42foKTNAgY61DuqcCuquuR)DGQwbyk6HsxLI(Glp(qXVYmJlEfzRXPA4SPF8gHjTt2IPOSGwoI1zAzbCXx4u7SNdMi50cQ4kXBb(cW(HxDupNU9UXRnAcNnz7(BV6vBbV6qSLb1nTqS1c1r3EskkteNQh4P8aVk3ctlyQqx)5kzfO8CN5b2c85pk2Kuxj0ENTtx6c8QPHVy0M1nA6jzvSPoHx76ovjjH6CnQmCJnaF5Qma)RxpgG)ghRAdWVY2ZaSmZa8Awg4oP14JVJzng7VLSgBoyGKdZM6o1M89Nz04bUCeuJ4tSeDA6byUHPAJ0zSfmZrS3il16tmC2P0LVu(bcvYs9LHZ)I31BWW0Ne1Todv1DcuLAnQWWVl8QV(xd(IU6MWRb)EUAIWV)gPac)b1Hk3Vr9OYTVxDhtL71lERPwg2flJ5)h6QFb)rOQf8LQb2FLnszQ345NotVTsgslA1kt7RALP3(URYu1kqhTKcujDfpWRTKUwPLqwRstlzyg8Sozf1QVcE5dFhSQTGIMOE(m4Q2Fn)bseUwfk5nsH63CDkuYBWQ8EKpE9OrDM6YigLb3lZgw3(94PbxY37gL)Fl4CgpyjUd173m34X7JTs9wxnhrJGW4ooea(slYCQqcH8eSxK0M61bifCOKSSP4Lghzn(mKwwzJdtZTM2Y17IooqN9WopZ7ISf87MToc3BQirKxM5YrSE5eLKVEvjOUirE1YoKK(WsZ8JoJ0Oq3oa6g374Ak28HKfOBcfsfw2kIwUG8RSaTguxBxlwVI)z1VQspZ2vFfQwZM7winB4RSgfA4RUX6YWFm()xRouH)TQhv4h4iFVp2oMo83H7X3E6TWFc8NIwO(6mQ5pJQhc)5S5S9xid)LPbqg(RKHvLH)Az4BKg(BQOna)TLK8WFxTI8Xe1LYpM2Sdp4fQsK3r1s8Jv7ky42PK1lIZ0stIUtjjdgpcAUzm2G7(7Mn3mNzO5hvfoAjj((Pc2QX9AfETvX5bks0SLzo3JkUPI47cUmHkB)Tx3uJ3CPAM8k0DYsMjD72KoqRGjjJJNMLxW0DY2CRzA0FtJJgJUZxzX58)0blyBRRz90xAWyPI03e9DD3wH6ItAh14EdfpWWJMAKGXde68bchowQyxmsvc5OmWOAKvve9l74EYKebP5AiLGkI7OY5MGevmXvNVFMSM4iR))ft(z56YJKpXN)h4N9dTpU9N(tHRmy(afcpJGGvvwm(G3wovAJd5SQUkBseUkX1SmjMUwZp1zDu26gEnJMCxEOHHQIOGZofV1QF)o1N63h5MfMHQl12DaZTFy(LdosQuJmCYydmyQTNALvdPw9rVjuRYe5cIwzgmXi(tuLA1)v1QvVX7kTtU1UeAmzfIQenUk0NblMJBLCY0ON6UYxIimfo5rj(X0lO66pOwQVAVR6nOz7vjC0z7tEE9GmVb9P8(ge6r94H7)J6ze3Jv94TV92C823)8w9JTDDw9fZ2HDFxmGD)j0QDRQULFJk(p3feJFT3afJFx4d7DZmu(sl7S7WPWzBQ2ChDBCKQspcoxxbBDZMol8jLrX91kVr0SBN(gj(7PFPlj2JD0UYq20DQS)sY)wYiwWYwp)SEAwvxuqL3jUR4plpDB2NKOnD7o54152Y4swR(MoXDx70ShaxGAibl7GcM8V3ZYNvq1I41PYTNvyq3sqV7zzntv3txFk0a4z5xBo6M8p7Z5nl(1KTXRH1MxrJxXqqX0Y3ZY38OSq1I(mv0YHnmlWkBUn(MPpidbPn9(Rnl(NRvEjDV88oDYmmACYbEN0h57cZwjllpbnj63TpgXoGM04gs4YfOR4N2C07JlnrdlnR8A62RT740Cvkf)MuGZYtd5m3IiJ3bf(4klYwqt0h(yq6FtiaSRLLfeA6A(OHLsB80Lr0QBlXilAgS(XgkyOKgpTMNztEc(ys1w5XvZ52Q4vopGszHpeMssvDtSIBrdUw(ryfPbD00kZkiy5W2EDfPoFo02PAcL(j9FxrvzsEJObnfvw5xusFsNHlP3fmBE0PnLizfkOANoOeXs04YxswrLsvkw8gcItXJFtJ0sIuBusLphk1oHfp13wIyVKPIAzlmNfT3ir0ANFCnBfSE268zy7uNcTqIt1U)PiZD91mMniv5Z4bkXtl16LAz4qzS1ZLtLywWIegjV0WNXZ1ReVBoX6eZ8sxSp7K9zVoBeZcyluPeD3hD(6Dr)OFplw6w(RauC)W3JIpCnIgDpAgWuqsHUWFeVW4i5CtnIj9t2CYxAWrsg7kJKivG4WLpfCfzkEcl0bRkCWwKL2c7EbJhjAQ6AB3cvQZVE)gTM5ATSEfYPi3(zt9YfzYKASK2ivWNsAziyov6RX(kyjFJ4pq4WlXYkuzQEzw6bzXe5LDtWeUjte5IrsUclhNqhBcUQtDzUvzPkTZHCghUM00hi8co1iLJRlm8vX9gvSq(0Jh7uvsDQXOvWHkzrv3HHN4kmSw3iGenwtC0iM2nU2NuWKi4NYa2S5uD3mW4LILirKKtsfoBgQ8dDdrL1UrOY0NZtFhSh0YopOB4ALEO6b)NJ9K8Sw8)V5cLca(vDDkKtKJ6p(ydx1SVViCUGug7sLDVRL3YtgFn(UZxaHCk(MB6(VuagGE4JYq0)N2h8z5wRx725Mg3)a8p6m9nMN472DoC05TD344m6iOhVEhbXZme1XwTIL)zz3fT8nH)fz4FDDEGd(3GRb)7vXeNEbQbkw4)r3ZynIkCUICnxK7XkZlxHf75ULk9A5S9e1FOz6zQln1vvyC29dNxDFuo7TrSv)78S1ICTuK7eRJxwKZ364G9s5G9s5GgL4GVFgd8X3vxKrrU7ytHBkYXnKJV4kT7rf5UZQxhYeYf58qXtkYTpQ56l)OUOgf5EtSYvK7UkYDG6cKyybnH6dKOiN31GnuK7URswuK7nlxL50IChfLdpurUhEJTC(GWShKzqRi3BDZSJ9wUX2Xmo2geYVzuYnPwH8ziMU5zC4azYGmbfCovjy3WcE)lgujNtIn1K7dbZg)oCPW322HcV(XD95Vb1dlh)41yG34XxpTxvPNuIiQKxqT6Gx(y34A4KxgNELHVBCHzyCSxiRKzv11nxhkqrUhPihFrUhTQXvzHZLK5TOfzncT2CLgBX2QVYzVUHzxnP6f64QH7lY0wvdb02BIcbuZ65tkOQKtdzOvgSz68(KrK39DG2suweXKAST54jl5oT)3T(fQQ0g1YUhoXxnrIXzAKknQ1CIYkI8JHlvwiVXPBK6gfNwTrVnsnQ(9(6jBKkUUWhRRgIqjej6SUn6RrQvyLPv0ioV3yng1It1N5lccEB6QPBmQnKmDMJwKT2FO1i9TfmPVZrswBDO1vD9Q51JBRdSWAiuDTS0b00vjfvvWsUX4sy1PtqM(E1qdhsTgtXnmozA(XeenvYQupHt4g1NzVjHiGwqCY3ZGOmuORwR7gAnyxjvvYRy)GBSdLxX9vlH9A5vf6vqlDtB4EORTrKCqtCLO0xpoUgWLZ(tD((pTFHbJnuiAyleNseYLcfXh(aF)kGe8UjHsqKkEQSi3zRRWH5jFFv5SYICdVjER8K3aNoxfZZDZHVMZMdxs4bFD6JPr3E4PhzaXlm9ZyQDv5sEjmYACs8TsS7NQ(I(OV4Ua7Ui34ilgB6gLflej789i0FMak(VDGfFU6Hf)Po2UfhgB5gLbhRJH70FSi5hSpYTdm43rDPdxZ7j1oRom20nklE8Xhn1LhpyV(Nl2TdS4a1flUMa)yNLfJnDJYId9mZoICOcNpH95VDGfhSUyX9m4UglgB6gLf35GbtKOZKfKgt62bwCO6lofFUDn0owB3Om5RynHE0ReoOwKjUDGjhU(0JtT7PhNQXb8MV1l0Am5l3Axc3oWIJuN6XFODr94pudZKZj0xSm5Yn)y2x(2bMC06sp(KNAxtpgB6gLfB6BIH6XSRbk0XTfMkgOEyX18(ZUJYHXwUrzWYx1CqFYIJpvNrVDGbpy9zO49Ep7EgkW2UrzYbgl1SKaZOglrKBhyYXQtM89VlYKV)gMj7lMqGl4ttCOK3wSi6HQtiVxCxeY7fByMC4zhR)yHhDUzg)2c7XNV(yY1CGwSdZKX2UHzYXt63x45Y0AxBkt(wHtqGNAlFx0j5v0KiMvUhD7X4ZRyrpY3mg6MR(8(u04DE1eBTXOf3nKrXKuMwoBJuFSS2k2fKQu9ans1D3If3JqWsnrKgPjsPxquMxpllMWPN2wLBMZ14m1CfONaJUnGBCL3AD3m7QHwEIqfcKkrOifKvl5DFsLTWSf4)E29FV1v0OMxq0uVnwmQflCB80tcQyHTWI38JZIBTh94wn3gFhD3vVD2g)Z6Cb)Z5w5sHkjVHjXIOz7JgEGUXAQIuvrAQBZ6gIOLcsuw4OEw(qtYEbpBFaIZbafnoE8P4gtK0GlKwSQIrXtDk(rkytfYok586AQZ1gVLolO7qkPGQnnq)mjcs0GFRDEFHeOhNL8sOMTOT6CNH3vkYeIvA2miDnLf2B0TXYHvaPsvlA)WjMfXhOeP9sHAjsAHMK(IJYAfk5ZokafSfcoxLosZoNgIn7e9TTX3S7zSvZTwkyjTlyQXcsZYbaAL4RKV09DIfyAwRH1xGfNMmopsqX0cX4jXXocDNn8v7tXPjDdrx2RFx1HmCs2bbM3YbFRBjkZ6lxJqiR1MWc8xFn78A8r7FkQT52ySaSLgXTbyePtrsrYJ8cBsZTwvRXI2uvv2X)MLpNAxZ9PNiLw2etuIfsvbfp(AoG2CJBqdcz8IWyN0Tbxt)aPtNMOmR0PFZIvSntTZzCGlZ0PKRP7ZiyBBtfmj27PbAaLuyJJwFpRsbzfGDO01MZGUZ4ese(ypLwBTmvwP20GVvZhvsuE8vRvPcmJGTOmXC9sWl5EdCGynskNi1UvVBsXpBPw0R73NzCntxUpkICoItrfTs3TKKHDdFn7CItmzYidejXKrseiy8iHBERkn7O6nwIbM8sJKm(gvC64l3QmEIyPMmW4jdq53UJQQubk)s0uXal4iASAGfZzWrRElpib(UPVv611OihztEFnYw7MGEveXyjwu4XgElxzozQB1CYQ69eU7UDpjx2SzPv(TtdFGBWRoZQoBB6WUiIB5RrZSM9C(eZk6FAFDw17rr89FR)7rtrUS1VGPiNE6gqG8D237EBY)lYzS1m9oEgLm90raYOtKDRz6SzkCp7iZuGnrHU7Rp60eWV2Bsc7njH9MKWEtsyVjjCZJfLREWI(YhZbksENfk6lFSTnsuuDJjgkQOYfteCRpVpzirnVJGe9oFhoc(3LdMuh(7YzTRSV93r394FpWP9aN2dCApWP9aNU5bNKRhWPxz4DdWPt(kdFGuNzBJpzF1mwZyh)cXoD3B5P8adE6y7kWtD1B3(z4tox4V3E6RJ9aO2dGApaQ9aO2dG6MhGsPU8Kx)V0Uccf2Uhq9r32quDMptVz6uWFSbsufe14Boe1H358LN)ECWLOFVhE0E4r7HhThE0E4r384rptD5nVxE3XBEV82gkYVXybMW)y2NgP(kqrF2nhk6i7CqrD0xhD2lBns0l2dmApWO9aJ2dmApWOBEWOPQRfhf9VFxbnI2UBB4O5BviN)bIiAeAtGJAsA37aOQUJg4pkCc4vGVDrUdwK74f5ozrU2kYnmL99)ml3lvBWK68ZykoyJfkPSZRq2pmZTx5x)kFR7xCS2w3pJyTv1VnyTTr)IDnJc(HGwPF5U4z)ky326ovvABn)sB1ABuKjrR22GtRz2bIznNdZTv5evK98y0uuCud7a3YIAeY5qFcly5dJdFSIoh2D4PuWjSCSbIa3023nsCpfZ6Qz5W1flo(Sqmsv3tQrth7V6vds3UBe6AXqRFc32LvxjDTtyZt)1kMFoIn78FS0X)ioEzr2H0b9NXzJtu5W9J9Z68tZSBpPdxAYkbIn9C4TRTk8F32H(RyOcXhv0xhZCfHsH(7l(MBkFtsnzLSJ27Q9oBA699C)F)
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
4. **v1.5.0:** the game's own cast bar no longer shows when you cast, also
   after `/reload`, zoning, a flight path or a vehicle; unticking the option
   brings it back.
5. **v1.4.0, please check:**
   - click a missing-buff reminder out of combat: it casts the buff on you and
     disappears; clicking where a reminder isn't does nothing;
   - in combat, reminders are gone except Shadowform's (if you leave the form);
   - Power Word: Shield shows with a timer, Weakened Soul under it;
   - the red frame round Shadow Word: Death appears below 20% target health,
     only while it's ready, also in combat;
   - Night Elf: Elune's Light and Elune's Grace show on the left while active.
6. **Out of combat**, with a target dummy or mob targeted: Pain, Plague and
   Embrace are grey before you cast them, bright with a timer after.
7. **In combat**: the same, and the timers keep counting.
8. Mind Blast and Shadow Word: Death go grey with a countdown after casting.
9. Silence, Psychic Scream, Fade and Inner Focus appear under the row only
   while cooling down.
10. Shadow Weaving shows the stack count (1–5) on the target.
11. Remove Inner Fire (right-click it): the reminder appears. Same for
   Shadowform and Fortitude.
12. On a priest that doesn't know a spell yet, its icon stays hidden.
13. On a non-priest, nothing shows.

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
