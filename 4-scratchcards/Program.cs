// See https://aka.ms/new-console-template for more information
using Services.ScratchCardBuilder;
using Services.ScratchCardEvaluator;

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

var sumOfPoints = 0.0;
foreach (var card in cards)
{
    sumOfPoints += ScratchCardEvaluator.GetPoints(card);
}

var pileOfCards = ScratchCardEvaluator.GetDuplicates(cards);

var sumOfCopies = 0;
foreach (var card in pileOfCards)
{
    sumOfCopies += card.Copies;
}

Console.WriteLine("The sum of all card game points was found to be: " + sumOfPoints);
Console.WriteLine("The sum of all duplicates was found to be: " + sumOfCopies);