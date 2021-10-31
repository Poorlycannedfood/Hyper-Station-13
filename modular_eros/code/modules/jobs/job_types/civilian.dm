/datum/job/prisoner
	title = "Prisoner"
	flag = PRISONER
	department_head = list("Head of Security") //what
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 0
	spawn_positions = 3
	supervisors = "the entirety of security"
	selection_color = COLOR_ORANGE
	outfit = /datum/outfit/job/prisoner
	
/* fuck you. if you can make this work, go the fuck ahead.
/datum/job/gulagee
	title = "Gulag Prisoner"
	flag = GULAG
	department_head = list("Head of Security")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 0
	spawn_positions = 2
	supervisors = "the entirety of security"
	selection_color = COLOR_ORANGE
	outfit = /datum/outfit/job/prisoner
*/

/datum/outfit/job/prisoner
	name = "Prisoner"
	id = /obj/item/card/id/prisoner
	uniform = /obj/item/clothing/under/rank/prisoner
	shoes = /obj/item/clothing/shoes/sneakers/orange
	ears = null //i'm honestly out of ideas
	belt = null //to whoever stumbles here into the promised land of bobs and vagene code
	back = null //the only good you can do for it really is to port everything hyper has to tg 
	backpack = null //and finally let this abomination rest
	satchel  = null
	duffelbag = null
	box = null
