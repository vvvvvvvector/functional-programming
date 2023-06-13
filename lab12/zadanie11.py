def print_debug(sep=' = '):
    def print_debug_in(func):
        def wrapper(*args, **kwargs):
            result = func(*args, **kwargs)

            print(f'{func.__name__}({", ".join(map(repr, args))}) = {result}')

            return result

        return wrapper

    return print_debug_in
