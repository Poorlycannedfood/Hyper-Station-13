/obj/item/clothing/under/Destroy()
	QDEL_LIST(attached_accessories)
	QDEL_LIST(accessory_overlays)
	return ..()
