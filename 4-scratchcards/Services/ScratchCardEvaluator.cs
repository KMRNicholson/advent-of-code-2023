using System;
using System.Dynamic;
using System.IO;
using Services.ScratchCardBuilder;

namespace Services.ScratchCardEvaluator;

public class ScratchCardEvaluator
{
    public ScratchCardEvaluator() 
    {
    }

    public static int GetMatches(ScratchCard card)
    {
        var matches = 0;

        foreach (var userNumber in card.UserNumbers)
        {
            if(card.WinningNumbers.Contains(userNumber))
            {
                matches++;
            }
        }

        return matches;
    }

    public static double GetPoints(ScratchCard card, int baseNumber = 2)
    {
        double points = 0;
        var matches = GetMatches(card);

        if (matches > 0)
            points = Math.Pow(baseNumber, matches - 1);

        return points;
    }

    public static List<ScratchCard> GetDuplicates(List<ScratchCard> cards)
    {
        var newList = new List<ScratchCard>();
        for (int i = 0; i < cards.Count; i++)
        {
            var card = cards[i].DeepClone();

            var copyCount = GetMatches(card);

            if(copyCount + card.Id > cards.Count)
            {
                copyCount = cards.Count - card.Id;
            }

            for (int j = i; j < copyCount + i; j++)
            {
                cards[j+1].Copies += card.Copies;
            }

            newList.Add(card);
        }

        return newList;
    }
}