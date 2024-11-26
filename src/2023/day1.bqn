data ← •file.Lines "../../samples/2023/day1.txt"
data ↩ •file.Lines "../../samples/2023/day1_alt.txt"
data ↩ •file.Lines "../../inputs/2023/day1.txt"


Log ← {
	msg‿val ← 𝕩
	•Show msg‿val
	val
}

alphanums ← ⟨
	"zero",
	"one","two","three","four",
	"five","six","seven","eight","nine"
⟩

# we add 0 because it'll make the indices easier to read at a glance.
# Zeroes never appear in the input.
digits ← ⟨"0", "1","2","3","4","5","6","7","8","9"⟩

PartOne ← {
	raw_nums← ((•ParseFloat ⋈)⎊⟨⟩)¨¨ 𝕩
	# nums ← (∾ •Show )⎊{(•CurrentError @) ∾" - ERR: "∾(•Fmt •Repr 𝕩)}¨raw_nums
	nums ← (∾  )⎊⊢¨raw_nums
	# •Show¨ nums
	pairs← {⊏∾¯1⊸⊏}¨nums
	+´(•ParseFloat∘∾´∘(•Fmt¨)¨)˘ pairs
}

PartTwo ← {
	•Show¨ words ←{<⌈˝(↕≠)⊸(×˘) >{(≠∘>𝕩)↑¨alphanums⍷¨𝕩}𝕩}˘ 𝕩
	•Out "--"
	•Show¨ chars ← {<⌈˝(↕≠)⊸(×˘) >{(≠∘>𝕩)↑¨digits⍷¨𝕩}𝕩}˘ 𝕩
	•Show +´ {𝕊w‿s:
		#indices
		wi ← (/0⊸≠)w
		si ← (/0⊸≠)s
		# min/max indices
		minw‿mins ← (⌊´wi)‿(⌊´si)
		maxw‿maxs ← (⌈´wi)‿(⌈´si)

		# •Show minw‿mins‿maxw‿maxs
		left_char ← {minw < mins ? minw⊏w ; mins⊏s}
		right_char ← {maxw > maxs ? maxw⊏w ; maxs⊏s}
		•ParseFloat ∾ •Fmt¨ left_char∾right_char
		} ˘ words∾˘chars
	# raw_nums← ((•ParseFloat ⋈)⎊⟨⟩)¨¨ 𝕩
	# # nums ← (∾ •Show )⎊{(•CurrentError @) ∾" - ERR: "∾(•Fmt •Repr 𝕩)}¨raw_nums
	# nums ← (∾  )⎊⊢¨raw_nums
	# # •Show¨ nums
	# pairs← {⊏∾¯1⊸⊏}¨nums
	# +´(•ParseFloat∘∾´∘(•Fmt¨)¨)˘ pairs
}

# •Show "part 1: "‿(PartOne data)
•Show "part 2: "‿(PartTwo data)
