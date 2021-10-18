/obj/machinery/power/miasmic
	name = "miasmic generator"
	desc = "A generator that turns methane and other waste gasses into power."
	icon_state = "teg"
	density = TRUE
	use_power = NO_POWER_USE

	var/stinkarea = 0
	var/stinkspent = -1

/obj/machinery/power/miasmic/Initialize(mapload)
	. = ..()
	connect_to_network()
	SSair.atmos_machinery += src

/obj/machinery/power/miasmic/Destroy()
	SSair.atmos_machinery -= src
	return ..()

/obj/machinery/power/miasmic/process()
	var/output = round(stinkarea / 10)
	add_avail(output)
	stinkarea -= output
	stinkspent = output
	for(var/turf/T in RANGE_TURFS(3, src.loc))
		var/datum/gas_mixture/G = T.return_air()
		stinkarea += ((G.get_moles(GAS_DIAPERSMELL) + G.get_moles(GAS_MIASMA) + G.get_moles(GAS_METHANE)) * 200)
		G.set_moles(GAS_DIAPERSMELL, (G.get_moles(GAS_DIAPERSMELL) * 0.75))
		G.set_moles(GAS_MIASMA, (G.get_moles(GAS_MIASMA) * 0.75))
		G.set_moles(GAS_METHANE, (G.get_moles(GAS_METHANE) * 0.75))
		if(stinkarea >= 1000000)
			stinkarea = 1000000

/obj/machinery/power/miasmic/wrench_act(mob/living/user, obj/item/I)
	if(!panel_open)
		return
	anchored = !anchored
	I.play_tool_sound(src)
	connect_to_network()
	to_chat(user, "<span class='notice'>You [anchored?"secure":"unsecure"] [src].</span>")
	return TRUE
