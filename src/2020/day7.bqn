data ← •file.Lines "../../samples/2020/day7.txt"
# data ← •file.Lines "../../inputs/2020/day7.txt"

ParseBagLine ← {
	𝕩
	# line ← "this is my pop tains"
	line ← 30↑𝕩

	# •Show ⍉[line,line]
	mask ← 1⌈(≠"contain")×("contain"⍷line)
	•Show (mask/mask)/line
	# •Show line
}

ParseBagLine¨ data

