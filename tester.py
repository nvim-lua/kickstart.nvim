items = [1, 2, 3]
print([x**2 for x in items])
print([x**3 for x in items])

for i in items:
    print(i)


def myfunc(x: int) -> str:
    'this is a docstring yuhhh'
    return f"this is my num {x}"


def myfunc2():
        pass

print(myfunc(2))
print(myfunc(3))

print(myfunc(5)) 
