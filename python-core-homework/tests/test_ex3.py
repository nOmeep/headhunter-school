from unittest import TestCase

from ex3 import determine_winner
from ex3.action import RockAction, PaperAction, ScissorsAction
from ex3.available_actions import ROCK_ACTION, SCISSORS_ACTION, PAPER_ACTION
from ex3.player import Player


class TestGame(TestCase):
    def test_base_game_mechanics(self):
        bob = Player('Bob', ROCK_ACTION)
        alice = Player('Alice', SCISSORS_ACTION)
        winner = determine_winner(bob, alice)
        self.assertEqual(bob, winner, f'{bob} should win')

        bob.action = PAPER_ACTION
        winner = determine_winner(bob, alice)
        self.assertEqual(alice, winner, f'{alice} should win')

    def test_edge_cases(self):
        bob = Player('Bob')
        alice = Player('Alice', SCISSORS_ACTION)
        winner = determine_winner(bob, alice)
        self.assertEqual(None, winner, 'Bob select Nothing. Should not be able to determine winner')

        bob.action = SCISSORS_ACTION
        winner = determine_winner(bob, alice)
        self.assertEqual(None, winner, 'Same Actions. Should not be able to determine winner')

    def test_actions(self):
        match = PaperAction() == PaperAction() and ScissorsAction() == ScissorsAction() and RockAction() == RockAction()
        self.assertEqual(True, match, 'Same actions should match')

        available_actions = {
            PaperAction(), PaperAction(), RockAction(), RockAction(), ScissorsAction(), ScissorsAction()
        }
        self.assertEqual(len(available_actions), 3, 'Same actions should have same hash')
