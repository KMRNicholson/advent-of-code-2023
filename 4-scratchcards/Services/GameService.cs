using System;
using System.IO;

namespace Services.GameService;

class GameService
{
    public string FilePath { get; }

    public List<string> GetRawData => File.ReadLines(FilePath).ToList<string>();

    public GameService(string gameInputPath)
    {
        FilePath = gameInputPath;
    }

    public List<Dictionary<string, string>> GetGames()
    {
        var games = new List<Dictionary<string, string>>();
        
        return games;
    }

    private Dictionary<string, string> ParseGameFromString(string gameString)
    {
        var game = new Dictionary<string, string>();


        return game;
    }
}