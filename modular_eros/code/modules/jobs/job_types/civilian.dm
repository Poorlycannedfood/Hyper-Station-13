/datum/job/prisoner
	title = "Prisoner"
	flag = PRISONER
	department_head = "Head of Security"
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 0
	spawn_positions = 3
	supervisors = "the entirety of security"
	selection_color = COLOR_ORANGE
	outfit = /datum/outfit/prisoner
	
/datum/job/gulagee
	title = "Gulag Prisoner"
	flag = GULAG
	department_head = "Head of Security"
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 0
	spawn_positions = 2
	supervisors = "the entirety of security"
	selection_color = COLOR_ORANGE
	outfit = /datum/outfit/prisoner

/datum/outfit/prisoner
	name = "Prisoner"
	id = /obj/item/card/id/prisoner
	uniform = /obj/item/clothing/under/rank/prisoner
	shoes = /obj/item/clothing/shoes/sneakers/orange
