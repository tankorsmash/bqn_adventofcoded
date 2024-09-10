# data ← •file.Lines "../../samples/2020/day4.txt"
data ← •file.Lines "../../inputs/2020/day4.txt"

# numbers ← •ParseFloat¨ data

# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)

field_names ← ⟨"byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"⟩
fields_no_cid ← ((¬"cid"⊸≡)¨/⊢)field_names

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

# takes a list of strings and returns a single group of strings without spaces
GatherPassports ← {
	JoinWithSpace ← {𝕨∾ " "∾𝕩}´
	Foo ← RemoveSpaceOnlyLists JoinWithSpace
	RemoveSpaces¨ ' 'SplitBy Foo 𝕩
}
raw_passports ← GatherPassports¨ grouped_data
•Show "---"

raw_parsed_passports ← (( ':'⊸SplitBy¨ ' '⊸SplitBy)¨)¨ raw_passports
PerRawPassport ← {
	PerPair ← {
		key‿value ← 𝕩
		# •Show key‿(':'⊸≠⊸/value)
		key
	}
	PerEntryGroup ← {
		PerPair¨ 𝕩
	}
	sorted_keys ← ∨ ∾´ PerEntryGroup¨ 𝕩

	(∨fields_no_cid) ≡ ((¬"cid"⊸≡)¨/⊢)sorted_keys
}
•Show +´ PerRawPassport¨ raw_parsed_passports
# •Show  ⊣˜⊸/¨ 1/¨ 0 SplitBy ¬0=≠¨ data

IsValidByrNum ← 1920⊸≤∧≤⟜2002
IsValidByrLen ← 4⊸=≠
IsValidByr ← {
	correct_len ← 4=≠𝕩
	correct_len ∧ IsValidByrNum (•ParseFloat⎊(-2˙)) 𝕩
}

byr_asserts ← {
	"expected BYR 1919 is wrong" !¬ IsValidByr "1919"
	"expected BYR 1920 is valid" !  IsValidByr "1920"
	"expected BYR 1921 is valid" !  IsValidByr "1921"

	"expected BYR 2002 is valid" !  IsValidByr "2002"
	"expected BYR 2003 is wrong" !¬ IsValidByr "2003"
}


# •Show data

