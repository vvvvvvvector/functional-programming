def myZipWith(func, it1, it2): return [func(*tp1) for tp1 in zip(it1, it2)]


print(list(myZipWith(lambda x, y: x ** y, [1, 5, 3], [4, 3, 2])))


def unzip(it):
    return zip(*it)


print(list(
    unzip(zip(['Lublin', 'Warszawa', 'Świdnik'], (334_681, 1_863_056, 39_136)))))
