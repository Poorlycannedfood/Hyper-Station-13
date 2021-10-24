/obj/item/pickaxe
	var/digrange = 1

/obj/item/pickaxe/attack_self(mob/user)
	if(initial(digrange) > 0)
		if(digrange == 0)
			digrange = initial(digrange)
			toolspeed = initial(toolspeed)
			to_chat(user, "<span class='notice'>You increase the tools dig range, decreasing its mining speed.</span>")
		else
			digrange = 0
			toolspeed = toolspeed/2
			to_chat(user, "<span class='notice'>You decrease the tools dig range, increasing its mining speed.</span>")
	else
		to_chat(user, "<span class='notice'>Tool does not have a configureable dig range.</span>")
