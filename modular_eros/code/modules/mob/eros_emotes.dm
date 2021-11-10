/datum/emote/living/tilt
	key = "tilt"
	key_third_person = "tilts their head"
	message = "tilts their head."
	emote_type = EMOTE_VISIBLE

/datum/emote/living/squint
	key = "squint"
	key_third_person = "squints their head"
	message = "squints their head."
	emote_type = EMOTE_VISIBLE

/datum/emote/living/fart
	key = "fart"
	key_third_person = "farts"
	message = "farts out shitcode."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/fart/run_emote(mob/user, params, type_override, intentional)
	var/static/list/fart_emotes = list( //cope goonies
		"<B>%OWNER</B> lets out a girly little 'toot' from their butt.",
		"<B>%OWNER</B> farts loudly!",
		"<B>%OWNER</B> lets one rip!",
		"<B>%OWNER</B> farts! It sounds wet and smells like rotten eggs.",
		"<B>%OWNER</B> farts robustly!",
		"<B>%OWNER</B> farted! It smells like something died.",
		"<B>%OWNER</B> farts like a muppet!",
		"<B>%OWNER</B> defiles the station's air supply.",
		"<B>%OWNER</B> farts a ten second long fart.",
		"<B>%OWNER</B> groans and moans, farting like the world depended on it.",
		"<B>%OWNER</B> breaks wind!",
		"<B>%OWNER</B> expels intestinal gas through the anus.",
		"<B>%OWNER</B> release an audible discharge of intestinal gas.",
		"<B>%OWNER</B> is a farting motherfucker!!!",
		"<B>%OWNER</B> suffers from flatulence!",
		"<B>%OWNER</B> releases flatus.",
		"<B>%OWNER</B> releases methane.",
		"<B>%OWNER</B> farts up a storm.",
		"<B>%OWNER</B> farts. It smells like Soylent Surprise!",
		"<B>%OWNER</B> farts. It smells like pizza!",
		"<B>%OWNER</B> farts. It smells like George Melons' perfume!",
		"<B>%OWNER</B> farts. It smells like the kitchen!",
		"<B>%OWNER</B> farts. It smells like medbay in here now!",
		"<B>%OWNER</B> farts. It smells like the bridge in here now!",
		"<B>%OWNER</B> farts like a pubby!",
		"<B>%OWNER</B> farts like a goone!",
		"<B>%OWNER</B> sharts! That's just nasty.",
		"<B>%OWNER</B> farts delicately.",
		"<B>%OWNER</B> farts timidly.",
		"<B>%OWNER</B> farts very, very quietly. The stench is OVERPOWERING.",
		"<B>%OWNER</B> farts egregiously.",
		"<B>%OWNER</B> farts voraciously.",
		"<B>%OWNER</B> farts cantankerously.",
		"<B>%OWNER</B> fart in they own mouth. A shameful %OWNER.",
		"<B>%OWNER</B> breaks wind noisily!",
		"<B>%OWNER</B> releases gas with the power of the gods! The very station trembles!!",
		"<B>%OWNER <span style='color:red'>f</span><span style='color:blue'>a</span>r<span style='color:red'>t</span><span style='color:blue'>s</span>!</B>",
		"<B>%OWNER</B> laughs! Their breath smells like a fart.",
		"<B>%OWNER</B> farts, and as such, blob cannot evoulate.",
		"<b>%OWNER</B> farts. It might have been the Citizen Kane of farts."
	)
	message = pick(fart_emotes)
	message = replacetext(message, "%OWNER", "[user]")
	. = ..()
	if(.)
		playsound(user, pick(\
			'modular_eros/sound/voice/farts/fart.ogg',\
			'modular_eros/sound/voice/farts/fart1.ogg',\
			'modular_eros/sound/voice/farts/fart2.ogg',\
			'modular_eros/sound/voice/farts/fart3.ogg',\
			'modular_eros/sound/voice/farts/fart4.ogg',\
			'modular_eros/sound/voice/farts/fart5.ogg',\
			'modular_eros/sound/voice/farts/fart6.ogg'\
		), 50, 1)
	