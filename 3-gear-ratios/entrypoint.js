const { initEngineSchematic } = require("./services/helperService");

initEngineSchematic(process.argv[2]).then((schematic) => {
  main(schematic);
});

const main = (schematic) => {
  console.log(schematic);
};
