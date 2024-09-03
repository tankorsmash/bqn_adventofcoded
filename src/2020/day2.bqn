# data ← •file.Lines "../../samples/2020/day2.txt"
data ← •file.Lines "../../inputs/2020/day2.txt"

# numbers ← •ParseFloat¨ data

Split ←{
	MinusSelf ← -˜
	Sum ← +`
	Foo ← Sum × ¬
	Bar ← (⊢ MinusSelf Foo)
	EqualThenBar ← Bar∘=
	𝕨(EqualThenBar ⊔ ⊢)𝕩
}

Part1IsValid ← {
	# •Show 𝕩
	raw_range‿raw_char‿raw_input ← ' 'Split 𝕩

	min_range‿max_range ← •ParseFloat ¨ '-'Split raw_range

	char ← ⟨⊑ raw_char⟩
	matching_chars ←+´¬char⊐raw_input

	valid_password ← (min_range≤matching_chars)∧ ( max_range≥matching_chars)

	valid_password
	⟨min_range, max_range, char, raw_input, "valid_password?:", valid_password⟩
	# •Out "---"

	valid_password
}

# part_1 ← +´Part1IsValid ¨data
# •Show part_1

Part2IsValid ← {
	raw_range‿raw_char‿raw_input ← ' 'Split 𝕩

	first_index‿last_index ← •ParseFloat ¨ '-'Split raw_range

	char ← ⟨⊑ raw_char⟩
	left_match ← char= {(first_index-1)⊑𝕩}⎊{0}raw_input
	right_match ← char= {(last_index-1)⊑𝕩}⎊{0}raw_input
	valid_password ← left_match ≠ right_match

	# •Show ⟨first_index, last_index, char, raw_input, "valid_password?:", valid_password⟩

	valid_password
}

part_2 ← +´Part2IsValid ¨data
•Show part_2

min ← 1
max ← 3
# number ← 13
char ← "a"
# •Show 1+min+↕(max - min)

input ← "zaabca"

left_match ← char= {min⊑𝕩}⎊{0}input
right_match ← char= {max⊑𝕩}⎊{0}input

# •Show ⟨ "left", left_match, "right", right_match ⟩
# •Show left_match ≠ right_match

# •Show "zaabca"
# •Show +´0="a"⊐"zabc"



# •Show number>min
# •Show number<max
# •Show (min≤number)∧ ( max≥number)
