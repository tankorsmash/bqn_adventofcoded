data ← •file.Lines "../../samples/2020/day4.txt"
# data ← •file.Lines "../../inputs/2020/day4.txt"

# numbers ← •ParseFloat¨ data


•Show ≠¨ data
•Show ¬0=≠¨ data
•Show  { ⊣˜𝕩 }⊸/¨  1/¨ 0(+`∘=⊔⊢) ¬0=≠¨ data
# •Show data

