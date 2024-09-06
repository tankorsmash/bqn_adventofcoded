data ← •file.Lines "../../samples/2020/day4.txt"
# data ← •file.Lines "../../inputs/2020/day4.txt"

# numbers ← •ParseFloat¨ data

•Show « 1‿2‿3

SplitBy ← (+`∘=⊔⊢)
# •Show data
•Show "lengths"‿(≠¨ data)
•Show mask ← ¬ 0= ≠¨ data

•Show "---"
•Show "mask"‿mask
•Show grouped_idxs ← 0 ((+`∘=){ 𝕨⊔↕≠𝕩 }⊢) ¬ 0= ≠¨ data
•Show grouped_data ← {𝕩⊏data}˘¨ grouped_idxs
•Show "rank"‿(=grouped_data)‿"shape"‿(≢grouped_data)‿"length"‿(≠grouped_data)

•Show "@@@@@@@"

TrimSpace ← (∨`' '⊸≠)⊸/
PerLine ← •Show  ' 'SplitBy (TrimSpace( { 𝕨∾" "∾𝕩 }´ {¬0=≠}/⊢ ))
(•Show TrimSpace¨)¨ (PerLine)¨ grouped_data

•Show "---"
# •Show  ⊣˜⊸/¨ 1/¨ 0 SplitBy ¬0=≠¨ data

# •Show data

