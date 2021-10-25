/obj/effect/mob_spawn/human/ash_walker
	var/gender_bias

/obj/effect/mob_spawn/human/ash_walker/western
	mob_species = /datum/species/lizard/ashwalker/western
	gender_bias = FEMALE

/obj/effect/mob_spawn/human/ash_walker/eastern
	mob_species = /datum/species/lizard/ashwalker/eastern
	gender_bias = MALE

/obj/effect/mob_spawn/human/ash_walker/equip(mob/living/carbon/human/H)
	if(!isnull(gender_bias) && prob(80))
		H.gender = gender_bias
	return ..()
