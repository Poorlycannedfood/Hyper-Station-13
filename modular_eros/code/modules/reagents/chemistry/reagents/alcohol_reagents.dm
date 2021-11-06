/datum/reagent/consumable/ethanol/panty_dropper
	name = "Liquid Panty Dropper"
	description = "You feel it's not named like that for nothing."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 70
	quality = DRINK_VERYGOOD
	taste_description = "cloth ripping and tearing"
	glass_icon_state = "orangecreamsicle"
	glass_name = "Liquid Panty Dropper"
	glass_desc = "You feel it's not named like that for nothing."
	value = 6

/datum/reagent/consumable/ethanol/panty_dropper/on_mob_life(mob/living/carbon/C)
	var/mob/living/carbon/human/M = C
	var/anyclothes = FALSE
	var/items = M.get_contents()
	for(var/obj/item/W in items)
		if(W == M.w_uniform || W == M.wear_suit)
			anyclothes = TRUE
			M.dropItemToGround(W, TRUE)
			playsound(M.loc, 'sound/items/poster_ripped.ogg', 50, 1)
	if(anyclothes)
		M.visible_message("<span class='boldnotice'>[M] suddenly burtst out of [M.p_their()] clothes!</span>")
	return ..()
