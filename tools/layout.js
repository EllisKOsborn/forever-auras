// Draws docs/layout.png: a sketch of where the pack's icons and bar sit, from
// the builder's own positions (lua5.1 tools/build.lua --layout). No game
// art: plain tiles with the spell names. Usage: node tools/layout.js
const { execFileSync } = require("child_process");
const fs = require("fs");
const path = require("path");
const { chromium } = require("playwright");

const ROOT = path.join(__dirname, "..");
const items = JSON.parse(execFileSync("lua5.1", ["tools/build.lua", "--layout"], { cwd: ROOT, encoding: "utf8" }));

// Dynamic rows (cooldowns) close up: lay them out side by side as the game does.
const rows = {};
for (const i of items) if (i.dynamic) (rows[i.row] = rows[i.row] || []).push(i);
for (const list of Object.values(rows)) {
  const space = 4, width = list.reduce((w, i) => w + i.w, 0) + space * (list.length - 1);
  let x = -width / 2;
  for (const i of list) { i.x = x + i.w / 2; x += i.w + space; }
}

const ROW = {
  Reminders: { bg: "#3d2a1f", border: "#d49b7f", label: "Reminders<br>(only when missing)" },
  Rotation: { bg: "#2a1f3d", border: "#9b7fd4", label: "Rotation" },
  "Cast bar": { bg: "#3a2a5c", border: "#9b7fd4", label: "Cast bar<br>(only while casting)" },
  Cooldowns: { bg: "#1f2a3d", border: "#7f9bd4", label: "Cooldowns<br>(only while cooling down)" },
};
const short = (n) => n.replace(" missing", "").replace("Shadow Word: ", "SW: ").replace("Power Word: ", "PW: ")
  .replace("Shadowform", "Shadow&shy;form");

const ROOT_Y = -200; // the pack's place below screen centre
const top = Math.max(...items.map((i) => i.y + i.h / 2)), bottom = Math.min(...items.map((i) => i.y - i.h / 2));
const PAD = 24, W = 540, H = Math.ceil(top - bottom) + PAD * 2 + 22, CX = W / 2 + 40;
const toTop = (y) => PAD + (top - y); // screen y (up) to page y (down)

const tiles = items.map((i) => {
  const s = ROW[i.row];
  const isBar = i.row === "Cast bar";
  const text = isBar ? `<span>Mind Flay</span><span>1.4</span>` : short(i.name);
  return `<div class="t${isBar ? " bar" : ""}" style="left:${CX + i.x - i.w / 2}px;top:${toTop(i.y + i.h / 2)}px;` +
    `width:${i.w}px;height:${i.h}px;background:${s.bg};border-color:${s.border};font-size:${i.w >= 40 ? 9 : 8}px">${text}</div>`;
}).join("");

const labels = Object.entries(ROW).map(([name, s]) => {
  const ys = items.filter((i) => i.row === name).map((i) => i.y);
  if (!ys.length) return "";
  return `<div class="l" style="top:${toTop(ys[0]) - 7}px">${s.label}</div>`;
}).join("");

const html = `<!doctype html><meta charset="utf-8"><style>
body{margin:0;background:#101014;font-family:Arial,Helvetica,sans-serif}
.s{position:relative;width:${W}px;height:${H}px;overflow:hidden}
.t{position:absolute;box-sizing:border-box;border:2px solid;border-radius:4px;color:#eee;display:flex;
align-items:center;justify-content:center;text-align:center;line-height:1.05;padding:1px;overflow:hidden}
.t.bar{justify-content:space-between;padding:0 4px;border-width:1px;border-radius:2px;
background:linear-gradient(90deg,#8e66e6 0 62%,#1a1426 62%) !important}
.l{position:absolute;left:8px;color:#999;font-size:10px;line-height:1.15}
.n{position:absolute;bottom:6px;left:0;right:0;text-align:center;color:#777;font-size:10px}
</style><div class="s">${tiles}${labels}
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
