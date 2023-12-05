import sys

from classes.bagodice import BagODice
from classes.xrayglasses import XRayGlasses
from classes.game import Game

inputFilePath = str(sys.argv[1])
inputFile = open(inputFilePath)
games = inputFile.readlines()
inputFile.close()

diceArgs = str(sys.argv[2]).split(',')
bagODice = BagODice(diceArgs)

print (f"The elf puts {bagODice.red} red, {bagODice.green} green, and {bagODice.blue} blue dice into a bag.")

xray = XRayGlasses(bagODice)

print(f"You put on your xray glasses and target the bag, to ensure no funny business. Let the games begin!")

bagContents = xray.scanBag()

gameIdSum = 0
gamePowerSum = 0
for line in games:
    gameData = line.split(':')
    id = gameData[0].replace('Game ', '')
    gameSets = gameData[1].replace('\n', '')
    game = Game(id, gameSets)
    
    if(game.isValid(bagContents)):
        gameIdSum += int(game.id)

    gamePowerSum += game.getPower()

print(f"Game id sum of possible games: {gameIdSum}")
print(f"Game power sum {gamePowerSum}")
