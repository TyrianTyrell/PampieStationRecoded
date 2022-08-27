/datum/round_event_control/disability
	name = "Spontaneous Disability"
	typepath = /datum/round_event/spontaneous_disability
	weight = 8
	min_players = 3
	max_occurrences = 1

/datum/round_event/spontaneous_disability
	fakeable = FALSE

/datum/round_event/spontaneous_disability/start()
	for(var/mob/living/carbon/human/H in shuffle(GLOB.alive_mob_list))
		if(!H.client)
			continue
		if(H.stat == DEAD) // What are you doing in this list
			continue
		if(!H.getorgan(/obj/item/organ/brain)) // If only I had a brain
			continue
		if(HAS_TRAIT(H,TRAIT_EXEMPT_HEALTH_EVENTS))
			continue
		if(!is_station_level(H.z))
			continue
		traumatize(H)
		announce_to_ghosts(H)
		break

/datum/round_event/spontaneous_disability/proc/traumatize(mob/living/carbon/human/H)
	var/trauma = pickweight(list(
		/datum/brain_trauma/severe/deaf = 5,
		/datum/brain_trauma/severe/blindness = 5,
		/datum/brain_trauma/severe/mute = 10,
		/datum/brain_trauma/severe/paralysis/paraplegic = 10
	))

	H.gain_trauma(trauma, TRAUMA_RESILIENCE_ABSOLUTE)
