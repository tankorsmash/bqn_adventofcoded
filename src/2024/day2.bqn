data ← •file.Lines "../../samples/2024/day2.txt"
# data ↩ •file.Lines "../../samples/2024/day2_alt.txt"
# data ↩ •file.Lines "../../inputs/2024/day2.txt"

Log ← {msg𝕊val:
	•Show msg‿val
	val
}

PartOne ← {𝕊lines:
 lines
}

PartTwo ← {𝕊lines:

	lines
}

•Out 50/"-"
"part 1: " Log (PartOne data)
"part 2: " Log (PartTwo data)
