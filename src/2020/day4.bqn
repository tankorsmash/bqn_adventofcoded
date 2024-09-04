data ← •file.Lines "../../samples/2020/day4.txt"
# data ← •file.Lines "../../inputs/2020/day4.txt"

# numbers ← •ParseFloat¨ data


entry_length ←(≠⊑data)
# array ← entry_length‿↑ ⥊ data
array ← data

