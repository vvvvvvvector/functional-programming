def print_debug(func):
    def wrapper(*args):
        result = func(*args)

        print(f'{func.__name__}({", ".join(map(repr, args))}) = {result}')

        return result

    return wrapper


@print_debug
def fib(n):
    if n == 0 or n == 1:
        return n
    return fib(n - 1) + fib(n - 2)
