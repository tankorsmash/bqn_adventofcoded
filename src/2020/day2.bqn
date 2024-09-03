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

part_1 ← +´Part1IsValid ¨data
•Show part_1

# min ← 10
# max ← 15
# number ← 13
# •Show 1+min+↕(max - min)

# •Show "zaabca"
# •Show +´0="a"⊐"zabc"


# •Show number>min
# •Show number<max
# •Show (min≤number)∧ ( max≥number)
