⟨Get, Post⟩ ← •Import "../external/bqn-curl/curl.bqn"
⟨FromBytes⟩ ← •Import "../external/bqn-libs/strings.bqn"
⟨Parse, Export⟩ ← •Import "../external/bqn-libs/json.bqn"

Pp ← {•Show 100↑•Fmt𝕩⋄𝕩}
Rr ← { •Show (100⊸↑ •Repr 𝕩)⋄𝕩}

Jj ← {•Show (100↑ Export 𝕩)⋄𝕩}

# use jq to format the json
Jq ← {
	raw_json ← Export 𝕩
	filter ← " | ."
	exitcode‿stdout‿stderr ← •SH ⟨"jq", "-n", raw_json ∾ filter ⟩
	•Out 300↑ stdout
	𝕩
}

# finds the data associated to the field
FindColumn ← {
	column_name ← <𝕨
	column_name ({((≠⊏𝕩)↑𝕨⊸⍷)∘⊏𝕩}/1⊸⊏) 𝕩
}




filename ← "../data/securities/2023_aapl.json"

# ⟨content⟩ ←Get "https://reddit.com/r/programming.json"
# filename •file.Chars (Export Parse content)

content ←  Parse •file.Bytes filename

resultsIdx ← 4
dayIdx ← 1
closeLookup ← 1‿3
•Show  ⊏ content
•Show  dayIdx⊑ 1‿resultsIdx ⊑ content
closes ← closeLookup⊸⊑¨ 1‿resultsIdx ⊑ content
sma7 ← (+´÷≠)˘ (0¨↕7)∾7↕ closes
# •Show¨ (↕14)⋈¨(14↑sma7)

# •Show 14⊏ ⍉[closes, 250↑sma7]

# •Show (⊏∾⊢)⍟4 3↕ ↕10

•Show  {
		orig_row ← 𝕩
		num_repeats ← 5
		¯1⌽ {("$"⊸∾˘¨orig_row)∾𝕩}⍟num_repeats ≍ orig_row
	} [1,2,3,4]
