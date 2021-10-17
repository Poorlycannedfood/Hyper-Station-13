/obj/item/milking_machine
	icon = 'hyperstation/icons/obj/milking_machine.dmi'
	name = "milking machine"
	icon_state = "Off"
	item_state = "Off"
	desc = "A pocket sized pump and tubing assembly designed to collect and store products from mammary glands."

	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_POCKET

	var/on = FALSE
	var/obj/item/reagent_containers/glass/inserted_item = null

	var/target_organ  = "breasts" // What organ we are transfering from
	var/inuse = 0

/obj/item/milking_machine/examine(mob/user)
	. = ..()
	to_chat(user, "<span class='notice'>[src] is currently [on ? "on" : "off"].</span>")
	if (inserted_item)
		to_chat(user, "<span class='notice'>[inserted_item] contains [inserted_item.reagents.total_volume]/[inserted_item.reagents.maximum_volume] units</span>")

/obj/item/milking_machine/attackby(obj/item/W, mob/user, params)
	add_fingerprint(user)
	if(istype(W, /obj/item/reagent_containers/) && !inserted_item)
		if(!user.transferItemToLoc(W, src))
			return ..()
		inserted_item = W
		UpdateIcon()
	else
		return ..()

/obj/item/milking_machine/interact(mob/user)
	if(!isAI(user) && inserted_item)
		add_fingerprint(user)
		on = !on
		if (on)
			to_chat(user, "<span class='notice'>You turn [src] on.</span>")
		else
			to_chat(user, "<span class='notice'>You turn [src] off.</span>")
		UpdateIcon()
	else
		..()

/obj/item/milking_machine/proc/UpdateIcon()
	icon_state = "[on ? "On" : "Off"][inserted_item ? "Beaker" : ""]"
	item_state = icon_state


/obj/item/milking_machine/AltClick(mob/living/user)
	add_fingerprint(user)
	user.put_in_hands(inserted_item)
	inserted_item = null
	on = FALSE
	UpdateIcon()

/obj/item/milking_machine/penis
	name = "cock milker"
	icon_state = "PenisOff"
	item_state = "PenisOff"
	desc = "A pocket sized pump and tubing assembly designed to collect and store products from the penis."

	target_organ  = "penis"

/obj/item/milking_machine/penis/UpdateIcon()
	icon_state = "Penis[on ? "On" : "Off"][inserted_item ? "Beaker" : ""]"
	item_state = icon_state

/obj/item/milking_machine/attack(mob/living/carbon/human/C, mob/living/user)
	if (!on)
		to_chat(user, "<span class='notice'>You can't use the [src] while it's off.</span>")
		return

	var/obj/item/organ/genital/O = FALSE

	// Checking if a valid organ is being passed
	if(target_organ == "penis")
		O = C.getorganslot("penis")
	else if(target_organ == "breasts")
		O = C.getorganslot("breasts")
	else
		to_chat(user, "<span class='notice'>You can't use the [src] on [C]'s [target_organ].</span>")
		return

	if(inuse == 1) //just to stop stacking and causing people to cum instantly
		return
	if(O&&O.is_exposed())
		inuse = 1
		if(!(C == user)) //if we are targeting someone else.
			C.visible_message("<span class='userlove'>[user] is trying to put the [src] on [C]'s [target_organ].</span>",
							  "<span class='userlove'>[user] is trying to use the [src] on your [target_organ].</span>")

		if(!do_mob(user, C, 3 SECONDS)) //3 second delay
			inuse = 0
			return

		//checked if not used on yourself, if not, carry on.
		// playsound(src, 'sound/lewd/slaps.ogg', 30, 1, -1) //slapping sound (replace with whirring sounds)
		inuse = 0
		if(!(C == user)) //lewd flavour text
			C.visible_message("<span class='userlove'>[user] puts the [src] on [C]'s [target_organ].</span>",
							  "<span class='userlove'>[user] pumps [C]'s [target_organ] using their [src].</span>")
		else
			user.visible_message("<span class='userlove'>[user] puts the [src] on [p_their()] [target_organ].</span>",
								 "<span class='userlove'>You pump your [target_organ] with the [src].</span>")

		if(prob(30)) //30% chance to make them moan.
			C.emote("moan")

		C.do_jitter_animation()
		C.adjustArousalLoss(20) //make the target more aroused. (same ammount as the fleshlight)
		if (C.getArousalLoss() >= 100 && ishuman(C) && C.has_dna())
			C.mob_fill_container(O, inserted_item, src) //make them cum if they are over the edge.
		return
	else
		to_chat(user, "<span class='notice'>You don't see anywhere to use this on.</span>")
	inuse = 0
	..()
