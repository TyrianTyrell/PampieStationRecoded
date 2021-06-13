/datum/component/tieddir/Initialize(...)
	. = ..()
	RegisterSignal(parent, COMSIG_BUCKLED_MOB_DIRECTION, .proc/matchdir)

/datum/component/tieddir/proc/matchdir(obj/structure/chair/source, mob/living/babbu)
	if(babbu.buckled == source)
		source.setDir(babbu.dir)

/datum/component/diaperswitch/Initialize(...)
	. = ..()
	RegisterSignal(parent, COMSIG_DIAPERCHANGE, .proc/changeundies)

/datum/component/diaperswitch/proc/changeundies(source, ckey)
	if(ishuman(parent))
		var/mob/living/carbon/human/butt = parent
		var/piss = copytext_char(ckey,1,2)
		var/underwear
		var/undie_color
		var/default_slot = 1
		if(fexists("data/player_saves/[piss]/[ckey]/preferences.sav"))
			var/savefile/S = new/savefile("data/player_saves/[piss]/[ckey]/preferences.sav")
			S.cd = "/"
			S["default_slot"] >> default_slot
			S.cd = "/character[default_slot]"
			S["underwear"] >> underwear
			S["undie_color"] >> undie_color
			sanitize_inlist(underwear, GLOB.underwear_list)
			sanitize_hexcolor(undie_color)
		else
			underwear = butt.baseunderwear
			undie_color = butt.undie_color
		if((HAS_TRAIT(butt,TRAIT_INCONTINENT) || HAS_TRAIT(butt,TRAIT_FULLYINCONTINENT) || HAS_TRAIT(butt,TRAIT_POTTYREBEL) || HAS_TRAIT(butt,BABYBRAINED_TRAIT) || HAS_TRAIT(butt,TRAIT_DIAPERUSE)))
			butt.underwear = "Diaper"
			switch(butt.brand)
				if("plain")
					butt.undie_color = undie_color
				if("classics")
					butt.undie_color = "6F6"
				if("swaddles")
					butt.undie_color = "39C"
				if("hefters_m")
					butt.undie_color = "EEF"
				if("hefters_f")
					butt.undie_color = "FDE"
				if("Princess")
					butt.undie_color = "F9F"
				if("PwrGame")
					butt.undie_color = "83F"
				if("StarKist")
					butt.undie_color = "F93"
				if("Space")
					butt.undie_color = "36C"
				if("Replica")
					butt.undie_color = "C00"
				if("Service")
					butt.undie_color = "999"
				if("Supply")
					butt.undie_color = "DB2"
				if("Hydroponics")
					butt.undie_color = "0F0"
				if("Sec")
					butt.undie_color = "111"
				if("Engineering")
					butt.undie_color = "FE0"
				if("Atmos")
					butt.undie_color = "FE0"
				if("Science")
					butt.undie_color = "609"
				if("Med")
					butt.undie_color = "48A"
		else
			butt.underwear = underwear
			butt.undie_color = undie_color
		butt.update_body()
