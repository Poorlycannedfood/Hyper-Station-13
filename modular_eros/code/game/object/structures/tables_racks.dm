/obj/structure/table/MouseDrop_T(atom/movable/O, mob/user)
	if(!((user == O) && isliving(user)))
		return ..()
	var/mob/living/L = user
	if(!L.resting || locate(/obj/structure/table) in L.loc)
		return ..()
	L.visible_message("<span class='warning'>[L] is trying to crawl under \the [src]!</span>", "<span class='notice'>You attempt to crawl under \the [src]..</span>")
	if(!(do_after(L, 30, target = src) && L.resting))
		L.visible_message("<span class='warning'>[L] fails to crawl under \the [src]!</span>", "<span class='notice'>You fail to crawl under \the [src]!</span>")
		return
	ADD_TRAIT(L, TRAIT_FLOORED, "table lol")
	ADD_TRAIT(L, IGNORE_PSEUDO_Z_AXIS, "table lol")
	L.forceMove(src.loc)
	L.layer = ABOVE_NORMAL_TURF_LAYER
	L.RegisterSignal(L, COMSIG_MOVABLE_MOVED, /mob/living.proc/fix_table_shit_lol)
	

/mob/living/proc/fix_table_shit_lol()
	if(!(locate(/obj/structure/table) in src.loc))
		layer = MOB_LAYER //fixes layer lol
		REMOVE_TRAIT(src, TRAIT_FLOORED, "table lol")
		REMOVE_TRAIT(src, IGNORE_PSEUDO_Z_AXIS, "table lol")
		UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
