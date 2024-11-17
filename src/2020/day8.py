
data = open('./samples/2020/day8.txt').readlines()
data = open('./inputs/2020/day8.txt').readlines()

data = [x.strip().replace("+", "").split(" ") for x in data]
data = [(x[0], int(x[1])) for x in data]

def parse(cmd, val):
    if cmd == "acc":
        return (1, val)
    elif cmd == "jmp":
        return (val, 0)
    else:
        return (1, 0)

print(data)

idx = 0
acc = 0

visited = set()
while idx not in visited:
    visited.add(idx)
    cmd, val = data[idx]
    inc, acc_inc = parse(cmd, val)
    idx += inc
    acc += acc_inc

print("Part 1:", acc)
