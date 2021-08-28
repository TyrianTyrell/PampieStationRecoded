//This is the file that handles donator loadout items.

/datum/gear/donator
	name = "IF YOU SEE THIS, PING A CODER RIGHT NOW!"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/bikehorn/golden
	category = LOADOUT_CATEGORY_DONATOR
	ckeywhitelist = list("This entry should never appear with this variable set.")

/datum/gear/donator/diaper_bag
	name = "diaper bag"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/storage/backpack/diaper_bag
	donator_group_id = PATREON_DONATOR

/datum/gear/donator/plain_diapers
	name = "Plain diaper pack"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/diaper_package/plain
	donator_group_id = PATREON_DONATOR

/datum/gear/donator/classic_diapers
	name = "CuddleCom Classic pack"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/diaper_package/classic
	cost = 2
	donator_group_id = PATREON_DONATOR

/datum/gear/donator/hefters_m
	name = "Hefters pack (male)"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/diaper_package/hefters_m
	cost = 2
	donator_group_id = PATREON_DONATOR

/datum/gear/donator/hefters_f
	name = "Hefters pack (female)"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/diaper_package/hefters_f
	cost = 2
	donator_group_id = PATREON_DONATOR
