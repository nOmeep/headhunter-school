from unittest import TestCase

from ex1 import build_roles_tree
from ex1.mapping import RAW_MAPPING, ROLES_TREE


class TestRolesTree(TestCase):
    def test_build_roles_tree(self):
        tree = build_roles_tree(RAW_MAPPING)
        self.assertEqual(tree, ROLES_TREE)
