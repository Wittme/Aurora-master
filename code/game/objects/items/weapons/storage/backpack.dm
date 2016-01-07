
/*
 * Backpack
 */

/obj/item/weapon/storage/backpack
	name = "backpack"
	desc = "You wear this on your back and put items into it."
	icon_state = "backpack"
	item_state = "backpack"
	w_class = 4.0
	flags = FPRINT|TABLEPASS
	slot_flags = SLOT_BACK	//ERROOOOO
	max_w_class = 3
	max_combined_w_class = 21

/obj/item/weapon/storage/backpack/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (src.use_sound)
		playsound(src.loc, src.use_sound, 50, 1, -5)
	..()

/obj/item/weapon/storage/backpack/equipped(var/mob/user, var/slot)
	if (slot == slot_back && src.use_sound)
		playsound(src.loc, src.use_sound, 50, 1, -5)
	..(user, slot)

/*
/obj/item/weapon/storage/backpack/dropped(mob/user as mob)
	if (loc == user && src.use_sound)
		playsound(src.loc, src.use_sound, 50, 1, -5)
	..(user)
*/

/*
 * Backpack Types
 */

/obj/item/weapon/storage/backpack/holding
	name = "bag of holding"
	desc = "A backpack that opens into a localized pocket of Blue Space."
	origin_tech = "bluespace=4"
	icon_state = "holdingpack"
	max_w_class = 4
	max_combined_w_class = 28

	New()
		..()
		return

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(crit_fail)
			user << "\red The Bluespace generator isn't working."
			return
		if(istype(W, /obj/item/weapon/storage/backpack/holding) && !W.crit_fail)
			user << "\red The Bluespace interfaces of the two devices conflict and malfunction."
			del(W)
			return
			/* //BoH+BoH=Singularity, commented out.
		if(istype(W, /obj/item/weapon/storage/backpack/holding) && !W.crit_fail)
			investigate_log("has become a singularity. Caused by [user.key]","singulo")
			user << "\red The Bluespace interfaces of the two devices catastrophically malfunction!"
			del(W)
			var/obj/machinery/singularity/singulo = new /obj/machinery/singularity (get_turf(src))
			singulo.energy = 300 //should make it a bit bigger~
			message_admins("[key_name_admin(user)] detonated a bag of holding")
			log_game("[key_name(user)] detonated a bag of holding")
			del(src)
			return
			*/
		..()

	proc/failcheck(mob/user as mob)
		if (prob(src.reliability)) return 1 //No failure
		if (prob(src.reliability))
			user << "\red The Bluespace portal resists your attempt to add another item." //light failure
		else
			user << "\red The Bluespace generator malfunctions!"
			for (var/obj/O in src.contents) //it broke, delete what was in it
				del(O)
			crit_fail = 1
			icon_state = "brokenpack"


/obj/item/weapon/storage/backpack/santabag
	name = "Santa's Gift Bag"
	desc = "Space Santa uses this to deliver toys to all the nice children in space in Christmas! Wow, it's pretty big!"
	icon_state = "giftbag0"
	item_state = "giftbag"
	w_class = 4.0
	storage_slots = 20
	max_w_class = 3
	max_combined_w_class = 400 // can store a ton of shit!

/obj/item/weapon/storage/backpack/cultpack
	name = "trophy rack"
	desc = "It's useful for both carrying extra gear and proudly declaring your insanity."
	icon_state = "cultpack"

/obj/item/weapon/storage/backpack/clown
	name = "Giggles von Honkerton"
	desc = "It's a backpack made by Honk! Co."
	icon_state = "clownpack"
	item_state = "clownpack"

/obj/item/weapon/storage/backpack/emt
	name = "emergency medical backpack"
	desc = "It's a tough backpack used by first responders."
	icon_state = "emtpack"
	item_state = "emtpack"

/obj/item/weapon/storage/backpack/medic
	name = "medical backpack"
	desc = "It's a backpack especially designed for use in a sterile environment."
	icon_state = "medicalpack"
	item_state = "medicalpack"

/obj/item/weapon/storage/backpack/security
	name = "security backpack"
	desc = "It's a very robust backpack."
	icon_state = "securitypack"
	item_state = "securitypack"

/obj/item/weapon/storage/backpack/captain
	name = "captain's backpack"
	desc = "It's a special backpack made exclusively for Nanotrasen officers."
	icon_state = "captainpack"
	item_state = "captainpack"

/obj/item/weapon/storage/backpack/industrial
	name = "industrial backpack"
	desc = "It's a tough backpack for the daily grind of station life."
	icon_state = "engiepack"
	item_state = "engiepack"

/obj/item/weapon/storage/backpack/syndie
	name = "syndicate rucksack"
	desc = "The latest in carbon fiber and red satin combat rucksack technology. Comfortable and tough!"
	icon_state = "syndiepack"

/obj/item/weapon/storage/backpack/wizard
	name = "wizard federation sack"
	desc = "Perfect for keeping your shining crystal balls inside of."
	icon_state = "wizardpack"

/*
 * Satchel Types
 */

/obj/item/weapon/storage/backpack/satchel
	name = "leather satchel"
	desc = "It's a very fancy satchel made with fine leather."
	icon_state = "satchel"

/obj/item/weapon/storage/backpack/satchel/emt
	name = "emergency medical satchel"
	desc = "It's a tough satchel used by first responders."
	icon_state = "satchel-emt"
	item_state = "satchel-emt"

/obj/item/weapon/storage/backpack/satchel/withwallet
	New()
		..()
		new /obj/item/weapon/storage/wallet/random( src )

/obj/item/weapon/storage/backpack/satchel_norm
	name = "satchel"
	desc = "A trendy looking satchel."
	icon_state = "satchel-norm"

/obj/item/weapon/storage/backpack/satchel_eng
	name = "industrial satchel"
	desc = "A tough satchel with extra pockets."
	icon_state = "satchel-eng"
	item_state = "engiepack"

/obj/item/weapon/storage/backpack/satchel_med
	name = "medical satchel"
	desc = "A sterile satchel used in medical departments."
	icon_state = "satchel-med"
	item_state = "medicalpack"

/obj/item/weapon/storage/backpack/satchel_vir
	name = "virologist satchel"
	desc = "A sterile satchel with virologist colours."
	icon_state = "satchel-vir"

/obj/item/weapon/storage/backpack/satchel_chem
	name = "chemist satchel"
	desc = "A sterile satchel with chemist colours."
	icon_state = "satchel-chem"

/obj/item/weapon/storage/backpack/satchel_gen
	name = "geneticist satchel"
	desc = "A sterile satchel with geneticist colours."
	icon_state = "satchel-gen"

/obj/item/weapon/storage/backpack/satchel_tox
	name = "scientist satchel"
	desc = "Useful for holding research materials."
	icon_state = "satchel-tox"

/obj/item/weapon/storage/backpack/satchel_sec
	name = "security satchel"
	desc = "A robust satchel for security related needs."
	icon_state = "satchel-sec"
	item_state = "securitypack"

/obj/item/weapon/storage/backpack/satchel_hyd
	name = "hydroponics satchel"
	desc = "A green satchel for plant related work."
	icon_state = "satchel_hyd"

/obj/item/weapon/storage/backpack/satchel_cap
	name = "captain's satchel"
	desc = "An exclusive satchel for Nanotrasen officers."
	icon_state = "satchel-cap"
	item_state = "captainpack"

/obj/item/weapon/storage/backpack/satchel/syndie
	name = "syndicate satchel"
	desc = "A satchel in the new age style of a multi-corperate terrorist organisation."
	icon_state = "satchel-syndie"

/obj/item/weapon/storage/backpack/satchel/wizard
	name = "wizard federation satchel"
	desc = "This stylish satchel will put a spell on anyone with some fashion sense to spare."
	icon_state = "satchel-wizard"

// Duffel Bags

/obj/item/weapon/storage/backpack/duffel
	name = "duffel bag"
	desc = "A spacious duffel bag."
	icon_state = "duffel-norm"
//	item_state = "duffelbag"			// Maybe include a single one size fits all duffel bag icon if we can't sort
										// out the 512 icon limit thing? They're all children, so they'd use it.

/obj/item/weapon/storage/backpack/duffel/cap
	name = "captain's duffel bag"
	desc = "A rare and special duffel bag for only the most air-headed of Nanotrasen personnel."
	icon_state = "duffel-captain"
	item_state = "captainpack"

/obj/item/weapon/storage/backpack/duffel/hyd
	name = "botanist's duffel bag"
	desc = "A specially designed duffel bag for containing plant matter, regardless of how questionable it may be."
	icon_state = "duffel-hydroponics"

/obj/item/weapon/storage/backpack/duffel/vir
	name = "virology duffel bag"
	desc = "A sterilized duffel bag suited to those about to unleash pathogenic havoc upon the world."
	icon_state = "duffel-virology"

/obj/item/weapon/storage/backpack/duffel/med
	name = "medical duffel bag"
	desc = "A sterilized duffel bag for the young, upcoming lesbayan."
	icon_state = "duffel-medical"
	item_state = "medicalpack"

/obj/item/weapon/storage/backpack/duffel/eng
	name = "industrial duffel bag"
	desc = "A rough and tumble duffel bag for the hard working wrench-monkey of tomorrow."
	icon_state = "duffel-engineering"
	item_state = "engiepack"

/obj/item/weapon/storage/backpack/duffel/tox
	name = "scientist's duffel bag"
	desc = "Handy when it comes to storing volatile materials of the anomalous persuasion."
	icon_state = "duffel-toxins"

/obj/item/weapon/storage/backpack/duffel/sec
	name = "security duffel bag"
	desc = "A grey and blue duffel bag for the boys in colour, with room for all the batons and flashbangs you could ever need."
	icon_state = "duffel-security"
	item_state = "securitypack"

/obj/item/weapon/storage/backpack/duffel/gen
	name = "genetics duffel bag"
	desc = "It sure won't hold your genes together, but it'll keep the denim ones safe."
	icon_state = "duffel-genetics"

/obj/item/weapon/storage/backpack/duffel/chem
	name = "chemistry duffel bag"
	desc = "Spice up the love life a little."
	icon_state = "duffel-chemistry"

/obj/item/weapon/storage/backpack/duffel/syndie
	name = "syndicate duffel bag"
	desc = "A snazzy black and red duffel bag, perfect for smuggling C4 and Parapens."
	icon_state = "duffel-syndie"

/obj/item/weapon/storage/backpack/duffel/wizard
	name = "wizardly duffel bag"
	desc = "A fancy blue wizard bag, duffel edition."
	icon_state = "duffel-wizard"


// ERT GEAR BOIZ


/obj/item/weapon/storage/backpack/ert //General use ruck
	name = "combat ruck"
	desc = "A large rucksack with supports and webbing, specifically designed for combat operations and equipment carrying."
	icon_state = "ert_ruck"
	item_state = "ert_ruck"

/obj/item/weapon/storage/backpack/ert/leader
	name = "commander's combat ruck"
	desc = "A large rucksack with supports and webbing, specifically designed for combat operations and equipment carrying. This one has blue highlights, denoting a squad leader."
	icon_state = "ert_commander"
	item_state = "ert_commander"

/obj/item/weapon/storage/backpack/ert/sapper
	name = "engineer's combat ruck"
	desc = "A large rucksack with supports and webbing, specifically designed for combat operations and equipment carrying. This one has bright yellow highlights, denoting a sapper."
	icon_state = "ert_engineering"
	item_state = "ert_engineering"

/obj/item/weapon/storage/backpack/ert/medic
	name = "medic's combat ruck"
	desc = "A large rucksack with supports and webbing, specifically designed for combat operations and equipment carrying. This one has white highlights, denoting a squad medic."
	icon_state = "ert_medical"
	item_state = "ert_medical"

/obj/item/weapon/storage/backpack/ert/security
	name = "combat ruck"
	desc = "A large rucksack with supports and webbing, specifically designed for combat operations and equipment carrying. This one has bright red highlights, denoting a squad combat trooper."
	icon_state = "ert_security"
	item_state = "ert_security"