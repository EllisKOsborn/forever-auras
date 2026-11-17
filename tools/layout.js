// Draws docs/layout.png: a sketch of where the pack's icons sit, from the
// builder's own positions (lua5.1 tools/build.lua --layout). No game art:
// plain tiles with the spell names. Usage: node tools/layout.js
const { execFileSync } = require("child_process");
const fs = require("fs");
const path = require("path");
const { chromium } = require("playwright");

const ROOT = path.join(__dirname, "..");
const icons = JSON.parse(execFileSync("lua5.1", ["tools/build.lua", "--layout"], { cwd: ROOT, encoding: "utf8" }));

// Dynamic rows (cooldowns) close up: lay them out side by side as the game does.
const rows = {};
for (const i of icons) if (i.dynamic) (rows[i.row] = rows[i.row] || []).push(i);
for (const list of Object.values(rows)) {
  const space = 4, width = list.reduce((w, i) => w + i.size, 0) + space * (list.length - 1);
  let x = -width / 2;
  for (const i of list) { i.x = x + i.size / 2; x += i.size + space; }
}

const ROW_STYLE = {
  Rotation: { bg: "#2a1f3d", border: "#9b7fd4" },
  Cooldowns: { bg: "#1f2a3d", border: "#7f9bd4" },
  Reminders: { bg: "#3d2a1f", border: "#d49b7f" },
};
const short = (n) => n.replace(" missing", "").replace("Shadow Word: ", "SW: ").replace("Power Word: ", "PW: ")
  .replace("Shadowform", "Shadow&shy;form");

const W = 520, H = 200, CX = W / 2, CY = 92; // pack centre (its root) drawn at CY
const tiles = icons.map((i) => {
  const s = ROW_STYLE[i.row];
  const left = CX + i.x - i.size / 2, top = CY - (i.y + 200) - i.size / 2; // root sits at y = -200
  const font = i.size >= 40 ? 9 : 8;
  return `<div class="t" style="left:${left}px;top:${top}px;width:${i.size}px;height:${i.size}px;` +
    `background:${s.bg};border-color:${s.border};font-size:${font}px">${short(i.name)}</div>`;
}).join("");

const label = (y, text) => `<div class="l" style="top:${y}px">${text}</div>`;
const html = `<!doctype html><meta charset="utf-8"><style>
body{margin:0;background:#101014;font-family:Arial,Helvetica,sans-serif}
.s{position:relative;width:${W}px;height:${H}px;overflow:hidden}
.t{position:absolute;box-sizing:border-box;border:2px solid;border-radius:4px;color:#eee;display:flex;
align-items:center;justify-content:center;text-align:center;line-height:1.05;padding:1px;overflow:hidden}
.l{position:absolute;left:8px;color:#999;font-size:10px}
.n{position:absolute;bottom:6px;left:0;right:0;text-align:center;color:#777;font-size:10px}
</style><div class="s">${tiles}
${label(CY - 72, "Reminders<br>(only when missing)")}
${label(CY - 8, "Rotation")}
${label(CY + 36, "Cooldowns<br>(only while cooling down)")}
<div class="n">Layout sketch from the pack's positions, not a game screenshot. The pack sits 200 px below screen centre.</div></div>`;

(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage({ viewport: { width: W, height: H }, deviceScaleFactor: 2 });
  await page.setContent(html);
  fs.mkdirSync(path.join(ROOT, "docs"), { recursive: true });
  await page.locator(".s").screenshot({ path: path.join(ROOT, "docs", "layout.png") });
  await browser.close();
  console.log("Wrote docs/layout.png");
})();
