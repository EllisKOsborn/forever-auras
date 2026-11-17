// Draws docs/layout.png: a sketch of where the pack's icons and bar sit, from
// the builder's own positions (lua5.1 tools/build.lua --layout). No game
// art: plain tiles with the spell names. Usage: node tools/layout.js
const { execFileSync } = require("child_process");
const fs = require("fs");
const path = require("path");
const { chromium } = require("playwright");

const ROOT = path.join(__dirname, "..");
// The cooldown row only ever shows what is cooling down, and race spells only
// for your race: draw a typical moment (a Night Elf priest mid-fight).
const COOLDOWN_SAMPLE = ["Silence", "Fade", "Vampiric Embrace", "Starshards"];
const items = JSON.parse(execFileSync("lua5.1", ["tools/build.lua", "--layout"], { cwd: ROOT, encoding: "utf8" }))
  .filter((i) => i.row !== "Cooldowns" || COOLDOWN_SAMPLE.includes(i.name));

// Dynamic rows (cooldowns) close up: lay them out side by side as the game does.
const rows = {};
for (const i of items) if (i.dynamic) (rows[i.row] = rows[i.row] || []).push(i);
for (const list of Object.values(rows)) {
  const space = 4, width = list.reduce((w, i) => w + i.w, 0) + space * (list.length - 1);
  let x = -width / 2;
  for (const i of list) { i.x = x + i.w / 2; x += i.w + space; }
}

const ROW = {
  Reminders: { bg: "#2a1f3d", border: "#f28c26", label: "Reminders (only when missing)" },
  Rotation: { bg: "#2a1f3d", border: "#000", label: "Rotation" },
  "Cast bar": { bg: "#3a2a5c", border: "#000", label: "Cast bar + Mind Flay ticks" },
  "Mana bar": { bg: "#1f3a6b", border: "#000", label: "Mana" },
  Cooldowns: { bg: "#1f2a3d", border: "#000", label: "Cooldowns, only while cooling down (+ your race's spells)" },
  Procs: { bg: "#1f3d30", border: "#000", label: "" },
};
// Example states, so the picture shows what each colour means.
const STATE = {
  "Rotation|Devouring Plague": "missing", "Rotation|Vampiric Embrace": "expiring", "Rotation|Mind Blast": "ready",
  "Rotation|Shadow Weaving": "full", "Procs|Spirit Tap": "proc", "Procs|Inner Focus": "proc",
};
const short = (n) => n.replace(" missing", "").replace("Shadow Word: ", "SW: ").replace("Power Word: ", "PW: ")
  .replace("Shadowform", "Shadow&shy;form");

const ROOT_Y = -200; // the pack's place below screen centre
const top = Math.max(...items.map((i) => i.y + i.h / 2)), bottom = Math.min(...items.map((i) => i.y - i.h / 2));
const PAD = 24, W = 640, H = Math.ceil(top - bottom) + PAD * 2 + 40, CX = W / 2 - 40;
const toTop = (y) => PAD + (top - y); // screen y (up) to page y (down)

const tiles = items.map((i) => {
  const pos = `left:${CX + i.x - i.w / 2}px;top:${toTop(i.y + i.h / 2)}px;width:${i.w}px;height:${i.h}px;`;
  if (i.name.startsWith("Cast bar tick")) return `<div class="tick" style="${pos}"></div>`;
  const s = ROW[i.row] || ROW.Rotation;
  if (i.row === "Cast bar") return `<div class="t bar" style="${pos}"><span>Mind Flay</span><span>1.4</span></div>`;
  if (i.row === "Mana bar") return `<div class="t mana" style="${pos}"><span>4.3K</span><span>64%</span></div>`;
  const st = STATE[i.row + "|" + i.name] || "";
  const extra = i.name === "Shadow Weaving" ? `<i>5</i>` : "";
  return `<div class="t ${st}" style="${pos}background:${s.bg};border-color:${s.border};` +
    `font-size:${i.w >= 40 ? 9 : 8}px">${short(i.name)}${extra}</div>`;
}).join("");

const labels = Object.entries(ROW).map(([name, s]) => {
  const ys = items.filter((i) => i.row === name).map((i) => i.y);
  if (!ys.length || !s.label) return "";
  return `<div class="l" style="top:${toTop(ys[0]) - 6}px">${s.label}</div>`;
}).join("");
const legend = `<div class="lg">Grey + red border: DoT missing · Gold glow: running out / proc up · ` +
  `Purple glow: ready (in combat) · Gold 5: full Shadow Weaving</div>`;

const html = `<!doctype html><meta charset="utf-8"><style>
body{margin:0;background:#101014;font-family:Arial,Helvetica,sans-serif}
.s{position:relative;width:${W}px;height:${H}px;overflow:hidden}
.t{position:absolute;box-sizing:border-box;border:1px solid #000;color:#eee;display:flex;
align-items:center;justify-content:center;text-align:center;line-height:1.05;padding:1px;overflow:visible}
.t.bar,.t.mana{justify-content:space-between;padding:0 4px;font-size:10px}
.t.bar{background:linear-gradient(90deg,#8e66e6 0 62%,#1a1426 62%)}
.t.mana{background:linear-gradient(90deg,#3f84ff 0 64%,#101830 64%);font-size:8px}
.t.missing{background:#333 !important;color:#888;border:1px solid #d9332a !important;box-shadow:0 0 0 1px #d9332a}
.t.expiring{box-shadow:0 0 0 2px #ffd15a,0 0 8px 2px rgba(255,209,90,.6)}
.t.ready{box-shadow:0 0 0 2px #b885ff,0 0 8px 2px rgba(184,133,255,.6)}
.t.proc{box-shadow:0 0 0 2px #ffd15a,0 0 8px 2px rgba(255,209,90,.6)}
.t.full i{color:#ffd15a}
.t i{position:absolute;right:2px;bottom:0;font-style:normal;font-weight:bold;font-size:13px}
.tick{position:absolute;background:rgba(255,255,255,.75);z-index:2}
.l{position:absolute;right:8px;color:#999;font-size:9px;line-height:1.15;width:118px;text-align:left}
.lg{position:absolute;bottom:22px;left:0;right:0;text-align:center;color:#aaa;font-size:9.5px}
.n{position:absolute;bottom:6px;left:0;right:0;text-align:center;color:#777;font-size:10px}
</style><div class="s">${tiles}${labels}${legend}
<div class="n">Layout sketch from the pack's positions, not a game screenshot. The pack sits ${-ROOT_Y} px below screen centre.</div></div>`;

(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage({ viewport: { width: W, height: H }, deviceScaleFactor: 2 });
  await page.setContent(html);
  fs.mkdirSync(path.join(ROOT, "docs"), { recursive: true });
  await page.locator(".s").screenshot({ path: path.join(ROOT, "docs", "layout.png") });
  await browser.close();
  console.log("Wrote docs/layout.png");
})();
