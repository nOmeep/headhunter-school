from ex2 import fetcher
import time

CALL_COUNT = 10


def benchmark(num):
    def wrapper(func):
        def decorator(url):
            result_time = 0

            for i in range(0, num):
                start_time = time.time()
                func(url)
                end_time = time.time()

                time_taken = end_time - start_time
                result_time += time_taken

                print(time_taken)
            print(result_time / num)

        return decorator

    return wrapper


@benchmark(CALL_COUNT)
def fetch_page(url):
    fetcher.get(url)
