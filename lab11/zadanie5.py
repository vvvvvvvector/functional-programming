def naturals():
    n = 1
    while True:
        yield n
        n += 1


print(next(naturals()))
