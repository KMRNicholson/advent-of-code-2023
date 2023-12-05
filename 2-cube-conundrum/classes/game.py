import sys

class GameSet:
    red: int
    gree: int
    blue: int

    def __init__(self, red = 0, green = 0, blue = 0):
        """
        Create a game set, which is a number of dice which were "pulled" from the bag o dice.
        """
        self.red = int(red)
        self.green = int(green)
        self.blue = int(blue)

    def __str__(self):
        """
        Return the result of a game set.
        """
        return f"GameSet: red: {self.redCount}, green: {self.greenCount}, blue: {self.blueCount}"


class Game:
    id : int
    gameSets : str

    def __init__(self, id, gameSets):
        """
        Creates a dice game.
        """
        self.id = id
        self.gameSets = self.parseGameSets(gameSets)
    
    def parseGameSets(self, gameSets):
        """
        Returns an array of GameSets.
        """
        setList = gameSets.split(';')

        parsedGameSets = []
        for gameSet in setList:
            setData = gameSet[1:len(gameSet)].split(', ')
            
            colors = { 'red': 0, 'green': 0, 'blue': 0 }
            for colorData in setData:
                data = colorData.split(' ')
                count = data[0]
                color = data[1]
                colors[color] = count

            parsedGameSets += [ GameSet(colors['red'], colors['green'], colors['blue']) ]

        return parsedGameSets
    
    def isValid(self, scannedDice):
        """
        Validates a game based on how many dice were scanned from the bag
        """

        maxRed = int(scannedDice['red'])
        maxBlue = int(scannedDice['blue'])
        maxGreen = int(scannedDice['green'])

        print(f"Game {self.id}:")
        for gameSet in self.gameSets:
            print(f"Elf pulls out {gameSet.red} red, {gameSet.green} green, and {gameSet.blue} blue dice, then puts them back")
            if(gameSet.red > maxRed or gameSet.green > maxGreen or gameSet.blue > maxBlue):
                print("Impossible, the elf must have cheated!")
                return False
        
        return True
    
    def getPower(self):
        """
        Calculates power of the game, based on the product of the fewest number of each colored die to make a game possible
        """

        minRed = 0
        minBlue = 0
        minGreen = 0
        print(f"Game {self.id}:")
        for gameSet in self.gameSets:
            minRed = gameSet.red if gameSet.red > minRed else minRed
            minBlue = gameSet.blue if gameSet.blue > minBlue else minBlue
            minGreen = gameSet.green if gameSet.green > minGreen else minGreen
            
        
        return minRed * minBlue * minGreen

    def __str__(self):
        """ String representation. """
        return f"Game id: {self.id}  \nGame sets: {self.gameSets}"