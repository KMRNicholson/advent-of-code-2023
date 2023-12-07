// See https://aka.ms/new-console-template for more information
using Services.ScratchCardBuilder;

if (args.Length == 0)
{
    Console.WriteLine("Provide path to card input data as the first argument and try again.");
    Environment.Exit(1);
}

var cardDataPath = args[0];

var cards = new List<ScratchCard>();
foreach (var line in File.ReadLines(cardDataPath))
{
    var card = ScratchCardBuilder.Build(line);
    cards.Add(card);
}

var sum = 0.0;
foreach (var card in cards)
{
    var points = card.GetPoints();
    sum += points;
}

Console.WriteLine("The sum of all card game points was found to be: " + sum);