class BaseAction:
    def __init__(self, name):
        self.name = name

    def __repr__(self):
        return self.name

    def __eq__(self, other):
        return self.name == other.name

    def __hash__(self):
        return hash(self.name)


class NothingAction(BaseAction):
    def __init__(self):
        super().__init__('Nothing')


class RockAction(BaseAction):
    def __init__(self):
        super().__init__('Rock')

    def __gt__(self, other):
        return other.name == 'Scissors'


class PaperAction(BaseAction):
    def __init__(self):
        super().__init__('Paper')

    def __gt__(self, other):
        return other.name == 'Rock'


class ScissorsAction(BaseAction):
    def __init__(self):
        super().__init__('Scissors')

    def __gt__(self, other):
        return other.name == 'Paper'
