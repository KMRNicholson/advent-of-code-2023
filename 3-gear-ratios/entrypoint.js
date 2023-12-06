const schematicService = require("./services/schematicService");
const { initSchematicFromFile } = require("./services/fileService");

initSchematicFromFile(process.argv[2]).then((schematic) => {
  main(schematic);
});

const main = (schematic) => {
  const limits = { xLimit: schematic[0].length, yLimit: schematic.length };

  let partNumberSum = 0;
  let gearRatioSum = 0;
  let y = 0;
  while (y < schematic.length) {
    let x = 0;
    while (x < schematic[y].length) {
      const coordinates = { x, y };

      symbolFound = schematicService.checkForSymbol(schematic[y][x]);

      if (symbolFound) {
        const [partData, newSchematic] = schematicService.checkForNumbers(
          schematic,
          limits,
          coordinates
        );

        schematic = newSchematic;
        partNumberSum += partData.numbers.reduce((acc, num) => (acc += num), 0);

        if (
          schematicService.checkForGear(partData.part) &&
          partData.numbersFound === 2
        ) {
          gearRatioSum += partData.numbers.reduce(
            (acc, num) => (acc = acc * num),
            1
          );
        }
      }
      x++;
    }
    y++;
  }

  console.log(`sum of part numbers was found to be: ${partNumberSum}`);
  console.log(`gear ratio was found to be: ${gearRatioSum}`);
};
