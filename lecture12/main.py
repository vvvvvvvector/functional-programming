# dekorator - funkcja, która przyjmuje funkcję jako argument i zwraca przeksztalconą funkcję

class A:
    def __init__(self, val):
        self._val = val

    @staticmethod
    def f(b, a):
        return b + a

    @property
    def val(self):
        return self._val


# def to_str(func):
#     def inner(*args):
#         return str(func(*args))

#     return inner

def to_str(first_arg):
    def inner1(func):
        def inner2(*args):
            return first_arg + str(func(*args)) + first_arg

        return inner2

    return inner1


@to_str(' *** ')
def func(x, y):
    return x + y + 5


print(A.f(1, 2))
print(func(1, 2))
