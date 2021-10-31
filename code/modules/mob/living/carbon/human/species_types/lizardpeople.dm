/datum/species/lizard
	// Reptilian humanoids with scaled skin and tails.
	name = "Lizardperson"
	id = "lizard"
	say_mod = "hisses"
	default_color = "00FF00"
	species_traits = list(MUTCOLORS,EYECOLOR,HAIR,FACEHAIR,LIPS,WINGCOLOR)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_REPTILE
	mutant_bodyparts = list("tail_lizard", "snout", "spines", "horns", "frills", "body_markings", "legs", "taur", "deco_wings")
	mutanttongue = /obj/item/organ/tongue/lizard
	mutanttail = /obj/item/organ/tail/lizard
	coldmod = 1.5
	heatmod = 0.67
	default_features = list("mcolor" = "0F0", "mcolor2" = "0F0", "mcolor3" = "0F0", "tail_lizard" = "Smooth", "snout" = "Round", "horns" = "None", "frills" = "None", "spines" = "None", "body_markings" = "None", "legs" = "Normal Legs", "taur" = "None", "deco_wings" = "None")
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/lizard
	gib_types = list(/obj/effect/gibspawner/lizard, /obj/effect/gibspawner/lizard/bodypartless)
	skinned_type = /obj/item/stack/sheet/animalhide/lizard
	exotic_bloodtype = "L"
	disliked_food = GRAIN | DAIRY
	liked_food = GROSS | MEAT
	inert_mutation = FIREBREATH

/datum/species/lizard/after_equip_job(datum/job/J, mob/living/carbon/human/H)
	H.grant_language(/datum/language/draconic)

/datum/species/lizard/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_lizard_name(gender)

	var/randname = lizard_name(gender)

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/lizard/qualifies_for_rank(rank, list/features)
	return TRUE

//I wag in death
/datum/species/lizard/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/lizard/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/datum/species/lizard/can_wag_tail(mob/living/carbon/human/H)
	return ("tail_lizard" in mutant_bodyparts) || ("waggingtail_lizard" in mutant_bodyparts)

/datum/species/lizard/is_wagging_tail(mob/living/carbon/human/H)
	return ("waggingtail_lizard" in mutant_bodyparts)

/datum/species/lizard/start_wagging_tail(mob/living/carbon/human/H)
	if("tail_lizard" in mutant_bodyparts)
		mutant_bodyparts -= "tail_lizard"
		mutant_bodyparts -= "spines"
		mutant_bodyparts |= "waggingtail_lizard"
		mutant_bodyparts |= "waggingspines"
	H.update_body()

/datum/species/lizard/stop_wagging_tail(mob/living/carbon/human/H)
	if("waggingtail_lizard" in mutant_bodyparts)
		mutant_bodyparts -= "waggingtail_lizard"
		mutant_bodyparts -= "waggingspines"
		mutant_bodyparts |= "tail_lizard"
		mutant_bodyparts |= "spines"
	H.update_body()

/datum/species/lizard/on_species_gain(mob/living/carbon/human/C, datum/species/old_species)
	if(("legs" in C.dna.species.mutant_bodyparts) && C.dna.features["legs"] == "Digitigrade Legs")
		species_traits += DIGITIGRADE
	if(DIGITIGRADE in species_traits)
		C.Digitigrade_Leg_Swap(FALSE)
	return ..()

/datum/species/lizard/on_species_loss(mob/living/carbon/human/C, datum/species/new_species)
	if(("legs" in C.dna.species.mutant_bodyparts) && C.dna.features["legs"] == "Normal Legs")
		species_traits -= DIGITIGRADE
	if(DIGITIGRADE in species_traits)
		C.Digitigrade_Leg_Swap(TRUE)

/*
 Lizard subspecies: ASHWALKERS
*/
/datum/species/lizard/ashwalker
	name = "Ash Walker"
	id = "ashlizard"
	limbs_id = "lizard"
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,DIGITIGRADE)
	inherent_traits = list(TRAIT_NOGUNS, TRAIT_NOTHIRST)
	mutantlungs = /obj/item/organ/lungs/ashwalker
	burnmod = 0.9
	brutemod = 0.9

#define HEAT_CYCLE_LENGTH 32
#define HEAT_CYCLE_OFFSET 11

/datum/species/lizard/ashwalker/on_species_gain(mob/living/carbon/human/C, datum/species/old_species)
	C.dna.features["tail_lizard"] = "Smooth"
	C.dna.features["mcolor2"] = C.dna.features["mcolor"]
	C.dna.features["mcolor3"] = C.dna.features["mcolor"]
	C.dna.features["taur"] = "None"
	// to any person that comes to here for "muh oc"
	// i will personally shit down your throat if you make snowflake taur ashies with a tentacle 14 inch
	// or whatever stupid oc shit you come up with possible
	// my babies will stay pure even if it costs me my github account
	C.add_quirk(TRAIT_HEAT_DETECT)
	var/temp = text2num(GLOB.round_id)
	var/tempish = ((temp - (HEAT_CYCLE_OFFSET + 1)) % HEAT_CYCLE_LENGTH)
	if(tempish <= 2)
		to_chat(C, "<span class='boldnotice'>It's this time again.. Your loins lay restless as they await a potential mate.</span>")
		C.add_quirk(TRAIT_HEAT)
	if(C.gender == MALE) 
		C.dna.features["has_cock"] = TRUE
		C.dna.features["has_balls"] = TRUE
		C.dna.features["cock_color"] = "A50021"
		C.dna.features["cock_girth"] = 0.78 + (0.02 * rand(-4, prob(10) ? 5 : 1)) //chance for a bigger pleasure
		C.dna.features["cock_shape"] = "Tapered"
		C.dna.features["cock_length"] = 0.5 + rand(4, prob(10) ? 9 : 6) + rand()
		C.dna.features["balls_shape"] = "Hidden"
	else
		C.dna.features["has_vag"] = TRUE
		C.dna.features["has_womb"] = TRUE
		C.dna.features["vag_color"] = C.dna.features["mcolor"]
		C.dna.features["vag_shape"] = "Cloaca"
	C.give_genitals(1)
	C.update_body()
	return ..()

#undef HEAT_CYCLE_LENGTH
#undef HEAT_CYCLE_OFFSET

/datum/species/lizard/ashwalker/eastern
	name = "Eastern Ash Walker"
	burnmod = 0.85
	brutemod = 0.85

/datum/species/lizard/ashwalker/eastern/on_species_gain(mob/living/carbon/human/C, datum/species/old_species)
	C.dna.features["legs"] = "Digitigrade Legs"
	return ..()

/datum/species/lizard/ashwalker/western
	name = "Western Ash Walker"
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS)

/datum/species/lizard/ashwalker/western/on_species_gain(mob/living/carbon/human/C, datum/species/old_species)
	C.dna.features["legs"] = "Normal Legs"
	return ..()
	