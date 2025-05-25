items = [1, 2, 3]

for i in items:
    print(i)


def myfunc(x: int) -> str:
    "this is a docstring yuhhh"
    return f"this is my num {x}"


def myfunc2():
    pass


print(myfunc(4))

print(myfunc(5))
