const schematicService = require("./services/schematicService");
const { initSchematicFromFile } = require("./services/fileService");

initSchematicFromFile(process.argv[2]).then((schematic) => {
  main(schematic);
});

const main = (schematic) => {
  const limits = { xLimit: schematic[0].length, yLimit: schematic.length };

  let sum = 0;
  let y = 0;
  while (y < schematic.length) {
    let x = 0;
    while (x < schematic[y].length) {
      const coordinates = { x, y };

      symbolFound = schematicService.checkForSymbol(schematic[y][x]);

      if (symbolFound) {
        const [numbers, newSchematic] = schematicService.checkForNumbers(
          schematic,
          limits,
          coordinates
        );

        schematic = newSchematic;
        sum += numbers.reduce((acc, num) => (acc += num), 0);
      }
      x++;
    }
    y++;
  }

  console.log(`sum of all part numbers was found to be: ${sum}`);
};
