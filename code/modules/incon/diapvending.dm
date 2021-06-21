/obj/machinery/vending/diaper
	name = "\improper Big Dipper diaper dispenser"
	desc = "A diaper vendor, here courtesy of Big Dipper Babies Inc."
	product_slogans = "Here to help babies big and small!"
	product_ads = "Does someone need a change? Big Dipper is here for the soggers and the stinkers~"
	icon = 'icons/incon/diaper.dmi'
	icon_state = "dvend_big"
	products = list(/obj/item/diaper/plain = 60,
					/obj/item/diaper/classic = 45,
					/obj/item/diaper/swaddles = 45,
					/obj/item/diaper/princess = 45,
					/obj/item/diaper/pwrgame = 45,
					/obj/item/diaper/starkist = 45,
					/obj/item/diaper/space = 45,
					/obj/item/storage/backpack/diaper_bag = 10)
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/diaper
	default_price = 10
	extra_price = 100
	payment_department = ACCOUNT_MED

/obj/item/vending_refill/diaper
	machine_name = "\improper Big Dipper diaper dispenser"
	icon = 'icons/incon/diaper.dmi'
	icon_state = "refill_diaper"

/obj/machinery/vending/walldiaper
	name = "\improper Little Dipper diaper dispenser"
	desc = "A wall-mounted diaper vendor, here courtesy of Big Dipper Babies Inc."
	product_slogans = "Here to help babies big and small!"
	product_ads = "Does someone need a change? Big Dipper is here for the soggers and the stinkers~"
	icon = 'icons/incon/diaper.dmi'
	icon_state = "dwall"
	density = FALSE
	products = list(/obj/item/diaper/plain = 60,
					/obj/item/diaper/classic = 45,
					/obj/item/diaper/swaddles = 45,
					/obj/item/diaper/princess = 45,
					/obj/item/diaper/pwrgame = 45,
					/obj/item/diaper/starkist = 45,
					/obj/item/diaper/space = 45,
					/obj/item/storage/backpack/diaper_bag = 10)
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/walldiaper
	default_price = 10
	extra_price = 100
	payment_department = ACCOUNT_MED
	tiltable = FALSE

/obj/item/vending_refill/walldiaper
    machine_name = "\improper Little Dipper diaper dispenser"
    icon = 'icons/incon/diaper.dmi'
    icon_state = "refill_diaper"
