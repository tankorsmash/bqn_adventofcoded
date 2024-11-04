⟨Get, Post⟩ ← •Import "../external/bqn-curl/curl.bqn"
⟨FromBytes⟩ ← •Import "../external/bqn-libs/strings.bqn"
⟨Parse, Export⟩ ← •Import "../external/bqn-libs/json.bqn"


filename ← "reddit.json"

# ⟨content⟩ ←Get "https://reddit.com/r/programming.json"
# filename •file.Chars (Export Parse content)

content ←  Parse •file.Bytes filename

children ← >4⊏1⊏>1⊏1⊏ content

Pp ← {•Show 100↑•Fmt𝕩⋄𝕩}
Rr ← { •Show (100⊸↑ •Repr 𝕩)⋄𝕩}

# finds the data associated to the field
FindColumn ← {
	column ← 𝕨
	# •Show 𝕩
	column ({(𝕨⊸⍷)∘⊏𝕩}/1⊸⊏) 𝕩
}
•Show ((<"title")⊸FindColumn )  1⊑ 1⊏ ⊑  children
# •Show 0‿3⊑ 1⊑  1⊏>⊏  children
columns_names ← 0⊏ actual_data← 1⊑ t3_pair← 1⊏ ⊑  children



