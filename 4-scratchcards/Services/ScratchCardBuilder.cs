using System;
using System.Dynamic;
using System.IO;

namespace Services.ScratchCardBuilder;

public class ScratchCardBuilder
{
    private ScratchCard? ScratchCard { get; set; }

    public ScratchCardBuilder() 
    {
        Reset();
    }

    public void Reset()
    {
        this.ScratchCard = new ScratchCard();
    }

    public static ScratchCard Build(string cardString) => 
        new ScratchCard(ParseCardId(cardString), ParseWinningNumbers(cardString), ParseUserNumbers(cardString));

    private static int ParseCardId(string cardString) => int.Parse(GetCardString(cardString).Replace("Card ", ""));

    private static List<int> ParseWinningNumbers(string cardString) => NumbersStringToList(GetWinningNumbers(cardString));

    private static List<int> ParseUserNumbers(string cardString) => NumbersStringToList(GetUserNumbers(cardString));

    private  static string[] SplitCard(string cardString) => cardString.Split(": ");

    private static string GetCardString(string cardString) => SplitCard(cardString)[0].Trim();

    private static string GetNumberString(string cardString) => SplitCard(cardString)[1];

    private static string[] SplitNumbers(string numberString) => numberString.Split(" | ");

    private static string GetWinningNumbers(string cardString) => SplitNumbers(GetNumberString(cardString))[0];

    private static string GetUserNumbers(string cardString) => SplitNumbers(GetNumberString(cardString))[1];
    private static List<int> NumbersStringToList(string numbersString)
    {
        var numbersList = new List<int>();
        var numbersArray = numbersString.Split(" ", StringSplitOptions.RemoveEmptyEntries);

        foreach(var stringNumber in numbersArray)
        {
            numbersList.Add(int.Parse(stringNumber));
        }

        return numbersList;
    }
}

public class ScratchCard
{
    public int Id { get; }

    public List<int> WinningNumbers { get; }

    public List<int> UserNumbers { get; }

    public int Copies { get; set; }

    public ScratchCard()
    {
        WinningNumbers = new List<int>();
        UserNumbers = new List<int>();
    }

    public ScratchCard(int id, List<int> winningNumbers, List<int> userNumbers, int copies=1)
    {
        Id = id;
        WinningNumbers = winningNumbers;
        UserNumbers = userNumbers;
        Copies = copies;
    }

    public ScratchCard DeepClone()
    {
        var winningNumbers = new List<int>();
        foreach (var number in WinningNumbers)
        {
            winningNumbers.Add(number);
        }

        var userNumbers = new List<int>();
        foreach (var number in UserNumbers)
        {
            userNumbers.Add(number);
        }

        return new ScratchCard(Id, winningNumbers, userNumbers, Copies);
    }

    public override string ToString()
    {
        var cardId = $"Card ID: {Id}";
        var winningNumbers = "\tWinning Numbers: ";
        foreach (var number in WinningNumbers)
        {
            winningNumbers += $"{number} ";
        }

        var userNumbers = "\tUser Numbers: ";
        foreach (var number in UserNumbers)
        {
            userNumbers += $"{number} ";
        }

        var copies = $"Copies {Copies}";

        return $"{cardId}{winningNumbers}{userNumbers}{copies}";
    }
}