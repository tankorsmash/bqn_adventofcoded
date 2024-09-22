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

field_names ← ⟨"byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"⟩
fields_no_cid ← ((¬"cid"⊸≡)¨/⊢)field_names

SplitBy ← (+`∘=⊔⊢)
# •Show ' 'SplitBy "a b c   d"



RemoveSpaceOnlyLists ← (∨`' '⊸≠)⊸/
RemoveSpaces ← (' '⊸≠)⊸/

# takes a list of strings and returns a single group of strings without spaces
GatherPassports ← {
	JoinWithSpace ← {𝕨∾ " "∾𝕩}´
	Foo ← RemoveSpaceOnlyLists JoinWithSpace
	RemoveSpaces¨ ' 'SplitBy Foo 𝕩
}


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

 starts_with_hash ← {0≠≠𝕩 ? '#'=⊑𝕩 ; 0}𝕩
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
eye_colors ← ⟨"amb", "blu", "brn", "gry", "grn", "hzl", "oth"⟩
IsValidEcl ← ∊⟜eye_colors⌾<
ecl_asserts ← {
	"expected ECL amb  to be valid" !   IsValidEcl "amb"
	"expected ECL ambb to be valid" !¬  IsValidEcl "ambb"
	"expected ECL wat  to be false" !¬	IsValidEcl "wat"
	"expected ECL oth  to be valid" ! 	IsValidEcl "oth"
}

#PID
IsValidPid ← ∧´∊⟜(∾"0"+⟜↕¨10)∧(9=≠)
# •Show IsValidPid "123456789"
pid_asserts ← {
	"expected PID 000000001  to be valid" !  IsValidPid "000000001"
	"expected PID 0123456789 to be false" !¬ IsValidPid "0123456789"
	"expected PID 123456789  to be valid" !  IsValidPid "123456789"
	"expected PID 1234567890 to be false" !¬ IsValidPid "1234567890"
	"expected PID 000000000  to be valid" !  IsValidPid "000000000"
}

#CID
# ignored, missing or not

byr_asserts ← {
	"expected BYR 1919 is wrong" !¬ IsValidByr "1919"
	"expected BYR 1920 is valid" !  IsValidByr "1920"
	"expected BYR 1921 is valid" !  IsValidByr "1921"

	"expected BYR 2002 is valid" !  IsValidByr "2002"
	"expected BYR 2003 is wrong" !¬ IsValidByr "2003"
}

validators ← (0⊸⊏˘ •Hashmap 1⊸⊏˘)[
	"byr"‿IsValidByr, "iyr"‿IsValidIyr, "eyr"‿IsValidEyr,
	"hgt"‿IsValidHgt, "hcl"‿IsValidHcl, "ecl"‿IsValidEcl,
	"pid"‿IsValidPid
]


Taker ← ⥊{ 𝕨⊏𝕩 }¨
PerRawPassport ← {
	("takes lists of pairs"⊸! 2⊸≡≢>)˘ 𝕩
	PerPair ← {
		key‿value ←  ⥊ 𝕩
		# •Show key‿(':'⊸≠⊸/value)
		key
	}
	PerEntryGroup ← {
		PerPair 𝕩
	}
	rows ← ⥊⚇¯1𝕩

	keys ← >(0⊸Taker rows)
	sorted_keys ← ∨ keys

	values ← (1⊸Taker rows)
	mapped_passport ← (keys •Hashmap values)

	FieldValid ← {
		field ← 𝕩
		# TODO: remove mapped_passport
		# dropping 1, because SplitBy leaves the split value in the non-first parts
		stripped_value ← 1↓ mapped_passport.Get  field
		validator ← validators.Get field
		is_valid ← Validator stripped_value
		# •Show field‿stripped_value‿is_valid
	}


	has_enough_keys ← (∨fields_no_cid) ≡ ((¬"cid"⊸≡)¨/⊢) sorted_keys

	{ has_enough_keys ?
		{ fields_valid ← ∧´ FieldValid¨ fields_no_cid
		}
		; 0
	}

}

grouped_idxs ← 0 ((+`∘=){ 𝕨⊔↕≠𝕩 }⊢) ¬ 0= ≠¨ data
grouped_data ← {𝕩⊏data}˘¨ grouped_idxs
# •Show (⊏grouped_data)

raw_passports ← GatherPassports¨ grouped_data
# TODO: figure out the reason why they're all nested and we need to > them.
raw_parsed_passports ←  (( ':'⊸SplitBy¨ ' '⊸SplitBy)¨)¨ raw_passports


# mapped_passport ←  (0⊸Taker •Hashmap (1⊸Taker)) ⥊ ⊑raw_parsed_passports
# •Show mapped_passport.Keys mapped_passport

•Show (PerRawPassport>)¨ raw_parsed_passports

