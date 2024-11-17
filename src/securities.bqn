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

Split ← ((+`∘=)⊔⊢)
SplitRepl ← {
	raw ← 𝕨((+`∘=)⊔⊢)𝕩
		(𝕨⊸≠/⊢)¨ raw
}

base_checkboxes ← 0¨ ↕1_000_000
# •Show ≠base_checkboxes

filename2 ← "/mnt/d/Downloads/one-million-checkboxes-data/pre-crash/logs.2024-06-27.txt"
•Show "reading updates"
# log_bytes ← 1_000_000↑ •file.MapBytes filename2
log_bytes ← 1_0↑ •file.MapBytes filename2
lf ← @+10
updates ← > (1‿2⊸⊏)¨ {
	raw_time‿raw_idx‿raw_bool ← 𝕩
	⟨raw_time, •ParseFloat raw_idx, •ParseFloat raw_bool⟩
}¨ ((3=≠¨)/⊢) '|'⊸SplitRepl¨ lf⊸SplitRepl log_bytes
•Show "done"

Gather ← {
	idx‿val ← 𝕨
	𝕨
	val⌾(idx⊸⊑)𝕩
}

rendered ← base_checkboxes Gather˝ updates
•Show "done rendering"
# •Show ((⋈˜·⌊·√≠)⥊⊢)rendered
# •Show 10↑updates

# width ← 200
# height ← 200
width ← √≠rendered
height ← √≠rendered

file_header← ∾ ⟨
	'P', '6', @+10,
	•Fmt width,' ', •Fmt height,@+10,
	255,@+10
    ⟩
•Show file_header



times ← (width×height)
•Show "generating image"‿times
# img_data ← [1,0,1]∾⍟times  ⟨⟩
# img_data ← (times×3)⥊[255,0,0]


# final_image ← file_header∾img_data
•Show ≠rendered
final_image ← file_header∾(3⊸×∘≠⥊⊢)rendered
# •Show ≠final_image
•Show "writing"

filename ← "./src/temp.ppm"

"./temp.ppm" •file.Bytes final_image

# •Show '.'¨ 10‿20⥊↕ 200
# •Show '1'⌾(0⊸⊑) '0'¨  ⥊ ((⋈˜·⌊√)⥊↕)100
# •Show '1'⌾(¯1⊸⊑) '0'¨  ⥊ ((⋈˜·⌊√)⥊↕)1_000_000


•Show "done writing"


•Show data ← [⟨"data", "test"⟩,  ⟨"meta", "1234"⟩]
fields ← ⟨"test", "data"⟩
•Show result ← ⊐⟜fields⊸⊏˝ data

# •Show ⟨"foo"⟩⊐["foo", "bar", "baz"]

# •Show •SH ⟨"feh", filename⟩

# filename ← "../data/securities/2023_aapl.json"
#
# # ⟨content⟩ ←Get "https://reddit.com/r/programming.json"
# # filename •file.Chars (Export Parse content)
#
# content ←  Parse •file.Bytes filename
#
# resultsIdx ← 4
# dayIdx ← 1
# closeLookup ← 1‿3
# •Show  ⊏ content
# •Show  dayIdx⊑ 1‿resultsIdx ⊑ content
# closes ← closeLookup⊸⊑¨ 1‿resultsIdx ⊑ content
# sma7 ← (+´÷≠)˘ (0¨↕7)∾7↕ closes
# # •Show¨ (↕14)⋈¨(14↑sma7)
#
# # •Show 14⊏ ⍉[closes, 250↑sma7]
#
# # •Show (⊏∾⊢)⍟4 3↕ ↕10
#
# •Show  {
# 		orig_row ← 𝕩
# 		num_repeats ← 5
# 		¯1⌽ {("$"⊸∾˘¨orig_row)∾𝕩}⍟num_repeats ≍ orig_row
# 	} [1,2,3,4]
