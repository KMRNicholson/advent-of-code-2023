// See https://aka.ms/new-console-template for more information
using Services.GameService;

if (args.Length == 0)
{
    Console.WriteLine("Provide path to game input data as the first argument and try again.");
    Environment.Exit(1);
}

var gameDataPath = args[0];
var gameService = new GameService(gameDataPath);

var rawData = gameService.GetRawData;

foreach (var line in rawData)
{
    Console.WriteLine(line);
}
