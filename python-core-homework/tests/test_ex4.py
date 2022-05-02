import types
from unittest import TestCase

from ex4 import cross_join
from ex4.data import EMPLOYEES, DEPARTMENTS, CROSS_JOIN_RESULT


class TestCrossJoin(TestCase):
    def test_cross_join(self):
        result = cross_join(EMPLOYEES, DEPARTMENTS)
        self.assertTrue(isinstance(result, types.GeneratorType), 'Functions should return generator object')
        self.assertListEqual(sorted(CROSS_JOIN_RESULT), sorted(list(result)), 'Lists should match')
