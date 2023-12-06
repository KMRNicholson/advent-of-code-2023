const checkForSymbol = (char) => new RegExp(/[!@#$%^&*)(/+=_-]/).test(char);

const checkForGear = (char) => new RegExp(/[*]/).test(char);

const checkForNumber = (char) => new RegExp(/[0-9]/).test(char);

const rangeOfMotion = (length, coordinate) => {
  let negative = coordinate - 1;
  let positive = coordinate + 1;

  if (coordinate === 0) negative = coordinate;

  if (coordinate === length - 1) positive = coordinate;

  return [negative, coordinate, positive];
};

const findStart = (line, x) => {
  while (x > 0 && checkForNumber(line[x - 1])) {
    x--;
  }
  return x;
};

const findEnd = (line, x) => {
  while (x < line.length - 1 && checkForNumber(line[x + 1])) {
    x++;
  }
  return x + 1;
};

const markNumber = (line, start, end) => {
  let newLine = line;
  while (start < end) {
    newLine[start] = ".";
    start++;
  }
  return newLine;
};

const parseNumber = (line, x) => {
  const start = findStart(line, x);
  const end = findEnd(line, x);

  let numberString = "";
  let i = start;
  while (i < end) {
    numberString = numberString.concat(line[i]);
    i++;
  }

  return [Number(numberString), start, end];
};

const checkForNumbers = (schematic, limits, coordinates) => {
  const { xLimit, yLimit } = limits;
  const { x, y } = coordinates;
  const xRange = rangeOfMotion(xLimit, x);
  const yRange = rangeOfMotion(yLimit, y);

  let schematicCopy = schematic;
  let numbers = [];
  yRange.forEach((y) => {
    xRange.forEach((x) => {
      if (checkForNumber(schematicCopy[y][x])) {
        let [number, start, end] = parseNumber(schematicCopy[y], x);
        let newLine = markNumber(schematicCopy[y], start, end);
        schematicCopy[y] = newLine;
        numbers = [...numbers, number];
      }
    });
  });

  return [numbers, schematicCopy];
};

module.exports = {
  checkForSymbol,
  checkForNumbers,
};
