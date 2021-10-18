/obj/structure/toilet

	var/buildstacktype

/obj/structure/sink

	var/buildstacktype

/obj/structure/toilet/greyscale
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	buildstacktype = null

/obj/structure/sink/greyscale
	icon_state = "sink_greyscale"
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	buildstacktype = null
