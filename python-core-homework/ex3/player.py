from ex3.available_actions import NOTHING_ACTION


class Player:
    def __init__(self, name, action=None):
        self.name = name
        self.action = action or NOTHING_ACTION

    def __str__(self):
        return self.name

    def __repr__(self):
        return f'{self.name}:{self.action}'
