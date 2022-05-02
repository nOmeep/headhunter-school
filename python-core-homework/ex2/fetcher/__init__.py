import random
import time


def get(url):
    print(f'Fetching {url}...')
    time.sleep(random.random())
    print('Done')
