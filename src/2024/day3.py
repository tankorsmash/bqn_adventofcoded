from icecream import ic
# sample_alt = """xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"""
# line =  sample_alt

part2 = 0
# with open("./samples/2024/day3_alt.txt") as f:
with open("./inputs/2024/day3.txt") as f:
    for line in f.readlines():
        # ic("---")
        line = line.strip()

        # ic(line)

        prods = []

        allowed_chars = "0123456789,()"

        for i, char in enumerate(line):
            if line[i] == 'm' and line[i+1] == 'u' and line[i+2] == 'l' and line[i+3] == '(':
                # prods.append(i)
                rng = line.index(')', i)

                grabbed = line[i:rng][4:]

                if any(char not in allowed_chars for char in grabbed):
                    continue
                x,y = [int(s) for s in grabbed.split(",")]

                # ic(i, [int(s) for s in grabbed.split(",")])
                prods.append((i, (x*y)))
                # ic(i, x*y)

        # ic("part1", sum(prod for i, prod in prods))

        dos = []
        donts = []
        for i, char in enumerate(line):
            if line[i] == 'd' and line[i+1] == 'o' and line[i+2] == '(' and line[i+3] == ')':
                dos.append(i)
            if line[i] == 'd' and line[i+1] == 'o' and line[i+2] == 'n' and line[i+3] == '\'' and line[i+4] == 't' and line[i+5] == '(' and line[i+6] == ')':
                donts.append(i)


        doing = True
        mask = []
        for i in range(len(line)):
            if i in dos:
                doing = True
            if i in donts:
                doing = False
            # ic(doing)
            mask.append(doing)
        # ic(dos)
        # ic(donts)
        # ic(mask)

        line_part2 = 0
        for i, prod in prods:
            if mask[i]:
                # ic(i, prod)
                # prods.append((i, prod))
                line_part2 += prod
        part2 += line_part2

    ic("part2", part2)



