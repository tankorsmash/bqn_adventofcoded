⟨Get, Post⟩ ← •Import "../external/bqn-curl/curl.bqn"
⟨FromBytes⟩ ← •Import "../external/bqn-libs/strings.bqn"
⟨Parse, Export⟩ ← •Import "../external/bqn-libs/json.bqn"
⟨ToTimestamp, FromTimestamp ⟩ ← •Import "../external/bqn-libs/datetime.bqn"

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

PMon ← { 1: "Jan"; 2: "Feb"; 3: "Mar"; 4: "Apr"; 5: "May"; 6: "Jun"; 7: "Jul"; 8: "Aug"; 9: "Sep"; 10: "Oct"; 11: "Nov"; 12: "Dec"}
PMonth ← { 1: "January"; 2: "February"; 3: "March"; 4: "April"; 5: "May"; 6: "June"; 7: "July"; 8: "August"; 9: "September"; 10: "October"; 11: "November"; 12: "December"}
TimeToString ← {𝕊 year‿month‿day‿hour‿minute‿second:
	Pad ← 2⊸(-⊸↑)
	< ∾(•Repr year)∾" "∾(<PMon month)∾" "∾(•Repr day)∾", "∾(•Repr hour)∾"h"∾(Pad •Repr minute)∾"m"∾(Pad •Repr second)∾"s"
}

Reorder ← { first_keys𝕊arr:
	remaining_keys ← / ¬ first_keys⊸(∊˜) ↕≠arr
	(first_keys∾remaining_keys)⊏arr
}

sec_json ← Parse •file.Bytes "../data/securities/2023_aapl.json"
results ← ((/(<"results")⍷⊏)⊏1⊸⊏)sec_json
Time ← ToTimestamp ÷⟜1000
entries ←  20↑ ⊑results
entries ↩ (6‿2‿3‿4)⊸Reorder˘¨ entries
# •Show¨ entries
entry ← ⊑entries
GetIdx ← {name𝕊row: ⊑/((<name)⍷⊏) row}
time_idx ←  "t" GetIdx entry
open_idx ←  "o" GetIdx entry
close_idx ← "c" GetIdx entry
vol_idx ←   "v" GetIdx entry
entries_times ← (TimeToString∘∾)˘⍉> Time (⋈∘time_idx⊸⊏ 1⊸⊏)¨ entries

•Show "headers"‿(headers ← ⊏⊑entries)
•Show headers ∾ data← > 1⊸⊏¨ entries

•Show {𝕊time‿open: TimeToString>Time time}˘ time_idx‿open_idx⊸⊏˘data

# •Show 5⌽"01234567"

•Show "done"

