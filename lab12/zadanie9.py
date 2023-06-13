from itertools import chain

file = open("numbers.txt", "r")


# def numbers(file):
#     for line in file:
#         line = line.split()
#         for number in line:
#             yield int(number)

def numbers(file):
    return map(int, chain(*map(str.split, file)))


x = numbers(file)

print(next(x))

file.close()
