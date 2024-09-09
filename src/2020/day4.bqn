data ← •file.Lines "../../samples/2020/day4.txt"
# data ← •file.Lines "../../inputs/2020/day4.txt"

# numbers ← •ParseFloat¨ data

# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)

field_names ← ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]

SplitBy ← (+`∘=⊔⊢)
# •Show data
# •Show "lengths"‿(≠¨ data)
mask ← ¬ 0= ≠¨ data

mask
grouped_idxs ← 0 ((+`∘=){ 𝕨⊔↕≠𝕩 }⊢) ¬ 0= ≠¨ data
grouped_data ← {𝕩⊏data}˘¨ grouped_idxs
# •Show "grouped_data"‿grouped_data


RemoveSpaceOnlyLists ← (∨`' '⊸≠)⊸/
RemoveSpaces ← (' '⊸≠)⊸/

PerLine ← {
	JoinWithSpace ← {𝕨∾ " "∾𝕩}´
	Foo ← RemoveSpaceOnlyLists JoinWithSpace
	RemoveSpaces¨ ' 'SplitBy Foo 𝕩
}
per_lined ← PerLine¨ grouped_data

•Show "---"

•Show per_lined
# •Show  ⊣˜⊸/¨ 1/¨ 0 SplitBy ¬0=≠¨ data

# •Show data

