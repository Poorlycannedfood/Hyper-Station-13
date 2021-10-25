#define ASH_WALKER_SPAWN_THRESHOLD 2
//The ash walker den consumes corpses or unconscious mobs to create ash walker eggs. For more info on those, check ghost_role_spawners.dm
/obj/structure/lavaland/ash_walker
	name = "necropolis tendril nest"
	desc = "A vile tendril of corruption. It's surrounded by a nest of rapidly growing eggs..."
	icon = 'icons/mob/nest.dmi'
	icon_state = "ash_walker_nest"
	move_resist=INFINITY // just killing it tears a massive hole in the ground, let's not move it
	anchored = TRUE
	density = TRUE
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	max_integrity = 200
	var/faction = list("ashwalker")
	var/meat_counter = 6
	var/spawned_obj = /obj/effect/mob_spawn/human/ash_walker
	var/datum/species/species = /datum/species/lizard/ashwalker

/obj/structure/lavaland/ash_walker/Initialize()
	.=..()
	START_PROCESSING(SSprocessing, src)

/obj/structure/lavaland/ash_walker/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	QDEL_NULL(species)
	return ..()

/obj/structure/lavaland/ash_walker/deconstruct(disassembled)
	new /obj/item/assembly/signaler/anomaly (get_step(loc, pick(GLOB.alldirs)))
	new /obj/effect/collapse(loc)

/obj/structure/lavaland/ash_walker/process()
	consume()
	spawn_mob()

/obj/structure/lavaland/ash_walker/proc/consume()
	for(var/mob/living/H in view(src, 1)) //Only for corpse right next to/on same tile
		if(H.stat)
			for(var/obj/item/W in H)
				if(!H.dropItemToGround(W))
					qdel(W)
			if(is_species(H, species) && (H.key || H.get_ghost(FALSE, TRUE))) //special interactions for dead lava lizards with ghosts attached
				var/mob/living/carbon/human/C = H
				visible_message("<span class='warning'>Serrated tendrils carefully pull [C] to [src], absorbing the body and creating it anew.</span>")
				var/datum/mind/deadmind
				if(C.key)
					deadmind = C.mind
				else
					deadmind = C.get_ghost(FALSE, TRUE)
				to_chat(deadmind, "Your body has been returned to the nest. You are being remade anew, and will awaken shortly. </br><b>Your memories will remain intact in your new body, as your soul is being salvaged.</b>")
				SEND_SOUND(deadmind, sound('sound/magic/enter_blood.ogg',volume=100))
				addtimer(CALLBACK(src, .proc/remake_walker, C.mind, C.real_name, C.gender), 20 SECONDS)
				new /obj/effect/gibspawner/generic(get_turf(H))
				qdel(H)
				return
			playsound(get_turf(src),'sound/magic/demon_consume.ogg', 100, 1)
			if(issilicon(H)) //no advantage to sacrificing borgs...
				H.gib()
				visible_message("<span class='notice'>Serrated tendrils eagerly pull [H] apart, but find nothing of interest.</span>")
				return
			visible_message("<span class='warning'>Serrated tendrils eagerly pull [H] to [src], tearing the body apart as its blood seeps over the eggs.</span>")
			if(ismegafauna(H))
				meat_counter += 20

			else
				meat_counter++
			H.gib()
			obj_integrity = min(obj_integrity + max_integrity*0.05,max_integrity)//restores 5% hp of tendril

/obj/structure/lavaland/ash_walker/proc/spawn_mob()
	if(meat_counter >= ASH_WALKER_SPAWN_THRESHOLD)
		new spawned_obj(get_step(loc, pick(GLOB.alldirs)))
		visible_message("<span class='danger'>One of the eggs swells to an unnatural size and tumbles free. It's ready to hatch!</span>")
		meat_counter -= ASH_WALKER_SPAWN_THRESHOLD
