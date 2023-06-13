import math


def compose(func1, func2):
    def inner(x):
        return func1(func2(x))

    return inner


f = compose(lambda x: x + 1, lambda x: x ** 2)

print(f(5))
print(compose(math.sqrt, int)('2'))


def compose2(*funcs):
    def inner(x):
        for func in reversed(funcs):
            x = func(x)
        return x

    return inner
