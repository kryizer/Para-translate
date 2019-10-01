/obj/structure/lamarr
	name = "Lab Cage"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "labcage1"
	desc = "A glass lab container for storing interesting creatures."
	density = 1
	anchored = 1
	resistance_flags = ACID_PROOF
	var/health = 30
	var/occupied = 1
	var/destroyed = 0

/obj/structure/lamarr/proc/healthcheck()
	if(src.health <= 0)
		if(!( src.destroyed ))
			src.density = 0
			src.destroyed = 1
			new /obj/item/shard(loc)
			playsound(src, "shatter", 70, 1)
			Break()
	else
		playsound(src.loc, 'sound/effects/Glasshit.ogg', 75, 1)
	return

/obj/structure/lamarr/update_icon()
	if(src.destroyed)
		src.icon_state = "labcageb[src.occupied]"
	else
		src.icon_state = "labcage[src.occupied]"
	return


/obj/structure/lamarr/attackby(obj/item/W as obj, mob/user as mob, params)
	src.health -= W.force
	src.healthcheck()
	..()
	return

/obj/structure/lamarr/attack_hand(mob/user as mob)
	if(src.destroyed)
		return
	else
		user.visible_message("<span class='warning'>[user] kicks the lab cage.</span>", "<span class='notice'>You kick the lab cage.</span>")
		src.health -= 2
		healthcheck()
		return

/obj/structure/lamarr/proc/Break()
	if(occupied)
		new /obj/item/clothing/mask/facehugger/lamarr(src.loc)
		occupied = 0
	update_icon()
	return
