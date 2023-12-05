from classes.bagodice import BagODice

class XRayGlasses:
    target : BagODice

    def __init__(self, bagODice):
        """
        Create xray glasses for targetting a bag o dice.
        """
        self.target = bagODice

    def scanBag(self):
        """
        Scan the contents of a bag of dice, returns the amount of each color as a triplet
        """

        print(f"You can the contents of the bag and see {self.target.red} red, {self.target.green} green, {self.target.blue} blue dice")
        return { 'red': self.target.red, 'blue': self.target.blue, 'green': self.target.green }
