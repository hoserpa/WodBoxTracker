import { readFileSync } from "node:fs";
const wods = JSON.parse(readFileSync("src/data/wods.json", "utf8"));
const show = (label, w) => {
  console.log("--- " + label + ":");
  console.log(JSON.stringify(w));
};
show("wod 3 ladder+nota", wods[2]);
show("1651 tilde", wods.find((w) => w.id === 1651));
show("1483 max test", wods.find((w) => w.id === 1483));
show("887 pegado", wods.find((w) => w.id === 887));
show("2215 emom 10+5", wods.find((w) => w.id === 2215));
show("727 escalera rounds", wods.find((w) => w.id === 727));
show(
  "rest a secas",
  wods.find((w) => w.blocks.some((b) => b.label === "rest" && !b.seconds && b.rest)),
);
const thenRest = wods.find(
  (w) =>
    w.blocks.length > 1 &&
    w.blocks.some((b, i) => b.label === "then" && w.blocks[i + 1]?.label === "rest"),
);
show("then+rest", thenRest);
const inv = wods.find((w) =>
  w.blocks.some(
    (b) => b.label === "work" && b.items.some((it) => it.exercise?.includes("for 1 minute")),
  ),
);
show("max-for-minutes sin parsear?", inv);
