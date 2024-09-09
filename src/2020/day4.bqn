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
# •Show "grouped_data"‿grouped_data
•Show "rank"‿(=grouped_data)‿"shape"‿(≢grouped_data)‿"length"‿(≠grouped_data)

•Show "@@@@@@@"

RemoveSpaceLists ← (∨`' '⊸≠)⊸/
RemoveSpaces ← (' '⊸≠)⊸/
PerLine ← {
	# what does Foo do?
	Foo ← RemoveSpaceLists ( {𝕨∾ " "∾𝕩}´ {¬0=≠}/⊢ )
	•Show RemoveSpaces¨ ' 'SplitBy Foo 𝕩
}
(•Show RemoveSpaceLists¨)¨ (PerLine)¨ grouped_data

•Show "---"
# •Show  ⊣˜⊸/¨ 1/¨ 0 SplitBy ¬0=≠¨ data

# •Show data

