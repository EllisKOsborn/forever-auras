// Draws the README pictures: a sketch of where a pack's icons and bars sit,
// from the builder's own positions (lua5.1 tools/build.lua --layout <pack>).
// No game art: plain tiles with the spell names.
// Usage: node tools/layout.js            both packs
//        node tools/layout.js HolyPriest one pack
const { execFileSync } = require("child_process");
const fs = require("fs");
const path = require("path");
const { chromium } = require("playwright");

const ROOT = path.join(__dirname, "..");

// Per pack: the output file, what the picture shows (a typical moment: only
// what is cooling down, one race's spells), example states, colours, legend.
const PACKS = {
  ShadowPriest: {
    out: "layout.png",
    // A Night Elf priest mid-fight.
    cooldowns: ["Silence", "Fade", "Vampiric Embrace", "Starshards"],
    // Displays that share a spot (only one ever shows) are drawn once.
    sameSpot: ["Shadowform missing (in combat)", "Shadowguard missing", "Eureka!"],
    state: {
      "Rotation|Devouring Plague": "missing", "Rotation|Vampiric Embrace": "expiring", "Rotation|Mind Blast": "ready",
      "Rotation|Shadow Weaving": "full", "Procs|Spirit Tap": "proc", "Procs|Inner Focus": "proc",
      "Procs|Elune's Light": "proc", "Shield|Weakened Soul": "soul",
    },
    rows: {
      Reminders: { bg: "#2a1f3d", border: "#f28c26", label: "Reminders (only when missing)" },
      Rotation: { bg: "#2a1f3d", border: "#000", label: "Rotation" },
      "Cast bar": { label: "Cast bar + Mind Flay ticks" },
      "Mana bar": { label: "Mana" },
      Cooldowns: { bg: "#1f2a3d", border: "#000", label: "Cooldowns, only while cooling down (+ your race's spells)" },
      Procs: { bg: "#1f3d30", border: "#000", label: "" },
      Shield: { bg: "#3d3520", border: "#000", label: "" },
    },
    cast: ["Mind Flay", "1.4", "#8e66e6", "#1a1426"],
    ready: "#b885ff",
    glow: "#ffd15a",
    legend: "Grey + red border: DoT missing · Gold glow: running out / buff up · Purple glow: ready (in combat)<br>" +
      "Red frame: SW: Death with target under 20% · Gold 5: full Shadow Weaving<br>" +
      "Left: procs + Elune's buffs · Right: your shield + Weakened Soul · Reminders: click to rebuff (out of combat)",
  },
  HolyPriest: {
    out: "layout-holy.png",
    // A Night Elf priest mid-fight.
    cooldowns: ["Fade", "Fear Ward", "Starshards"],
    sameSpot: ["Shadowguard missing", "Eureka!"],
    state: {
      "Healing|Renew": "expiring", "Healing|Prayer of Mending": "ready", "Healing|Weakened Soul": "soul",
      "Healing|Inner Focus": "", "Procs|Inner Focus": "proc", "Procs|Power Infusion": "proc", "Shield|Weakened Soul": "soul",
    },
    rows: {
      Reminders: { bg: "#3a3020", border: "#f28c26", label: "Reminders (only when missing)" },
      Healing: { bg: "#3a3020", border: "#4d3b0f", label: "On your friendly target + ready" },
      "Cast bar": { label: "Cast bar (gold)" },
      "Mana bar": { label: "Mana" },
      Cooldowns: { bg: "#2c2618", border: "#4d3b0f", label: "Cooldowns, only while cooling down (+ your race's spells)" },
      Procs: { bg: "#3d3828", border: "#4d3b0f", label: "" },
      Shield: { bg: "#3d3520", border: "#4d3b0f", label: "" },
    },
    cast: ["Greater Heal", "1.8", "#ffc740", "#17120a"],
    ready: "#ffd24d",
    glow: "#fff2b3",
    legend: "Renew: grey when you could cast it, pale-gold glow in its last 3 s · Red border: Weakened Soul<br>" +
      "Gold glow: Prayer of Mending / Inner Focus ready (in combat) · Warm-white glow: buff up<br>" +
      "Left: Inner Focus, Power Infusion, race buffs · Right: your shield + Weakened Soul · Reminders: click to rebuff",
  },
};

const short = (n) => n.replace(" missing", "").replace("Shadow Word: ", "SW: ").replace("Power Word: ", "PW: ")
  .replace("Shadowform", "Shadow&shy;form").replace("Touch of Weakness", "Race buff")
  .replace("Weakened Soul", "Weak&shy;ened Soul").replace("Prayer of Mending", "Prayer of Mending")
  .replace("Power Infusion", "Power Infu&shy;sion").replace("Desperate Prayer", "Desp. Prayer");

function html(key, cfg, items) {
  // Dynamic rows (cooldowns) close up: lay them out side by side as the game does.
  const rows = {};
  for (const i of items) if (i.dynamic) (rows[i.row] = rows[i.row] || []).push(i);
  for (const list of Object.values(rows)) {
    const space = 4, width = list.reduce((w, i) => w + i.w, 0) + space * (list.length - 1);
    let x = -width / 2;
    for (const i of list) { i.x = x + i.w / 2; x += i.w + space; }
  }
  const ROOT_Y = -200; // the pack's place below screen centre
  const top = Math.max(...items.map((i) => i.y + i.h / 2)), bottom = Math.min(...items.map((i) => i.y - i.h / 2));
  const PAD = 24, W = 660, H = Math.ceil(top - bottom) + PAD * 2 + 66, CX = W / 2 - 30;
  const toTop = (y) => PAD + (top - y); // screen y (up) to page y (down)
  const [castName, castTime, castFill, castBg] = cfg.cast;

  const tiles = items.map((i) => {
    const pos = `left:${CX + i.x - i.w / 2}px;top:${toTop(i.y + i.h / 2)}px;width:${i.w}px;height:${i.h}px;`;
    if (i.name.startsWith("Cast bar tick")) return `<div class="tick" style="${pos}"></div>`;
    if (i.name.endsWith(" execute")) return `<div class="exec" style="${pos}"></div>`;
    if (i.row === "Cast bar") {
      return `<div class="t bar" style="${pos}background:linear-gradient(90deg,${castFill} 0 62%,${castBg} 62%);` +
        `color:#fff;text-shadow:0 0 2px #000,0 0 2px #000"><span>${castName}</span><span>${castTime}</span></div>`;
    }
    if (i.row === "Mana bar") return `<div class="t mana" style="${pos}"><span>4.3K</span><span>64%</span></div>`;
    const s = cfg.rows[i.row] || Object.values(cfg.rows)[1];
    const st = cfg.state[i.row + "|" + i.name] || "";
    const extra = i.name === "Shadow Weaving" ? `<i>5</i>` : "";
    return `<div class="t ${st}" style="${pos}background:${s.bg};border-color:${s.border};` +
      `font-size:${i.w >= 40 ? 9 : 8}px">${short(i.name)}${extra}</div>`;
  }).join("");

  const labels = Object.entries(cfg.rows).map(([name, s]) => {
    const ys = items.filter((i) => i.row === name).map((i) => i.y);
    if (!ys.length || !s.label) return "";
    return `<div class="l" style="top:${toTop(ys[0]) - 6}px">${s.label}</div>`;
  }).join("");

  return {
    W, H, html: `<!doctype html><meta charset="utf-8"><style>
body{margin:0;background:#101014;font-family:Arial,Helvetica,sans-serif}
.s{position:relative;width:${W}px;height:${H}px;overflow:hidden}
.t{position:absolute;box-sizing:border-box;border:1px solid #000;color:#eee;display:flex;z-index:1;
align-items:center;justify-content:center;text-align:center;line-height:1.05;padding:1px;overflow:visible}
.t.bar,.t.mana{justify-content:space-between;padding:0 5px;font-size:13px}
.t.mana{background:linear-gradient(90deg,#3f84ff 0 64%,#101830 64%);font-size:11px}
.t.missing{background:#333 !important;color:#888;border:1px solid #d9332a !important;box-shadow:0 0 0 1px #d9332a}
.t.expiring{box-shadow:0 0 0 2px ${cfg.glow},0 0 8px 2px ${cfg.glow}99}
.t.ready{box-shadow:0 0 0 2px ${cfg.ready},0 0 8px 2px ${cfg.ready}99}
.t.proc{box-shadow:0 0 0 2px ${cfg.glow},0 0 8px 2px ${cfg.glow}99}
.t.full i{color:#ffd15a}
.t i{position:absolute;right:2px;bottom:0;font-style:normal;font-weight:bold;font-size:13px}
.tick{position:absolute;background:rgba(255,255,255,.75);z-index:2}
.exec{position:absolute;background:#f21f1f;z-index:0}
.t.soul{border:1px solid #d9332a !important;box-shadow:0 0 0 1px #d9332a}
.l{position:absolute;right:8px;color:#999;font-size:9px;line-height:1.15;width:118px;text-align:left}
.lg{position:absolute;bottom:22px;left:0;right:0;text-align:center;color:#aaa;font-size:9px;line-height:1.4}
.n{position:absolute;bottom:6px;left:0;right:0;text-align:center;color:#777;font-size:10px}
</style><div class="s">${tiles}${labels}<div class="lg">${cfg.legend}</div>
<div class="n">Layout sketch from the pack's positions, not a game screenshot. The pack sits ${-ROOT_Y} px below screen centre.</div></div>`,
  };
}

(async () => {
  const keys = process.argv[2] ? [process.argv[2]] : Object.keys(PACKS);
  const browser = await chromium.launch();
  fs.mkdirSync(path.join(ROOT, "docs"), { recursive: true });
  for (const key of keys) {
    const cfg = PACKS[key];
    if (!cfg) throw new Error("no pack named " + key);
    const items = JSON.parse(execFileSync("lua5.1", ["tools/build.lua", "--layout", key], { cwd: ROOT, encoding: "utf8" }))
      .filter((i) => i.row !== "Cooldowns" || cfg.cooldowns.includes(i.name))
      .filter((i) => !cfg.sameSpot.includes(i.name) || i.row === "Cooldowns");
    const page = html(key, cfg, items);
    const tab = await browser.newPage({ viewport: { width: page.W, height: page.H }, deviceScaleFactor: 2 });
    await tab.setContent(page.html);
    await tab.locator(".s").screenshot({ path: path.join(ROOT, "docs", cfg.out) });
    await tab.close();
    console.log("Wrote docs/" + cfg.out);
  }
  await browser.close();
})();
