⟨ReplaceAll⟩ ← •Import •wdpath∾"/external/bqn-libs/strings.bqn"

year‿day ← •args


Log ← {msg𝕊val:
	•Show msg‿val
	val
}

•ParseFloat year
•ParseFloat day


inputs_dir ← •wdpath∾"/inputs/" ∾ year
sample_dir ← •wdpath∾ "/samples/" ∾ year
source_dir ← •wdpath∾ "/src/" ∾ year

inputs_filename ← •wdpath∾ "/inputs/" ∾ year ∾ "/day" ∾ day ∾ ".txt"
sample_filename ← •wdpath∾ "/samples/" ∾ year ∾ "/day" ∾ day ∾ ".txt"
source_filename ← •wdpath∾ "/src/" ∾ year ∾ "/day" ∾ day ∾ ".bqn"

# wrap text with green ascii color:
Green ← {𝕊text: "[32m" ∾ text ∾ "[0m"}
# wrap text with grey ascii color:
Grey ← {𝕊text: "[90m" ∾ text ∾ "[0m"}
# wrap text with red ascii color:
Red ← {𝕊text: "[31m" ∾ text ∾ "[0m"}


StripPrefix ← {prefix𝕊path:
	Find ← (≢∘⊢↑⍷)
	mask ← prefix Find path
	{𝕊:
		Ranges ← prefix⊸{(↕≠𝕨)⊸+˘ / 𝕨⊸Find 𝕩}
		{∾´¬ ⌈˝˘ (Ranges 𝕩)=¨ < ↕≠𝕩}⊸/path
	}⍟(⌈´ mask)path
}

StripRoot ← •wdpath⊸StripPrefix

SafeCreateDir ← {𝕊dir:
	fs ← ⟨
		# •file.CreateDir⎊(•Out "Can't create dir, maybe already exists ? "∾ •Currenterror) dir,
		{𝕊:
			•file.CreateDir dir
			Green "✅ dir created successfully"
		},
		Grey "- dir already exists!"
	⟩
	⊢◶ fs •file.Exists dir
}

SafeCreateFile ← {𝕊filepath:
	err_msg ← Red "Can't create file, maybe already exists ? "
	⊢◶ ⟨
		{𝕊:
			filepath •file.Bytes ""
			Green "✅ file created successfully"
		},
		Grey "- file already exists!"
	⟩ •file.Exists filepath

}


•Out "Creating input directory: " ∾ StripRoot inputs_dir
•Out SafeCreateDir inputs_dir
•Out "Creating sample directory: " ∾ StripRoot sample_dir
•Out SafeCreateDir sample_dir
•Out "Creating source directory: " ∾ StripRoot source_dir
•Out SafeCreateDir source_dir

•Out "Creating input file: " ∾ StripRoot inputs_filename
•Out SafeCreateFile inputs_filename
•Out "Creating sample file: " ∾ StripRoot sample_filename
•Out SafeCreateFile sample_filename
•Out "Creating source file: " ∾ source_filename
•Out SafeCreateFile source_filename


replacements ← [
	⟨"$YEAR", year⟩
	⟨"$DAY_NUM", day⟩
	⟨"$NAME", "Jules"⟩
]

template ← "data ← •file.Lines ""../../samples/$YEAR/day$DAY_NUM.txt""
# data ↩ •file.Lines ""../../samples/$YEAR/day$DAY_NUM_alt.txt""
# data ↩ •file.Lines ""../../inputs/$YEAR/day$DAY_NUM.txt""

# dyadic show but returns paired args
DShow ← {•Show 𝕨‿𝕩⋄ 𝕩}

Log ← {msg𝕊val:
	•Show (<msg)∾val
	val
}
RLog ← {msg𝕊val:
	•Show (msg)⋈val
	val
}

PartOne ← {𝕊lines:
	∞
}

PartTwo ← {𝕊lines:
	∞
}

SolutionValidator ← {part‿expected𝕊answer:
	max_length ← expected ⌈○(≠•Fmt)  answer
	err_msg ← (""
Part ""∾(•Fmt part)∾"" is wrong!""∾""
Expected: ""∾({»⍟(max_length⊸-≠𝕩) max_length⊸↑𝕩} •Fmt expected)∾""
  Actual: ""∾({»⍟(max_length⊸-≠𝕩) max_length⊸↑𝕩} •Fmt answer))∾""
""
	err_msg!(expected= answer)
	•Show ""Correctly solved Part ""∾(•Fmt part)∾"": ""∾(•Fmt answer)
}

AtLeastPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← (""Part ""∾(•Fmt part)∾"" is too low! Got instead: ""∾(•Fmt answer))
	err_msg!(expected≥ answer)
	•Show ""Correctly solved Part ""∾(•Fmt part)∾"": ""∾(•Fmt answer)
}

AtMostPartialSolutionValidator ← {part‿expected𝕊answer:
	err_msg ← (""Part ""∾(•Fmt part)∾"" is too high! Got instead: ""∾(•Fmt answer))
	err_msg!(expected< answer)
	•Show ""Correctly solved Part ""∾(•Fmt part)∾"": ""∾(•Fmt answer)
}


""part 1: "" Log PartOne data
# ""part 2: "" Log PartTwo data

# sample
# 1‿??? SolutionValidator PartOne data
# input
# 1‿??? SolutionValidator PartOne data

# sample
# 2‿??? SolutionValidator PartTwo data
# input
# 2‿??? SolutionValidator PartTwo data
"

ToRepl ← {𝕊key‿repl:
	[⋈key,⋈repl]
}

rendered ← template ReplaceAll´ <˘ ToRepl˘ replacements

•Out "Rendering source file: " ∾ StripRoot source_filename
source_filename •file.Chars rendered
•Out "Done!"

