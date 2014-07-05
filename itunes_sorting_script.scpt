-- this script will add a new sorting name to a selection of iTunes tracks
-- useful because iTunes smart playlists don't let you sort by track number
-- admittedly limited utility -- really should pass in a track number parameter

global sel
property letters : "abcdefghijklmnopqrstuvwxyz"
global counter
global namestring
set counter to 1
set namestring to ""
tell application "iTunes"
	if selection is not {} then
		set sel to selection
	else
		display dialog "Select some tracks first..." buttons {"Cancel"} default button 1 with icon 2 giving up after 15
	end if
	
	tell application "iTunes"
		set ofi to fixed indexing
		set fixed indexing to true
		with timeout of 30000 seconds
			repeat with this_track in sel
				try
					-- really should be get_sort_name(this_track's track number)
					set this_track's sort name to my get_sort_name() as string
				end try
			end repeat
		end timeout
	end tell
end tell

on get_sort_name()
	set end_letter to text (counter) of letters
	if counter mod 26 is 0 then
		set counter to 0
		set namestring to namestring & end_letter
	end if
	set counter to counter + 1
	return namestring & end_letter
end get_sort_name
