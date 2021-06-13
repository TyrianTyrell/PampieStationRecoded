/obj/item/gun/energy/regressoray
	name = "regression ray"
	desc = "A ray-gun that temporarily mentally regresses the target, leaving them baby-brained for a few minutes."
	icon = 'icons/incon/regressoray.dmi'
	icon_state = "regression_ray"
	ammo_type = list(/obj/item/ammo_casing/energy/regression)
	ammo_x_offset = 1
	selfcharge = 1
	item_flags = NONE

/obj/item/gun/energy/regressoray/suicide_act(mob/living/carbon/user)
	if (istype(user) && can_shoot() && can_trigger_gun(user) && user.get_bodypart(BODY_ZONE_HEAD))
		user.visible_message("<span class='suicide'>[user] is putting the barrel of the [src] in their mouth. It looks like [p_theyre()] trying to commit suicide...?!</span>")
		sleep(10)
		user.visible_message("<span class='suicide'>[user] fired the [src] upon [p_them()]selves! It looks like [p_they()] decided not to think, and just stink.</span>")
		if(user.regressiontimer <= 0)
			if(user.m_intent == MOVE_INTENT_RUN)
				user.toggle_move_intent()
			ADD_TRAIT(user, BABYBRAINED_TRAIT, REGRESSION_TRAIT)
			ADD_TRAIT(user, TRAIT_NORUNNING, REGRESSION_TRAIT)
			ADD_TRAIT(user, TRAIT_NOGUNS, REGRESSION_TRAIT)
			SEND_SIGNAL(user, COMSIG_DIAPERCHANGE, user.ckey)
			user.statusoverlay = mutable_appearance('icons/incon/regressoray.dmi',"regressoray")
			user.overlays += user.statusoverlay
		user.regressiontimer = 5000

/obj/item/ammo_casing/energy/regression
	fire_sound = 'sound/effects/stealthoff.ogg'
	harmful = FALSE
	projectile_type = /obj/item/projectile/energy/regression

/obj/item/projectile/energy/regression
	name = "psi-chronoray"
	icon_state = "energy2"
	damage = 0
	damage_type = TOX
	nodamage = TRUE
	flag = "energy"

/obj/item/projectile/energy/regression/on_hit(mob/living/carbon/target, blocked = FALSE)
	. = ..()
	if(isliving(target) && (!iswizard(target) && !HAS_TRAIT(target, CHANGELING_TRAIT) && !HAS_TRAIT(target, TRAIT_MINDSHIELD)))
		if(target.regressiontimer <= 0)
			if(target.m_intent == MOVE_INTENT_RUN)
				target.toggle_move_intent()
			ADD_TRAIT(target, BABYBRAINED_TRAIT, REGRESSION_TRAIT)
			ADD_TRAIT(target, TRAIT_NORUNNING, REGRESSION_TRAIT)
			ADD_TRAIT(target, TRAIT_NOGUNS, REGRESSION_TRAIT)
			SEND_SIGNAL(target, COMSIG_DIAPERCHANGE, target.ckey)
			target.statusoverlay = mutable_appearance('icons/incon/regressoray.dmi',"regressoray")
			target.overlays += target.statusoverlay
		target.regressiontimer = 5000

/obj/item/gun/energy/regressorayjb
	name = "regression ray"
	desc = "A ray-gun that temporarily mentally regresses the target, leaving them baby-brained for a few minutes."
	icon = 'icons/incon/regressoray.dmi'
	icon_state = "regression_ray"
	ammo_type = list(/obj/item/ammo_casing/energy/regressionjb)
	ammo_x_offset = 1
	selfcharge = 1

/obj/item/ammo_casing/energy/regressionjb
	fire_sound = 'sound/effects/stealthoff.ogg'
	harmful = FALSE
	projectile_type = /obj/item/projectile/energy/regressionjb

/obj/item/projectile/energy/regressionjb/
	name = "psi-chronoray"
	icon_state = "energy2"
	damage = 0
	damage_type = TOX
	nodamage = TRUE
	flag = "energy"

/obj/item/projectile/energy/regressionjb/on_hit(mob/living/carbon/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		if(target.regressiontimer <= 0)
			if(target.m_intent == MOVE_INTENT_RUN)
				target.toggle_move_intent()
			ADD_TRAIT(target, BABYBRAINED_TRAIT, REGRESSION_TRAIT)
			ADD_TRAIT(target, TRAIT_NORUNNING, REGRESSION_TRAIT)
			ADD_TRAIT(target, TRAIT_NOGUNS, REGRESSION_TRAIT)
			SEND_SIGNAL(target, COMSIG_DIAPERCHANGE, target.ckey)
			target.statusoverlay = mutable_appearance('icons/incon/regressoray.dmi',"regressoray")
			target.overlays += target.statusoverlay
		target.regressiontimer = 5000

/obj/item/gun/energy/regressorayjb/suicide_act(mob/living/carbon/user)
	if (istype(user) && can_shoot() && can_trigger_gun(user) && user.get_bodypart(BODY_ZONE_HEAD))
		user.visible_message("<span class='suicide'>[user] is putting the barrel of the [src] in their mouth. It looks like [p_theyre()] trying to commit suicide...?!</span>")
		sleep(10)
		user.visible_message("<span class='suicide'>[user] fired the [src] upon [p_them()]selves! It looks like [p_they()] decided not to think, and just stink.</span>")
		if(user.regressiontimer <= 0)
			if(user.m_intent == MOVE_INTENT_RUN)
				user.toggle_move_intent()
			ADD_TRAIT(user, BABYBRAINED_TRAIT, REGRESSION_TRAIT)
			ADD_TRAIT(user, TRAIT_NORUNNING, REGRESSION_TRAIT)
			ADD_TRAIT(user, TRAIT_NOGUNS, REGRESSION_TRAIT)
			SEND_SIGNAL(user, COMSIG_DIAPERCHANGE, user.ckey)
			user.statusoverlay = mutable_appearance('icons/incon/regressoray.dmi',"regressoray")
			user.overlays += user.statusoverlay
		user.regressiontimer = 5000
