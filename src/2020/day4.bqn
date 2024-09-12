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
# •Show +´ PerRawPassport¨ raw_parsed_passports

# •Show  ⊣˜⊸/¨ 1/¨ 0 SplitBy ¬0=≠¨ data

ParseNum ← •ParseFloat⎊(-2˙)

#BYR
IsValidByrNum ← 1920⊸≤∧≤⟜2002
IsValidByr ← {
	correct_len ← 4=≠𝕩
	correct_len ∧ IsValidByrNum ParseNum 𝕩
}

#IYR
IsValidIyrNum ← 2010⊸≤∧≤⟜2020
IsValidIyr ← {
	correct_len ← 4=≠𝕩
	correct_len ∧ IsValidIyrNum ParseNum 𝕩
}

#EYR
IsValidEyrNum ← 2020⊸≤∧≤⟜2030
IsValidEyr ← {
	correct_len ← 4=≠𝕩
	correct_len ∧ IsValidEyrNum ParseNum 𝕩
}

# keep only digits, anywhere in the string
# "a1b2c3" -> "123"
KeepDigits ← ∊⟜('0'+↕10)⊸/

#HGT
IsValidHgtInches ← 59⊸≤∧≤⟜76
IsValidHgtCm ← 150⊸≤∧≤⟜193
IsValidHgt ← {
	contains_inches ← ∨´(≠"in")≠"in"⊐𝕩
	contains_cm ← ∨´(≠"cm")≠"cm"⊐𝕩
	digits ← KeepDigits 𝕩
	# •Show "ASD"‿contains_cm‿contains_inches‿(contains_inches ∧ (IsValidHgtInches 𝕩))
	{
	contains_inches ? IsValidHgtInches •ParseFloat KeepDigits 𝕩;
	contains_cm ? IsValidHgtCm •ParseFloat KeepDigits 𝕩;
		0
	}𝕩
}

hgt_asserts ← {
	"expected HGT 58in is false"  !¬ IsValidHgt "58in"
	"expected HGT 59in is valid"  !  IsValidHgt "59in"
	"expected HGT 76in is valid"  !  IsValidHgt "76in"
	"expected HGT 77in is false"  !¬ IsValidHgt "77in"

	"expected HGT 149cm is false" !¬ IsValidHgt "149cm"
	"expected HGT 150cm is valid" !  IsValidHgt "150cm"
	"expected HGT 193cm is valid" !  IsValidHgt "193cm"
	"expected HGT 194cm is valid" !¬ IsValidHgt "194cm"
}

IsAllowedHclChars ← ∧´∊⟜(∾"0a"+⟜↕¨10‿6)
IsValidHcl ← {

 starts_with_hash ← '#'=⊑𝕩
 "type"‿(•Type starts_with_hash)

#  •Show 50/"_"
 nonhash_chars ← (¬∊)⟜"#"⊸/𝕩
 is_length_correct ← 6=≠nonhash_chars
 only_valid_chars ← IsAllowedHclChars nonhash_chars
 starts_with_hash
#  •Show 50/"-"

 is_length_correct ∧ only_valid_chars ∧ starts_with_hash
}

#HCL
hcl_asserts ← {
	"expected HCL #123abc  to be valid"          !  IsValidHcl "#123abc"
	"expected HCL #abc123  to be valid"          !  IsValidHcl "#abc123"
	"expected HCL #111111  to be valid"          !  IsValidHcl "#111111"
	"expected HCL #aaaaaa  to be valid"          !  IsValidHcl "#aaaaaa"
	"expected HCL #123abz  to be false (z char)" !¬ IsValidHcl "#123abz"
	"expected HCL 123abc   to be false (no hash)"!¬ IsValidHcl "123abc"
	"expected HCL #123ab   to be false (no char)"!¬ IsValidHcl "#123ab"
	"expected HCL #123abcd to be false (length)" !¬ IsValidHcl "#123abcd"
	"expected HCL #123abce to be false (length)" !¬ IsValidHcl "#123abce"
}

#ECL
# TODO

#PID
# TODO

#CID
# TODO

byr_asserts ← {
	"expected BYR 1919 is wrong" !¬ IsValidByr "1919"
	"expected BYR 1920 is valid" !  IsValidByr "1920"
	"expected BYR 1921 is valid" !  IsValidByr "1921"

	"expected BYR 2002 is valid" !  IsValidByr "2002"
	"expected BYR 2003 is wrong" !¬ IsValidByr "2003"
}


# •Show data

