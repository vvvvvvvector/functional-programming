def partial(func, x):

    def inner(y):
        return func(x, y)

    return inner


add_number = partial(lambda x, y: x + y, 100)

print(add_number(400))
