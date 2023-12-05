class BagODice:
    red : int
    green : int
    blue : int

    def __init__(self, inputArgs):
        """
        Create a bag o' dice. Specify the amount of red, green and blue dice that go in the bag.
        """
        dice = {}
        for arg in inputArgs:
            color = arg.split('=')[0]
            count = arg.split('=')[1]
            dice[color] = count
            
        self.red = int(dice['red'])
        self.green = int(dice['green'])
        self.blue = int(dice['blue'])

    def __str__(self):
        """ String representation. """
        return f"In da bag: red - {self.red} green - {self.green} blue - {self.blue}"
