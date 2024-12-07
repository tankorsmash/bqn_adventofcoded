part2 = 0
with open("./inputs/2024/day3.txt") as f:
    doing = True
    for line in f.readlines():
        line = line.strip()

        prods = []

        allowed_chars = "0123456789,()"

        for i, char in enumerate(line):
            if line[i] == 'm' and line[i+1] == 'u' and line[i+2] == 'l' and line[i+3] == '(':
                rng = line.index(')', i)

                grabbed = line[i:rng][4:]

                if any(char not in allowed_chars for char in grabbed):
                    continue
                x,y = [int(s) for s in grabbed.split(",")]

                prods.append((i, (x*y)))

        dos = []
        donts = []
        for i, char in enumerate(line):
            if line[i] == 'd' and line[i+1] == 'o' and line[i+2] == '(' and line[i+3] == ')':
                dos.append(i)
            if line[i] == 'd' and line[i+1] == 'o' and line[i+2] == 'n' and line[i+3] == '\'' and line[i+4] == 't' and line[i+5] == '(' and line[i+6] == ')':
                donts.append(i)


        mask = []
        for i in range(len(line)):
            if i in dos:
                doing = True
            if i in donts:
                doing = False
            mask.append(doing)

        line_part2 = 0
        for i, prod in prods:
            if mask[i]:
                line_part2 += prod
        part2 += line_part2

    print("part2", part2)



