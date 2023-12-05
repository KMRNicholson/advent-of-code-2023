const { open } = require("node:fs/promises");

const initEngineSchematic = async (inputFilePath) => {
  const file = await open(inputFilePath);
  schematic = [];
  for await (const line of file.readLines()) {
    schematic = [...schematic, line];
  }

  return schematic;
};

module.exports = {
  initEngineSchematic,
};
