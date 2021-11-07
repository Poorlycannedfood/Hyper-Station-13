/obj/item/clothing/under
	icon = 'icons/obj/clothing/uniforms.dmi'
	name = "under"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	permeability_coefficient = 0.9
	slot_flags = ITEM_SLOT_ICLOTHING
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	var/fitted = FEMALE_UNIFORM_FULL // For use in alternate clothing styles for women
	var/has_sensor = HAS_SENSORS // For the crew computer
	var/random_sensor = TRUE
	var/sensor_mode = NO_SENSORS
	var/can_adjust = TRUE
	var/adjusted = NORMAL_STYLE
	var/suit_style = NORMAL_SUIT_STYLE
	var/alt_covers_chest = FALSE // for adjusted/rolled-down jumpsuits, FALSE = exposes chest and arms, TRUE = exposes arms only
	var/list/attached_accessories = list()
	var/list/accessory_overlays = list()
	mutantrace_variation = MUTANTRACE_VARIATION //Are there special sprites for specific situations? Don't use this unless you need to.
	equip_sound = 'sound/items/equip/jumpsuit_equip.ogg'

	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'

/obj/item/clothing/under/worn_overlays(isinhands = FALSE)
	. = list()
	if(!isinhands)
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damageduniform")
		if(blood_DNA)
			. += mutable_appearance('icons/effects/blood.dmi', "uniformblood", color = blood_DNA_to_color())
		for(var/mutable_appearance/MA in accessory_overlays)
			. += MA

/obj/item/clothing/under/attackby(obj/item/I, mob/user, params)
	if((has_sensor == BROKEN_SENSORS) && istype(I, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/C = I
		C.use(1)
		has_sensor = HAS_SENSORS
		to_chat(user,"<span class='notice'>You repair the suit sensors on [src] with [C].</span>")
		return 1
	if(!attach_accessory(I, user))
		return ..()

/obj/item/clothing/under/update_clothes_damaged_state(damaging = TRUE)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_w_uniform()
	if(has_sensor > NO_SENSORS)
		has_sensor = BROKEN_SENSORS

/obj/item/clothing/under/New()
	if(random_sensor)
		//make the sensor mode favor higher levels, except coords.
		sensor_mode = pick(SENSOR_OFF, SENSOR_LIVING, SENSOR_LIVING, SENSOR_VITALS, SENSOR_VITALS, SENSOR_VITALS, SENSOR_COORDS, SENSOR_COORDS)
	adjusted = NORMAL_STYLE
	suit_style = NORMAL_SUIT_STYLE
	..()

/obj/item/clothing/under/equipped(mob/user, slot)
	..()
	if(adjusted)
		adjusted = NORMAL_STYLE
		fitted = initial(fitted)
		if(!alt_covers_chest)
			body_parts_covered |= CHEST

	if(mutantrace_variation && ishuman(user))
		var/mob/living/carbon/human/H = user
		if(DIGITIGRADE in H.dna.species.species_traits)
			suit_style = DIGITIGRADE_SUIT_STYLE
		else
			suit_style = NORMAL_SUIT_STYLE
		H.update_inv_w_uniform()

	if(attached_accessories.len && slot != SLOT_HANDS && ishuman(user))
		var/mob/living/carbon/human/H = user
		for(var/obj/item/clothing/accessory/A in attached_accessories)
			A.on_uniform_equip(src, user)
			if(A.above_suit)
				H.update_inv_wear_suit()

/obj/item/clothing/under/dropped(mob/user)
	if(attached_accessories.len)
		for(var/obj/item/clothing/accessory/A in attached_accessories)
			A.on_uniform_dropped(src, user)
		
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.update_inv_wear_suit()

	..()

/obj/item/clothing/under/proc/attach_accessory(obj/item/I, mob/user, notifyAttach = 1)
	. = FALSE
	if(!istype(I, /obj/item/clothing/accessory))
		return

	var/obj/item/clothing/accessory/A = I
	var/leng = attached_accessories.len
	. = TRUE
	if(leng >= 3)
		if(user)
			to_chat(user, "<span class='warning'>[src] can't fit another accessory.</span>")
		return
	if(user && !user.temporarilyRemoveItemFromInventory(I))
		return
	if(!A.attach(src, user))
		return

	if(user && notifyAttach)
		to_chat(user, "<span class='notice'>You attach [I] to [src].</span>")

	var/accessory_color = A.item_color
	if(!accessory_color)
		accessory_color = A.icon_state
	var/mutable_appearance/overlay = mutable_appearance('icons/mob/accessories.dmi', "[accessory_color]")
	overlay.alpha = A.alpha
	overlay.color = A.color
	accessory_overlays += overlay
	attached_accessories += A

	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.update_inv_w_uniform()
		H.update_inv_wear_suit()

	return TRUE

/obj/item/clothing/under/proc/remove_accessory(mob/user)
	if(!isliving(user))
		return
	if(!can_use(user))
		return
	var/length = attached_accessories.len
	if(!length)
		return

	var/obj/item/clothing/accessory/A = attached_accessories[length]
	A.detach(src, user, length)
	if(user.put_in_hands(A))
		to_chat(user, "<span class='notice'>You detach [A] from [src].</span>")
	else
		to_chat(user, "<span class='notice'>You detach [A] from [src] and it falls on the floor.</span>")

	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.update_inv_w_uniform()
		H.update_inv_wear_suit()


/obj/item/clothing/under/examine(mob/user)
	. = ..()
	if(can_adjust)
		if(adjusted == ALT_STYLE)
			. += "Alt-click on [src] to wear it normally."
		else
			. += "Alt-click on [src] to wear it casually."
	if (has_sensor == BROKEN_SENSORS)
		. += "Its sensors appear to be shorted out."
	else if(has_sensor > NO_SENSORS)
		switch(sensor_mode)
			if(SENSOR_OFF)
				. += "Its sensors appear to be disabled."
			if(SENSOR_LIVING)
				. += "Its binary life sensors appear to be enabled."
			if(SENSOR_VITALS)
				. += "Its vital tracker appears to be enabled."
			if(SENSOR_COORDS)
				. += "Its vital tracker and tracking beacon appear to be enabled."
	if(attached_accessories.len)
		if(attached_accessories.len == 1)
			. += "\A [attached_accessories[1]] [icon2html(attached_accessories[1], user)] is attached to it."
		else
			. += "It has several accessories attached to it:"
			for(var/obj/item/clothing/accessory/A in attached_accessories)
				. += "[icon2html(A, user)] \a [A]"
