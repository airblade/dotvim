function! FoldSpellBalloon()
	let foldStart = foldclosed(v:beval_lnum)
	let foldEnd   = foldclosedend(v:beval_lnum)
	let lines     = []
	if foldStart < 0
		let lines = spellsuggest(spellbadword(v:beval_text)[0], 5, 0)
	else
		let numLines = foldEnd - foldStart + 1
		if (numLines > 31)
			let lines = getline(foldStart, foldStart + 14)
			let lines += ['-- Snipped ' . (numLines - 30) . ' lines --']
			let lines += getline(foldEnd - 14, foldEnd)
		else
			let lines = getline(foldStart, foldEnd)
		endif
	endif
	return join(lines, has("balloon_multiline") ? "\n" : " ")
endfunction

set balloonexpr=FoldSpellBalloon()
set ballooneval
