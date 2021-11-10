/mob
	var/is_tilted = 0

/mob/verb/westtilt()
	if(!canface() || is_tilted < -45)
		return
	transform = transform.Turn(-1)
	is_tilted--

/mob/verb/easttilt()
	if( is_tilted > 45)
		return
	transform = transform.Turn(1)
	is_tilted++
