/obj/machinery/vending/diaper
	name = "\improper Big Dipper diaper dispenser"
	desc = "A diaper vendor, here courtesy of Big Dipper Babies Inc."
	product_slogans = "Here to help babies big and small!"
	product_ads = "Does someone need a change? Big Dipper is here for the soggers and the stinkers~"
	icon = 'icons/incon/diaper.dmi'
	icon_state = "dvend_big"
	products = list(/obj/item/diaper/plain = 60,
					/obj/item/diaper/thirteen = 13,
					/obj/item/diaper/classic = 40,
					/obj/item/diaper/swaddles = 40,
					/obj/item/diaper/princess = 40,
					/obj/item/diaper/pwrgame = 40,
					/obj/item/diaper/starkist = 40,
					/obj/item/diaper/space = 40,
					/obj/item/diaper/jeans = 40,
					/obj/item/diaper/punk = 40,
					/obj/item/diaper/pink = 40,
					/obj/item/diaper/camo = 40,
					/obj/item/diaper/bee = 40,
					/obj/item/diaper/fish = 40,
					/obj/item/diaper/skunk = 40,
					/obj/item/diaper/matri = 40,
					/obj/item/diaper/rainbow = 40,
					/obj/item/diaper/ashwalker = 30,
					/obj/item/diaper/narsie = 15,
					/obj/item/diaper/ratvar = 15,
					/obj/item/diaper_package/plain = 10,
					/obj/item/diaper_package/classic = 10,
					/obj/item/diaper_package/jeans = 10,
					/obj/item/diaper/jeans_thick = 20,
					/obj/item/diaper/punk_thick = 20,
					/obj/item/diaper/pink_thick = 20,
					/obj/item/diaper/rainbow_thick = 20,
					/obj/item/reagent_containers/glass/sippycup = 5,
					/obj/item/reagent_containers/glass/babybottle = 5,
					/obj/item/storage/backpack/diaper_bag = 10,
					/obj/item/paci_package/nuk = 20,
					/obj/item/clothing/shoes/booties/pink = 5,
					/obj/item/clothing/shoes/booties/blue = 5,
					/obj/item/clothing/head/bonnet/pink = 5,
					/obj/item/clothing/head/bonnet/blue = 5,
					/obj/item/clothing/gloves/mittens/pink = 5,
					/obj/item/clothing/gloves/mittens/blue = 5)
	contraband = list(/obj/item/clothing/shoes/booties/poly = 5,
					/obj/item/clothing/gloves/mittens/poly = 5,
					/obj/item/clothing/head/bonnet/poly = 5,
					/obj/item/clothing/mask/polypacifier = 5,
					/obj/item/clothing/mask/pacivape = 5)
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/diaper
	default_price = 0
	extra_price = 0
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
	products = list(/obj/item/diaper/plain = 30,
					/obj/item/diaper/thirteen = 13,
					/obj/item/diaper/classic = 20,
					/obj/item/diaper/swaddles = 20,
					/obj/item/diaper/princess = 20,
					/obj/item/diaper/pwrgame = 20,
					/obj/item/diaper/starkist = 20,
					/obj/item/diaper/space = 20,
					/obj/item/diaper/jeans = 20,
					/obj/item/diaper/punk = 20,
					/obj/item/diaper/pink = 20,
					/obj/item/diaper/camo = 20,
					/obj/item/diaper/bee = 20,
					/obj/item/diaper/fish = 20,
					/obj/item/diaper/skunk = 20,
					/obj/item/diaper/matri = 20,
					/obj/item/diaper/rainbow = 20,
					/obj/item/diaper/ashwalker = 15,
					/obj/item/diaper/narsie = 5,
					/obj/item/diaper/ratvar = 5,
					/obj/item/diaper_package/plain = 5,
					/obj/item/diaper_package/classic = 5,
					/obj/item/diaper_package/jeans = 5,
					/obj/item/diaper/jeans_thick = 10,
					/obj/item/diaper/punk_thick = 10,
					/obj/item/diaper/pink_thick = 10,
					/obj/item/diaper/rainbow_thick = 10,
					/obj/item/reagent_containers/glass/sippycup = 2,
					/obj/item/reagent_containers/glass/babybottle = 2,
					/obj/item/storage/backpack/diaper_bag = 5,
					/obj/item/paci_package/nuk = 10,
					/obj/item/clothing/shoes/booties/pink = 2,
					/obj/item/clothing/shoes/booties/blue = 2,
					/obj/item/clothing/head/bonnet/pink = 2,
					/obj/item/clothing/head/bonnet/blue = 2,
					/obj/item/clothing/gloves/mittens/pink = 2,
					/obj/item/clothing/gloves/mittens/blue = 2)
	contraband = list(/obj/item/clothing/shoes/booties/poly = 1,
					/obj/item/clothing/gloves/mittens/poly = 1,
					/obj/item/clothing/head/bonnet/poly = 1,
					/obj/item/clothing/mask/polypacifier = 1,
					/obj/item/clothing/mask/pacivape = 1)
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/walldiaper
	default_price = 0
	extra_price = 0
	payment_department = ACCOUNT_MED
	tiltable = FALSE

/obj/item/vending_refill/walldiaper
    machine_name = "\improper Little Dipper diaper dispenser"
    icon = 'icons/incon/diaper.dmi'
    icon_state = "refill_diaper"
