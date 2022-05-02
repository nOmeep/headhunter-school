from unittest import TestCase
from unittest.mock import patch

from ex2 import fetch_page, CALL_COUNT


@patch('ex2.fetcher.get')
class TestFetchPage(TestCase):
    def test_argument(self, fetcher_mock):
        fetch_page('https://google.com')
        self.assertEqual('https://google.com', fetcher_mock.call_args.args[0])

    def test_call_count(self, fetcher_mock):
        fetch_page('https://google.com')
        self.assertEqual(fetcher_mock.call_count, CALL_COUNT)
