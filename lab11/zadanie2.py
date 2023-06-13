def add(x, y):
    return x + y


def add_tuple(tup):
    x, y = tup
    return x + y


def curry(func):
    def inner(x, y):
        return func((x, y))

    return inner


def uncarry(func):
    def inner(tup):
        arg1, arg2 = tup
        return func(arg1, arg2)

    return inner


curried_add_tuple = curry(add_tuple)
uncurried_add = uncarry(add)

print(curried_add_tuple(500, 600))
print(uncurried_add((500, 1000)))
