⟨Get, Post⟩ ← •Import "../external/bqn-curl/curl.bqn"
⟨FromBytes⟩ ← •Import "../external/bqn-libs/strings.bqn"
⟨Parse, Export⟩ ← •Import "../external/bqn-libs/json.bqn"

Pp ← {•Show 100↑•Fmt𝕩⋄𝕩}
Rr ← { •Show (100⊸↑ •Repr 𝕩)⋄𝕩}


filename ← "reddit.json"

# ⟨content⟩ ←Get "https://reddit.com/r/programming.json"
# filename •file.Chars (Export Parse content)

content ←  Parse •file.Bytes filename
listing ←  Parse •file.Bytes filename


KindData ← 1⊏⊑
KindDataChildren ← 1⊑ KindData


Jj ← {•Show (100↑ Export 𝕩)⋄𝕩}

# use jq to format the json
Jq ← {
	raw_json ← Export 𝕩
	filter ← " | ."
	exitcode‿stdout‿stderr ← •SH ⟨"jq", "-n", raw_json ∾ filter ⟩
	•Out 300↑ stdout
	𝕩
}

submissions ← 1‿4⊑ 1‿1⊑ content
# submissions ← children ← 1⊏ 1⊑ data ← 1⊏ content

# finds the data associated to the field
FindColumn ← {
	column_name ← <𝕨
	# •Show "col"‿column_name‿"x"‿𝕩
	column_name ({((≠⊏𝕩)↑𝕨⊸⍷)∘⊏𝕩}/1⊸⊏) 𝕩
}

# Rr submissions

submission ← 1⊑ KindData 0⊏ submissions
columns_names ← 0⊏ submission

Trim ← {(∨`∧∨`⌾⌽)' '≠𝕩}⊸/

short ←  {
	to_find ← ⟨"author", "title", "subreddit"⟩
	raw_submission ← 𝕩
	(Trim∘(75⊸↑))¨ > to_find { 𝕨FindColumn¨ <  1⊑ KindData 𝕩 }˘ raw_submission
}˘ submissions

•Show˘   short

•Show "done"
