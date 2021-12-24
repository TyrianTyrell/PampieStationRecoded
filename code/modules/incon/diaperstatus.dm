/mob/living/carbon/var/pee = 0
/mob/living/carbon/var/poop = 0
/mob/living/carbon/var/wetness = 0
/mob/living/carbon/var/stinkiness = 0
/mob/living/carbon/var/fluids = 0
/mob/living/var/max_wetcontinence = 100
/mob/living/var/max_messcontinence = 100
/mob/living/carbon/var/on_purpose = 0
/mob/living/carbon/var/brand = "plain"
/mob/living/carbon/var/brand2 = "diaper"
/mob/living/carbon/var/brand3 = "plain"
/mob/living/carbon/var/heftersbonus = 0
/mob/living/carbon/var/needpee = 0
/mob/living/carbon/var/needpoo = 0
/mob/living/carbon/var/regressiontimer = 0
/mob/living/carbon/var/stinky = FALSE
/mob/living/carbon/var/statusoverlay = null
/mob/living/var/combatoverlay = null
/mob/var/rollbonus = 0
/obj/item/var/soiled = FALSE
/mob/living/carbon/human/var/soiledunderwear = FALSE
/mob/living/carbon/human/var/wearingpoopy = FALSE

var/database/db = new("code/modules/incon/InconFlavortextDB.db")
var/database/query/testingQuery = new("SELECT selfmessage FROM InconFlavortextDB LIMIT 1")
//var/database/query/wettingQuery = new("SELECT othersmessage, selfmessage FROM InconFlavortextDB WHERE usingpotty = 1")

/mob/living/carbon/human/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/diaperswitch)

/mob/living/carbon/proc/Wetting()

	//
	// Variables for the SQL Query - Hopefully, these are cleared and reinitialized every time this script(?) is called
	//
	// onPotty should be 1 if the player is buckled onto a potty
	// onToilet should be 1 if the player is bucked onto a toilet
	//
	var/onPotty = 0
	var/onToilet = 0
	//
	// End of SQL useful variables

	if (pee > 0 && stat != DEAD && src.client.prefs != "Poop Only") //this checks if the player actually needs to pee, is alive, and has pee enabled
		needpee = 0
		if(src.client.prefs.accident_sounds == TRUE)
			playsound(loc, 'sound/effects/pee-diaper.wav', 50, 1)

		//if the player makes it to a potty or toilet, they are rewarded with an increase in their continence
		if (istype(src.buckled,/obj/structure/potty) || istype(src.buckled,/obj/structure/toilet))
			if (max_wetcontinence < 100)
				max_wetcontinence++

		//if they player is on a potty or toilet, we're flagging the appropriate variable
		if (istype(src.buckled,/obj/structure/potty))
			onPotty = 1
		if (istype(src.buckled,/obj/structure/toilet))
			onToilet = 1

		//if the amount of pee inside a player is higher than the max continence, we knock it down to the max continence
		if(pee > max_wetcontinence)
			pee = max_wetcontinence

		//this block of code allows people to pee on the floor if they're nude (in the future)
		if(ishuman(src))
			var/mob/living/carbon/human/H = src
			if(H.hidden_underwear == TRUE || H.underwear == "Nude")
				pee = 0
				new /obj/effect/decal/cleanable/waste/peepee(loc)

		//this block updates the wetness of the diaper
		//
		//if the "wetness" of the diaper won't be overflowing, even with the pee about to be added, it's added like normal
		//otherwise, the wetness of the diaper is set to it's max, and a pee puddle is spawned on the floor
		//
		//if leaking occurs, the player is penalized with an extra reduction in continence, unlesss they're already under 25% continent
		if(wetness + pee < 200 + heftersbonus)
			wetness = wetness + pee
			pee = 0
		else
			wetness = 200 + heftersbonus
			new /obj/effect/decal/cleanable/waste/peepee(loc)
		if(max_wetcontinence > 25)
			max_wetcontinence-=1

		//finally, we want to display the actual pee flavortext
		//
		//we start by checkinng if the player is totally incontinent

		if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
			//var/database/query/wettingQuery = new("SELECT * FROM InconFlavortextDB WHERE (usingpotty = ? AND usingtoilet = ? AND onpurpose = ? AND peeaccident = TRUE)",onPotty, onToilet, on_purpose)
			var/database/query/wettingQuery = new("SELECT * FROM InconFlavortextDB WHERE ((usingpotty = ?) AND (usingtoilet = ?) AND (onpurpose = ?) AND (peeaccident = 1)) ORDER BY RANDOM() LIMIT 1", onPotty, onToilet,on_purpose)

			if(!wettingQuery.Execute(db))
				to_chat(src,wettingQuery.ErrorMsg())
				to_chat(src,db.ErrorMsg())
				to_chat(src,wettingQuery.Columns())
			else
				wettingQuery.NextRow()
				var/wettingQueryResponse = wettingQuery.GetRowData()
				src.visible_message(wettingQueryResponse["othersmessage"],wettingQueryResponse["selfmessage"])

		//at the end of things, we set the player's pee to zero, and clear the "on_purpose" flag
		pee = 0
		on_purpose = 0
		//and thats the end of the pee action!

	else if (stat == DEAD)
		to_chat(src,"You can't pee, you're dead!")

/mob/living/carbon/proc/Pooping()

	//
	// Variables for the SQL Query - Hopefully, these are cleared and reinitialized every time this script(?) is called
	//
	// onPotty should be 1 if the player is buckled onto a potty
	// onToilet should be 1 if the player is bucked onto a toilet
	//
	var/onPotty = 0 //reminder : reimplement if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
	var/onToilet = 0
	//
	// End of SQL useful variables


	if (poop > 0 && stat != DEAD && src.client.prefs != "Pee Only") //this checks if the player actually needs to poop, is alive, and has poop enabled
		needpoo = 0
		if(src.client.prefs.accident_sounds == TRUE)
			playsound(loc, 'sound/effects/uhoh.ogg', 50, 1)

		//if they player is on a potty or toilet, we're flagging the appropriate variable
		if (istype(src.buckled,/obj/structure/potty))
			onPotty = 1
		if (istype(src.buckled,/obj/structure/toilet))
			onToilet = 1

		//if the amount of poop inside a player is higher than the max continence, we knock it down to the max continence
		if(poop > max_messcontinence)
			poop = max_messcontinence



		//if the player makes it to a potty or toilet, they are rewarded with an increase in their continence
		if (istype(src.buckled,/obj/structure/potty) || istype(src.buckled,/obj/structure/toilet))
			if (max_messcontinence < 100)
				max_messcontinence++

		//this removes continence from the player if they use their diaper
		if(max_messcontinence > 20)
			max_messcontinence-=2


		//this block controls the state of your displayed clothing, and also diaper capacity
		//which makes some sense, I guess
		if(ishuman(src))
			var/mob/living/carbon/human/H = src
			if((H.hidden_underwear == TRUE || H.underwear == "Nude") && !H.dna.features["taur"])
				if(H.w_uniform != null)
					H.w_uniform.soiled = TRUE
					H.update_inv_w_uniform()
				else
					if(H.wear_suit != null)
						H.wear_suit.soiled = TRUE
						H.update_inv_wear_suit()
				poop = 0
			if(stinkiness + poop < 150 + heftersbonus) //looks like 150 is the hardcoded default diaper capacity
				stinkiness = stinkiness + poop
				if(H.hidden_underwear == FALSE && H.underwear != "Nude")
					H.soiledunderwear = TRUE
					H.update_body()
			else
				stinkiness = 150 + heftersbonus
				if(H.hidden_underwear == FALSE && H.underwear != "Nude")
					H.soiledunderwear = TRUE
					H.update_body()

		//this block gives you stink lines if you don't already have them, and you meet the criteria
		if(stinkiness > ((150 + heftersbonus) / 2) && stinky == FALSE)
			statusoverlay = mutable_appearance('icons/incon/Effects.dmi',"generic_mob_stink",STINKLINES_LAYER, color = rgb(125, 241, 16))
			overlays += statusoverlay
			stinky = TRUE

		to_chat(src, "Todo: add messages for messing")


		on_purpose = 0
		poop = 0

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	else if (stat == DEAD)
		to_chat(src,"You can't poop, you're dead!")

/mob/living/carbon/proc/PampUpdate()
	if(src.client != null)
		if(src.client.prefs.accident_types != "Opt Out")
			if(src.client.prefs.accident_types != "Poop Only")
				pee = pee + ((20 + rand(0, 10))/100) + (fluids / 3000)
				if(HAS_TRAIT(src, TRAIT_STINKER))
					pee = pee + 0.05
			else
				pee = 0
			if(src.client.prefs.accident_types != "Pee Only")
				poop = poop + ((50 + rand(0,50))/1000) + (nutrition / 5000)
				if(HAS_TRAIT(src, TRAIT_STINKER))
					poop = poop + 0.025
			else
				poop = 0
		if(!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
			if (wetness >= 1)
				if (HAS_TRAIT(src,TRAIT_POTTYREBEL))
					SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"peepee",/datum/mood_event/soggyhappy)
				else
					SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"peepee",/datum/mood_event/soggysad)
			else
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"peepee")
			if (stinkiness >= 1)
				if (HAS_TRAIT(src,TRAIT_POTTYREBEL))
					SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"poopy",/datum/mood_event/stinkyhappy)
				else
					SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"poopy",/datum/mood_event/stinkysad)
			else
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"poopy")
		if (fluids > 0)
			fluids = fluids - 10
		if (fluids < 0)
			fluids = 0


		if (pee >= max_wetcontinence * 0.5 && needpee <= 0 && !HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
			var/database/query/peeFirstWarningQuery = new("SELECT selfmessage FROM InconFlavortextDB WHERE (peefirstwarning = 1) ORDER BY RANDOM()")
			if(!peeFirstWarningQuery.Execute(db))
				to_chat(src,peeFirstWarningQuery.ErrorMsg())
				to_chat(src,db.ErrorMsg())
				to_chat(src,peeFirstWarningQuery.Columns())
			else
				peeFirstWarningQuery.NextRow()
				var/peeFirstWarningQueryResponse = peeFirstWarningQuery.GetRowData()
				to_chat(src,peeFirstWarningQueryResponse["selfmessage"])
			needpee += 1
		if (pee >= max_wetcontinence * 0.8 && needpee <= 1 && !HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
			var/database/query/peeSecondWarningQuery = new("SELECT selfmessage FROM InconFlavortextDB WHERE (peesecondwarning = 1) ORDER BY RANDOM()")
			if(!peeSecondWarningQuery.Execute(db))
				to_chat(src,peeSecondWarningQuery.ErrorMsg())
				to_chat(src,db.ErrorMsg())
				to_chat(src,peeSecondWarningQuery.Columns())
			else
				peeSecondWarningQuery.NextRow()
				var/peeSecondWarningQueryResponse = peeSecondWarningQuery.GetRowData()
				to_chat(src,peeSecondWarningQueryResponse["selfmessage"])
			needpee += 1

		if (poop >= max_messcontinence * 0.5 && needpoo <= 0 && !HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
			var/database/query/pooFirstWarningQuery = new("SELECT selfmessage FROM InconFlavortextDB WHERE (poofirstwarning = 1) ORDER BY RANDOM()")
			if(!pooFirstWarningQuery.Execute(db))
				to_chat(src,pooFirstWarningQuery.ErrorMsg())
				to_chat(src,db.ErrorMsg())
				to_chat(src,pooFirstWarningQuery.Columns())
			else
				pooFirstWarningQuery.NextRow()
				var/pooFirstWarningQueryResponse = pooFirstWarningQuery.GetRowData()
				to_chat(src,pooFirstWarningQueryResponse["selfmessage"])
			needpoo += 1
		if (poop >= max_messcontinence * 0.8 && needpoo <= 1 && !HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
			var/database/query/pooSecondWarningQuery = new("SELECT selfmessage FROM InconFlavortextDB WHERE (poosecondwarning = 1) ORDER BY RANDOM()")
			if(!pooSecondWarningQuery.Execute(db))
				to_chat(src,pooSecondWarningQuery.ErrorMsg())
				to_chat(src,db.ErrorMsg())
				to_chat(src,pooSecondWarningQuery.Columns())
			else
				pooSecondWarningQuery.NextRow()
				var/pooSecondWarningQueryResponse = pooSecondWarningQuery.GetRowData()
				to_chat(src,pooSecondWarningQueryResponse["selfmessage"])
			needpoo += 1

		if (pee >= max_wetcontinence && src.client.prefs != "Poop Only")
			Wetting()
		else if(pee >= max_wetcontinence)
			pee = 0
		if (poop >= max_messcontinence && src.client.prefs != "Pee Only")
			Pooping()
		else if(poop >= max_messcontinence)
			poop = 0
		switch(brand)
			if ("plain")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("classics")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("swaddles")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"sanshield",/datum/mood_event/sanitydiaper)
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("hefters_m")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("hefters_f")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Princess")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = TRUE
				rollbonus = 0
			if ("PwrGame")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 1
			if ("StarKist")
				set_light(3)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Space")
				set_light(0)
				ADD_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Replica")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
				adjustBruteLoss(-0.5)
			if ("Service")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Supply")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Hydroponics")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Sec")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Engineering")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Atmos")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Science")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Med")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Cult_Nar")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Cult_Clock")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Miner")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Miner_thick")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Ashwalker")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("alien")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Jeans")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("hyper")	//TESTING HYPER STUFF HERE!!!
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				SEND_SIGNAL(src,COMSIG_DIAPERCHANGE,src.ckey)
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
	spawn(60)
		PampUpdate()

/mob/living/carbon/proc/DiaperAppearance()
	SEND_SIGNAL(src,COMSIG_DIAPERCHANGE, ckey(src.mind.key))


/mob/living/carbon/proc/DiaperChange(obj/item/diaper/diap)
	var/turf/cuckold = null
	var/newpamp
	switch(src.dir)
		if(1)
			cuckold = locate(src.loc.x + 1,src.loc.y,src.loc.z)
		if(2)
			cuckold = locate(src.loc.x - 1,src.loc.y,src.loc.z)
		if(4)
			cuckold = locate(src.loc.x,src.loc.y - 1,src.loc.z)
		if(8)
			cuckold = locate(src.loc.x,src.loc.y + 1,src.loc.z)
	if(brand == "syndi")
		brand = "plain"
	if (wetness >= 1)
		if (stinkiness >= 1)
			newpamp = text2path(addtext("/obj/item/useddiap/", brand))
		else
			newpamp = text2path(addtext("/obj/item/wetdiap/", brand))
	else
		if (stinkiness >= 1)
			newpamp = text2path(addtext("/obj/item/poopydiap/", brand))
		else
			newpamp = text2path(addtext("/obj/item/diaper/", brand))
	new newpamp(cuckold)
	wetness = 0
	stinkiness = 0
	overlays -= statusoverlay
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		H.soiledunderwear = FALSE
		H.update_body()
	stinky = FALSE
	brand = replacetext("[diap.type]", "/obj/item/diaper/", "")
	if(HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
		SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"peepee")
		SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"poopy")

/mob/living/carbon/verb/Pee()
	if(usr.client.prefs.accident_types != "Opt Out" || usr.client.prefs.accident_types != "Poop Only")
		set category = "IC"
	if(src.client.prefs.accident_types != "Opt Out" && !HAS_TRAIT(usr,TRAIT_FULLYINCONTINENT) && pee >= max_wetcontinence/2)
		on_purpose = 1
		Wetting()
	else
		to_chat(usr, "<span class='warning'>You cannot pee right now.</span>")

/mob/living/carbon/verb/Poop()
	if(usr.client.prefs.accident_types != "Opt Out" || usr.client.prefs.accident_types != "Pee Only")
		set category = "IC"
	if(src.client.prefs.accident_types != "Opt Out" && !HAS_TRAIT(usr,TRAIT_FULLYINCONTINENT) && poop >= max_messcontinence/2)
		on_purpose = 1
		Pooping()
	else
		to_chat(usr, "<span class='warning'>You cannot poop right now.</span>")

/mob/living/carbon/New()
	..()
	PampUpdate()

/obj/item/reagent_containers/food/snacks/attack(mob/living/carbon/human/M, mob/living/user, def_zone)
	..()
	if(M.client.prefs.accident_types != "Pee Only")
		M.poop = M.poop + 1

/obj/item/reagent_containers/food/drinks/attack(mob/living/carbon/human/M, mob/living/user, def_zone)
	..()
	if(M.client.prefs.accident_types != "Poop Only")
		M.pee = M.pee + 2
	M.fluids = M.fluids + 25
	if (M.fluids > 300)
		M.fluids = 300

/atom/movable/screen/diaperstatus
	name = "diaper state"
	icon = 'icons/incon/diapercondition.dmi'
	icon_state = "hud_plain"
	screen_loc = ui_diaper
	var/datum/component/waddle

/atom/movable/screen/diaperstatus/proc/DiaperUpdate(mob/living/carbon/owner)
	if(HAS_TRAIT(owner,BABYBRAINED_TRAIT))
		if(owner.regressiontimer > 0)
			owner.regressiontimer--
		else if(owner.reagents.has_reagent(/datum/reagent/medicine/regression))
			owner.regressiontimer = 0
		else
			REMOVE_TRAIT(owner,BABYBRAINED_TRAIT,REGRESSION_TRAIT)
			REMOVE_TRAIT(owner,TRAIT_NORUNNING,REGRESSION_TRAIT)
			REMOVE_TRAIT(owner,TRAIT_NOGUNS,REGRESSION_TRAIT)
			SEND_SIGNAL(owner,COMSIG_DIAPERCHANGE,owner.ckey)
	if(usr.client.prefs.accident_types != "Opt Out" && !HAS_TRAIT(owner,TRAIT_FULLYINCONTINENT))
		if (owner.wetness > 0)
			if (owner.stinkiness > 0)
				icon_state = "hud_plain_used"
			else
				icon_state = "hud_plain_wet"
		else
			if (owner.stinkiness > 0)
				icon_state = "hud_plain_poopy"
			else
				icon_state = "hud_plain"
	else
		icon_state = null
	if(owner.brand == "Science")
		SSresearch.science_tech.add_point_type(TECHWEB_POINT_TYPE_GENERIC, 0.25)
	if(owner.brand == "alien")
		owner.wetness -= 0.1
		owner.stinkiness -= 0.1
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.wearingpoopy = (H.wear_suit?.soiled == TRUE || H.w_uniform?.soiled == TRUE || (H.soiledunderwear == TRUE && H.stinkiness == 150 + H.heftersbonus && H.hidden_underwear == FALSE))
		if(HAS_TRAIT_FROM(H,TRAIT_NORUNNING, POOPYTRAIT))
			if(H.wearingpoopy == FALSE)
				QDEL_NULL(waddle)
				REMOVE_TRAIT(H,TRAIT_NORUNNING,POOPYTRAIT)
		else
			if(H.wearingpoopy == TRUE)
				waddle = H.AddComponent(/datum/component/waddling)
				ADD_TRAIT(H,TRAIT_NORUNNING,POOPYTRAIT)
				if(H.m_intent == MOVE_INTENT_RUN)
					H.toggle_move_intent()
	spawn(1)
		DiaperUpdate(owner)

/atom/movable/screen/diaperstatus/New(mob/living/carbon/owner)
	DiaperUpdate(owner)

/datum/hud/human/New(mob/living/carbon/owner)
	..()
	var/atom/movable/screen/diapstats = new /atom/movable/screen/diaperstatus(owner)
	if (HAS_TRAIT(owner,TRAIT_INCONTINENT))
		owner.max_wetcontinence = 50
		owner.max_messcontinence = 50
	else
		owner.max_wetcontinence = 100
		owner.max_messcontinence = 100
	diapstats.hud = src
	infodisplay += diapstats

/obj/effect/decal/cleanable/waste
	icon = 'icons/incon/accidents.dmi'
	gender = NEUTER

/obj/effect/decal/cleanable/waste/peepee
	name = "urine"
	desc = "A puddle of urine. Looks like we have a leaker."
	icon_state = "peepee"
	persistent = FALSE

/obj/effect/decal/cleanable/waste/peepee/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	AddComponent(/datum/component/slippery, 80, (NO_SLIP_WHEN_WALKING | SLIDE))

/datum/mood_event/soggysad
	description = "<span class='warning'>Aw man, my pants are wet...\n</span>"
	mood_change = -3

/datum/mood_event/soggyhappy
	description = "<span class='nicegreen'>A wet diaper is always comfy!\n</span>"
	mood_change = 3

/datum/mood_event/stinkysad
	description = "<span class='warning'>Ew... I need a change.\n</span>"
	mood_change = -5

/datum/mood_event/stinkyhappy
	description = "<span class='nicegreen'>Heh, take that, potty!\n</span>"
	mood_change = 5

/datum/mood_event/sanitydiaper
	description = "<span class='nicegreen'>I can't describe it- this diaper makes me feel safe!\n</span>"
	mood_change = 20
