const { open } = require("node:fs/promises");

const initSchematicFromFile = async (inputFilePath) => {
  const file = await open(inputFilePath);
  let schematic = [];
  let i = 0;
  for await (const line of file.readLines()) {
    let j = 0;
    let lineArray = [];
    while (j < line.length) {
      lineArray = [...lineArray, line[j]];
      j++;
    }
    schematic = [...schematic, lineArray];
    i++;
  }

  return schematic;
};

module.exports = {
  initSchematicFromFile,
};
