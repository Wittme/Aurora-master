//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:33

/***************************************************************
**						Design Datums						  **
**	All the data for building stuff and tracking reliability. **
***************************************************************/
/*
For the materials datum, it assumes you need reagents unless specified otherwise. To designate a material that isn't a reagent,
you use one of the material IDs below. These are NOT ids in the usual sense (they aren't defined in the object or part of a datum),
they are simply references used as part of a "has materials?" type proc. They all start with a $ to denote that they aren't reagents.
The currently supporting non-reagent materials:
- $metal (/obj/item/stack/metal). One sheet = 3750 units.
- $glass (/obj/item/stack/glass). One sheet = 3750 units.
- $plasma (/obj/item/stack/plasma). One sheet = 3750 units.
- $silver (/obj/item/stack/silver). One sheet = 3750 units.
- $gold (/obj/item/stack/gold). One sheet = 3750 units.
- $uranium (/obj/item/stack/uranium). One sheet = 3750 units.
- $diamond (/obj/item/stack/diamond). One sheet = 3750 units.
- $clown (/obj/item/stack/clown). One sheet = 3750 units. ("Bananium")
(Insert new ones here)

Don't add new keyword/IDs if they are made from an existing one (such as rods which are made from metal). Only add raw materials.

Design Guidlines
- The reliability formula for all R&D built items is reliability_base (a fixed number) + total tech levels required to make it +
reliability_mod (starts at 0, gets improved through experimentation). Example: PACMAN generator. 79 base reliablity + 6 tech
(3 plasmatech, 3 powerstorage) + 0 (since it's completely new) = 85% reliability. Reliability is the chance it works CORRECTLY.
- When adding new designs, check rdreadme.dm to see what kind of things have already been made and where new stuff is needed.
- A single sheet of anything is 3750 units of material. Materials besides metal/glass require help from other jobs (mining for
other types of metals and chemistry for reagents).
- Add the AUTOLATHE tag to


*/
#define	IMPRINTER	1	//For circuits. Uses glass/chemicals.
#define PROTOLATHE	2	//New stuff. Uses glass/metal/chemicals
#define	AUTOLATHE	4	//Uses glass/metal only.
#define CRAFTLATHE	8	//Uses fuck if I know. For use eventually.
#define MECHFAB		16 //Remember, objects utilising this flag should have construction_time and construction_cost vars.
//Note: More then one of these can be added to a design but imprinter and lathe designs are incompatable.
/var/global/list/protolathe_categories

datum/design						//Datum for object designs, used in construction
	var/name = "Name"					//Name of the created object.
	var/desc = "Desc"					//Description of the created object.
	var/id = "id"						//ID of the created object for easy refernece. Alphanumeric, lower-case, no symbols
	var/list/req_tech = list()			//IDs of that techs the object originated from and the minimum level requirements.
	var/reliability_mod = 0				//Reliability modifier of the device at it's starting point.
	var/reliability_base = 100			//Base reliability of a device before modifiers.
	var/reliability = 100				//Reliability of the device.
	var/build_type = null				//Flag as to what kind machine the design is built in. See defines.
	var/list/materials = list()			//List of materials. Format: "id" = amount.
	var/build_path = ""					//The file path of the object that gets created
	var/locked = 0						//If true it will spawn inside a lockbox with currently sec access
	var/category = "General" 			//Used for sorting designs. Currently by mech fabbers and the protolathe


//A proc to calculate the reliability of a design based on tech levels and innate modifiers.
//Input: A list of /datum/tech; Output: The new reliabilty.
datum/design/proc/CalcReliability(var/list/temp_techs)
	var/new_reliability = reliability_mod + reliability_base
	for(var/datum/tech/T in temp_techs)
		if(T.id in req_tech)
			new_reliability += T.level
	new_reliability = between(reliability_base, new_reliability, 100)
	reliability = new_reliability
	return


///////////////////Computer Boards///////////////////////////////////

datum/design/seccamera
	name = "Circuit Design (Security)"
	desc = "Allows for the construction of circuit boards used to build security camera computers."
	id = "seccamera"
	req_tech = list("programming" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/security"

datum/design/aicore
	name = "Circuit Design (AI Core)"
	desc = "Allows for the construction of circuit boards used to build new AI cores."
	id = "aicore"
	req_tech = list("programming" = 4, "biotech" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/aicore"

datum/design/aiupload
	name = "Circuit Design (AI Upload)"
	desc = "Allows for the construction of circuit boards used to build an AI Upload Console."
	id = "aiupload"
	req_tech = list("programming" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/aiupload"

datum/design/borgupload
	name = "Circuit Design (Cyborg Upload)"
	desc = "Allows for the construction of circuit boards used to build a Cyborg Upload Console."
	id = "borgupload"
	req_tech = list("programming" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/borgupload"

datum/design/med_data
	name = "Circuit Design (Medical Records)"
	desc = "Allows for the construction of circuit boards used to build a medical records console."
	id = "med_data"
	req_tech = list("programming" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/med_data"

datum/design/operating
	name = "Circuit Design (Operating Computer)"
	desc = "Allows for the construction of circuit boards used to build an operating computer console."
	id = "operating"
	req_tech = list("programming" = 2, "biotech" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/operating"

datum/design/pandemic
	name = "Circuit Design (PanD.E.M.I.C. 2200)"
	desc = "Allows for the construction of circuit boards used to build a PanD.E.M.I.C. 2200 console."
	id = "pandemic"
	req_tech = list("programming" = 2, "biotech" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/pandemic"

datum/design/scan_console
	name = "Circuit Design (DNA Machine)"
	desc = "Allows for the construction of circuit boards used to build a new DNA scanning console."
	id = "scan_console"
	req_tech = list("programming" = 2, "biotech" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/scan_consolenew"

datum/design/comconsole
	name = "Circuit Design (Communications)"
	desc = "Allows for the construction of circuit boards used to build a communications console."
	id = "comconsole"
	req_tech = list("programming" = 2, "magnets" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/communications"

datum/design/idcardconsole
	name = "Circuit Design (ID Computer)"
	desc = "Allows for the construction of circuit boards used to build an ID computer."
	id = "idcardconsole"
	req_tech = list("programming" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/card"

datum/design/crewconsole
	name = "Circuit Design (Crew monitoring computer)"
	desc = "Allows for the construction of circuit boards used to build a Crew monitoring computer."
	id = "crewconsole"
	req_tech = list("programming" = 3, "magnets" = 2, "biotech" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/crew"

datum/design/teleconsole
	name = "Circuit Design (Teleporter Console)"
	desc = "Allows for the construction of circuit boards used to build a teleporter control console."
	id = "teleconsole"
	req_tech = list("programming" = 3, "bluespace" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/teleporter"

datum/design/secdata
	name = "Circuit Design (Security Records Console)"
	desc = "Allows for the construction of circuit boards used to build a security records console."
	id = "secdata"
	req_tech = list("programming" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/secure_data"

datum/design/atmosalerts
	name = "Circuit Design (Atmosphere Alert)"
	desc = "Allows for the construction of circuit boards used to build an atmosphere alert console.."
	id = "atmosalerts"
	req_tech = list("programming" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/atmos_alert"

datum/design/air_management
	name = "Circuit Design (Atmospheric Monitor)"
	desc = "Allows for the construction of circuit boards used to build an Atmospheric Monitor."
	id = "air_management"
	req_tech = list("programming" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/air_management"

/* Uncomment if someone makes these buildable
datum/design/general_alert
	name = "Circuit Design (General Alert Console)"
	desc = "Allows for the construction of circuit boards used to build a General Alert console."
	id = "general_alert"
	req_tech = list("programming" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/general_alert"
*/

datum/design/robocontrol
	name = "Circuit Design (Robotics Control Console)"
	desc = "Allows for the construction of circuit boards used to build a Robotics Control console."
	id = "robocontrol"
	req_tech = list("programming" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/robotics"

datum/design/dronecontrol
	name = "Circuit Design (Drone Control Console)"
	desc = "Allows for the construction of circuit boards used to build a Drone Control console."
	id = "dronecontrol"
	req_tech = list("programming" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/drone_control"

datum/design/clonecontrol
	name = "Circuit Design (Cloning Machine Console)"
	desc = "Allows for the construction of circuit boards used to build a new Cloning Machine console."
	id = "clonecontrol"
	req_tech = list("programming" = 3, "biotech" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/cloning"

datum/design/clonepod
	name = "Circuit Design (Clone Pod)"
	desc = "Allows for the construction of circuit boards used to build a Cloning Pod."
	id = "clonepod"
	req_tech = list("programming" = 3, "biotech" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/clonepod"

datum/design/clonescanner
	name = "Circuit Design (Cloning Scanner)"
	desc = "Allows for the construction of circuit boards used to build a Cloning Scanner."
	id = "clonescanner"
	req_tech = list("programming" = 3, "biotech" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/clonescanner"

datum/design/arcademachine
	name = "Circuit Design (Arcade Machine)"
	desc = "Allows for the construction of circuit boards used to build a new arcade machine."
	id = "arcademachine"
	req_tech = list("programming" = 1)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/arcade"

datum/design/powermonitor
	name = "Circuit Design (Power Monitor)"
	desc = "Allows for the construction of circuit boards used to build a new power monitor"
	id = "powermonitor"
	req_tech = list("programming" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/powermonitor"

datum/design/solarcontrol
	name = "Circuit Design (Solar Control)"
	desc = "Allows for the construction of circuit boards used to build a solar control console"
	id = "solarcontrol"
	req_tech = list("programming" = 2, "powerstorage" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/solar_control"

datum/design/prisonmanage
	name = "Circuit Design (Prisoner Management Console)"
	desc = "Allows for the construction of circuit boards used to build a prisoner management console."
	id = "prisonmanage"
	req_tech = list("programming" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/prisoner"

datum/design/mechacontrol
	name = "Circuit Design (Exosuit Control Console)"
	desc = "Allows for the construction of circuit boards used to build an exosuit control console."
	id = "mechacontrol"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha_control"

datum/design/mechapower
	name = "Circuit Design (Mech Bay Power Control Console)"
	desc = "Allows for the construction of circuit boards used to build a mech bay power control console."
	id = "mechapower"
	req_tech = list("programming" = 2, "powerstorage" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mech_bay_power_console"

datum/design/rdconsole
	name = "Circuit Design (R&D Console)"
	desc = "Allows for the construction of circuit boards used to build a new R&D console."
	id = "rdconsole"
	req_tech = list("programming" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/rdconsole"

datum/design/ordercomp
	name = "Circuit Design (Supply ordering console)"
	desc = "Allows for the construction of circuit boards used to build a Supply ordering console."
	id = "ordercomp"
	req_tech = list("programming" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/ordercomp"

datum/design/supplycomp
	name = "Circuit Design (Supply shuttle console)"
	desc = "Allows for the construction of circuit boards used to build a Supply shuttle console."
	id = "supplycomp"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/supplycomp"

datum/design/comm_monitor
	name = "Circuit Design (Telecommunications Monitoring Console)"
	desc = "Allows for the construction of circuit boards used to build a telecommunications monitor."
	id = "comm_monitor"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/comm_monitor"

datum/design/comm_server
	name = "Circuit Design (Telecommunications Server Monitoring Console)"
	desc = "Allows for the construction of circuit boards used to build a telecommunication server browser and monitor."
	id = "comm_server"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/comm_server"

datum/design/message_monitor
	name = "Circuit Design (Messaging Monitor Console)"
	desc = "Allows for the construction of circuit boards used to build a messaging monitor console."
	id = "message_monitor"
	req_tech = list("programming" = 5)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/message_monitor"

datum/design/aifixer
	name = "Circuit Design (AI Integrity Restorer)"
	desc = "Allows for the construction of circuit boards used to build an AI Integrity Restorer."
	id = "aifixer"
	req_tech = list("programming" = 3, "biotech" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/aifixer"

datum/design/comm_traffic
	name = "Circuitboard (Telecommunications Traffic Control)"
	desc = "Allows for the construction of circuit boards used to build a Telecomms Traffic Computer."
	id = "comm_traffic"
	req_tech = list("programming" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/comm_traffic"

///////////////////////////////////
//////////AI Module Disks//////////
///////////////////////////////////
datum/design/safeguard_module
	name = "Module Design (Safeguard)"
	desc = "Allows for the construction of a Safeguard AI Module."
	id = "safeguard_module"
	req_tech = list("programming" = 3, "materials" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20, "$gold" = 100)
	build_path = "/obj/item/weapon/aiModule/safeguard"

datum/design/onehuman_module
	name = "Module Design (OneHuman)"
	desc = "Allows for the construction of a OneHuman AI Module."
	id = "onehuman_module"
	req_tech = list("programming" = 4, "materials" = 6)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20, "$diamond" = 100)
	build_path = "/obj/item/weapon/aiModule/oneHuman"

datum/design/protectstation_module
	name = "Module Design (ProtectStation)"
	desc = "Allows for the construction of a ProtectStation AI Module."
	id = "protectstation_module"
	req_tech = list("programming" = 3, "materials" = 6)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20, "$gold" = 100)
	build_path = "/obj/item/weapon/aiModule/protectStation"

datum/design/notele_module
	name = "Module Design (TeleporterOffline Module)"
	desc = "Allows for the construction of a TeleporterOffline AI Module."
	id = "notele_module"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20, "$gold" = 100)
	build_path = "/obj/item/weapon/aiModule/teleporterOffline"

datum/design/quarantine_module
	name = "Module Design (Quarantine)"
	desc = "Allows for the construction of a Quarantine AI Module."
	id = "quarantine_module"
	req_tech = list("programming" = 3, "biotech" = 2, "materials" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20, "$gold" = 100)
	build_path = "/obj/item/weapon/aiModule/quarantine"

datum/design/oxygen_module
	name = "Module Design (OxygenIsToxicToHumans)"
	desc = "Allows for the construction of a Safeguard AI Module."
	id = "oxygen_module"
	req_tech = list("programming" = 3, "biotech" = 2, "materials" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20, "$gold" = 100)
	build_path = "/obj/item/weapon/aiModule/oxygen"

datum/design/freeform_module
	name = "Module Design (Freeform)"
	desc = "Allows for the construction of a Freeform AI Module."
	id = "freeform_module"
	req_tech = list("programming" = 4, "materials" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20, "$gold" = 100)
	build_path = "/obj/item/weapon/aiModule/freeform"

datum/design/reset_module
	name = "Module Design (Reset)"
	desc = "Allows for the construction of a Reset AI Module."
	id = "reset_module"
	req_tech = list("programming" = 3, "materials" = 6)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20, "$gold" = 100)
	build_path = "/obj/item/weapon/aiModule/reset"

datum/design/purge_module
	name = "Module Design (Purge)"
	desc = "Allows for the construction of a Purge AI Module."
	id = "purge_module"
	req_tech = list("programming" = 4, "materials" = 6)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20, "$diamond" = 100)
	build_path = "/obj/item/weapon/aiModule/purge"

datum/design/freeformcore_module
	name = "Core Module Design (Freeform)"
	desc = "Allows for the construction of a Freeform AI Core Module."
	id = "freeformcore_module"
	req_tech = list("programming" = 4, "materials" = 6)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20, "$diamond" = 100)
	build_path = "/obj/item/weapon/aiModule/freeformcore"

datum/design/asimov
	name = "Core Module Design (Asimov)"
	desc = "Allows for the construction of a Asimov AI Core Module."
	id = "asimov_module"
	req_tech = list("programming" = 3, "materials" = 6)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20, "$diamond" = 100)
	build_path = "/obj/item/weapon/aiModule/asimov"

datum/design/paladin_module
	name = "Core Module Design (P.A.L.A.D.I.N.)"
	desc = "Allows for the construction of a P.A.L.A.D.I.N. AI Core Module."
	id = "paladin_module"
	req_tech = list("programming" = 4, "materials" = 6)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20, "$diamond" = 100)
	build_path = "/obj/item/weapon/aiModule/paladin"

datum/design/tyrant_module
	name = "Core Module Design (T.Y.R.A.N.T.)"
	desc = "Allows for the construction of a T.Y.R.A.N.T. AI Module."
	id = "tyrant_module"
	req_tech = list("programming" = 4, "syndicate" = 2, "materials" = 6)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20, "$diamond" = 100)
	build_path = "/obj/item/weapon/aiModule/tyrant"



///////////////////////////////////
/////Subspace Telecomms////////////
///////////////////////////////////
datum/design/subspace_receiver
	name = "Circuit Design (Subspace Receiver)"
	desc = "Allows for the construction of Subspace Receiver equipment."
	id = "s-receiver"
	req_tech = list("programming" = 4, "engineering" = 3, "bluespace" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/telecomms/receiver"

datum/design/telecomms_bus
	name = "Circuit Design (Bus Mainframe)"
	desc = "Allows for the construction of Telecommunications Bus Mainframes."
	id = "s-bus"
	req_tech = list("programming" = 4, "engineering" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/telecomms/bus"

datum/design/telecomms_hub
	name = "Circuit Design (Hub Mainframe)"
	desc = "Allows for the construction of Telecommunications Hub Mainframes."
	id = "s-hub"
	req_tech = list("programming" = 4, "engineering" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/telecomms/hub"

datum/design/telecomms_relay
	name = "Circuit Design (Relay Mainframe)"
	desc = "Allows for the construction of Telecommunications Relay Mainframes."
	id = "s-relay"
	req_tech = list("programming" = 3, "engineering" = 4, "bluespace" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/telecomms/relay"

datum/design/telecomms_processor
	name = "Circuit Design (Processor Unit)"
	desc = "Allows for the construction of Telecommunications Processor equipment."
	id = "s-processor"
	req_tech = list("programming" = 4, "engineering" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/telecomms/processor"

datum/design/telecomms_server
	name = "Circuit Design (Server Mainframe)"
	desc = "Allows for the construction of Telecommunications Servers."
	id = "s-server"
	req_tech = list("programming" = 4, "engineering" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/telecomms/server"

datum/design/subspace_broadcaster
	name = "Circuit Design (Subspace Broadcaster)"
	desc = "Allows for the construction of Subspace Broadcasting equipment."
	id = "s-broadcaster"
	req_tech = list("programming" = 4, "engineering" = 4, "bluespace" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/telecomms/broadcaster"


///////////////////////////////////
/////Non-Board Computer Stuff//////
///////////////////////////////////

datum/design/intellicard
	name = "Intellicard AI Transportation System"
	desc = "Allows for the construction of an intellicard."
	id = "intellicard"
	req_tech = list("programming" = 4, "materials" = 4)
	build_type = PROTOLATHE
	materials = list("$glass" = 1000, "$gold" = 200)
	build_path = "/obj/item/device/aicard"
	category = "Information Technology"

datum/design/paicard
	name = "Personal Artificial Intelligence Card"
	desc = "Allows for the construction of a pAI Card"
	id = "paicard"
	req_tech = list("programming" = 2)
	build_type = PROTOLATHE
	materials = list("$glass" = 500, "$metal" = 500)
	build_path = "/obj/item/device/paicard"
	category = "Information Technology"

datum/design/posibrain
	name = "Positronic Brain"
	desc = "Allows for the construction of a positronic brain"
	id = "posibrain"
	req_tech = list("engineering" = 4, "materials" = 6, "bluespace" = 2, "programming" = 4)

	build_type = PROTOLATHE
	materials = list("$metal" = 2000, "$glass" = 1000, "$silver" = 1000, "$gold" = 500, "$plasma" = 500, "$diamond" = 100)
	build_path = "/obj/item/device/mmi/posibrain"
	category = "Information Technology"

///////////////////////////////////
//////////Mecha Module Disks///////
///////////////////////////////////

datum/design/ripley_main
	name = "Circuit Design (APLU \"Ripley\" Central Control module)"
	desc = "Allows for the construction of a \"Ripley\" Central Control module."
	id = "ripley_main"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/ripley/main"

datum/design/ripley_peri
	name = "Circuit Design (APLU \"Ripley\" Peripherals Control module)"
	desc = "Allows for the construction of a  \"Ripley\" Peripheral Control module."
	id = "ripley_peri"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/ripley/peripherals"

datum/design/odysseus_main
	name = "Circuit Design (\"Odysseus\" Central Control module)"
	desc = "Allows for the construction of a \"Odysseus\" Central Control module."
	id = "odysseus_main"
	req_tech = list("programming" = 3,"biotech" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/odysseus/main"

datum/design/odysseus_peri
	name = "Circuit Design (\"Odysseus\" Peripherals Control module)"
	desc = "Allows for the construction of a \"Odysseus\" Peripheral Control module."
	id = "odysseus_peri"
	req_tech = list("programming" = 3,"biotech" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/odysseus/peripherals"

datum/design/gygax_main
	name = "Circuit Design (\"Gygax\" Central Control module)"
	desc = "Allows for the construction of a \"Gygax\" Central Control module."
	id = "gygax_main"
	req_tech = list("programming" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/gygax/main"

datum/design/gygax_peri
	name = "Circuit Design (\"Gygax\" Peripherals Control module)"
	desc = "Allows for the construction of a \"Gygax\" Peripheral Control module."
	id = "gygax_peri"
	req_tech = list("programming" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/gygax/peripherals"

datum/design/gygax_targ
	name = "Circuit Design (\"Gygax\" Weapons & Targeting Control module)"
	desc = "Allows for the construction of a \"Gygax\" Weapons & Targeting Control module."
	id = "gygax_targ"
	req_tech = list("programming" = 4, "combat" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/gygax/targeting"

datum/design/durand_main
	name = "Circuit Design (\"Durand\" Central Control module)"
	desc = "Allows for the construction of a \"Durand\" Central Control module."
	id = "durand_main"
	req_tech = list("programming" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/durand/main"

datum/design/durand_peri
	name = "Circuit Design (\"Durand\" Peripherals Control module)"
	desc = "Allows for the construction of a \"Durand\" Peripheral Control module."
	id = "durand_peri"
	req_tech = list("programming" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/durand/peripherals"

datum/design/durand_targ
	name = "Circuit Design (\"Durand\" Weapons & Targeting Control module)"
	desc = "Allows for the construction of a \"Durand\" Weapons & Targeting Control module."
	id = "durand_targ"
	req_tech = list("programming" = 4, "combat" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/durand/targeting"

datum/design/honker_main
	name = "Circuit Design (\"H.O.N.K\" Central Control module)"
	desc = "Allows for the construction of a \"H.O.N.K\" Central Control module."
	id = "honker_main"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/honker/main"

datum/design/honker_peri
	name = "Circuit Design (\"H.O.N.K\" Peripherals Control module)"
	desc = "Allows for the construction of a \"H.O.N.K\" Peripheral Control module."
	id = "honker_peri"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/honker/peripherals"

datum/design/honker_targ
	name = "Circuit Design (\"H.O.N.K\" Weapons & Targeting Control module)"
	desc = "Allows for the construction of a \"H.O.N.K\" Weapons & Targeting Control module."
	id = "honker_targ"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/honker/targeting"
/*
datum/design/exoskeleton
	name = "Circuit Design (\"Exoskeleton\" Control Module)"
	desc = "Allows for the construction of a \"Exoskeleton\" Control Module."
	id = "exoskeleton"
	req_tech = list("programming" = 4, "combat" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mecha/exoskeleton/main"
*/
////////////////////////////////////////
/////////// Mecha Equpment /////////////
////////////////////////////////////////

datum/design/mech_scattershot
	name = "Exosuit Weapon Design (LBX AC 10 \"Scattershot\")"
	desc = "Allows for the construction of LBX AC 10."
	id = "mech_scattershot"
	build_type = MECHFAB
	req_tech = list("combat" = 4)
	build_path = "/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot"
	category = "Exosuit Equipment"

datum/design/mech_laser
	name = "Exosuit Weapon Design (CH-PS \"Immolator\" Laser)"
	desc = "Allows for the construction of CH-PS Laser."
	id = "mech_laser"
	build_type = MECHFAB
	req_tech = list("combat" = 3, "magnets" = 3)
	build_path = "/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser"
	category = "Exosuit Equipment"

datum/design/mech_laser_heavy
	name = "Exosuit Weapon Design (CH-LC \"Solaris\" Laser Cannon)"
	desc = "Allows for the construction of CH-LC Laser Cannon."
	id = "mech_laser_heavy"
	build_type = MECHFAB
	req_tech = list("combat" = 4, "magnets" = 4)
	build_path = "/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy"
	category = "Exosuit Equipment"

datum/design/mech_grenade_launcher
	name = "Exosuit Weapon Design (SGL-6 Grenade Launcher)"
	desc = "Allows for the construction of SGL-6 Grenade Launcher."
	id = "mech_grenade_launcher"
	build_type = MECHFAB
	req_tech = list("combat" = 3)
	build_path = "/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/flashbang"
	category = "Exosuit Equipment"

datum/design/clusterbang_launcher
	name = "Exosuit Module Design (SOP-6 Clusterbang Launcher)"
	desc = "A weapon that violates the Geneva Convention at 6 rounds per minute"
	id = "clusterbang_launcher"
	build_type = MECHFAB
	req_tech = list("combat"= 5, "materials" = 5, "syndicate" = 3)
	build_path = "/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/flashbang/clusterbang/limited"
	category = "Exosuit Equipment"

datum/design/mech_wormhole_gen
	name = "Exosuit Module Design (Localized Wormhole Generator)"
	desc = "An exosuit module that allows generating of small quasi-stable wormholes."
	id = "mech_wormhole_gen"
	build_type = MECHFAB
	req_tech = list("bluespace" = 3, "magnets" = 2)
	build_path = "/obj/item/mecha_parts/mecha_equipment/wormhole_generator"
	category = "Exosuit Equipment"

datum/design/mech_teleporter
	name = "Exosuit Module Design (Teleporter Module)"
	desc = "An exosuit module that allows exosuits to teleport to any position in view."
	id = "mech_teleporter"
	build_type = MECHFAB
	req_tech = list("bluespace" = 5, "magnets" = 5)
	build_path = "/obj/item/mecha_parts/mecha_equipment/teleporter"
	category = "Exosuit Equipment"

datum/design/mech_rcd
	name = "Exosuit Module Design (RCD Module)"
	desc = "An exosuit-mounted Rapid Construction Device."
	id = "mech_rcd"
	build_type = MECHFAB
	req_tech = list("materials" = 4, "bluespace" = 3, "magnets" = 4, "powerstorage"=4, "engineering" = 4)
	build_path = "/obj/item/mecha_parts/mecha_equipment/tool/rcd"
	category = "Exosuit Equipment"

datum/design/mech_gravcatapult
	name = "Exosuit Module Design (Gravitational Catapult Module)"
	desc = "An exosuit mounted Gravitational Catapult."
	id = "mech_gravcatapult"
	build_type = MECHFAB
	req_tech = list("bluespace" = 2, "magnets" = 3, "engineering" = 3)
	build_path = "/obj/item/mecha_parts/mecha_equipment/gravcatapult"
	category = "Exosuit Equipment"

datum/design/mech_repair_droid
	name = "Exosuit Module Design (Repair Droid Module)"
	desc = "Automated Repair Droid. BEEP BOOP"
	id = "mech_repair_droid"
	build_type = MECHFAB
	req_tech = list("magnets" = 3, "programming" = 3, "engineering" = 3)
	build_path = "/obj/item/mecha_parts/mecha_equipment/repair_droid"
	category = "Exosuit Equipment"

datum/design/mech_plasma_generator
	name = "Exosuit Module Design (Plasma Converter Module)"
	desc = "Exosuit-mounted plasma converter."
	id = "mech_plasma_generator"
	build_type = MECHFAB
	req_tech = list("plasmatech" = 2, "powerstorage"= 2, "engineering" = 2)
	build_path = "/obj/item/mecha_parts/mecha_equipment/plasma_generator"
	category = "Exosuit Equipment"

datum/design/mech_energy_relay
	name = "Exosuit Module Design (Tesla Energy Relay)"
	desc = "Tesla Energy Relay"
	id = "mech_energy_relay"
	build_type = MECHFAB
	req_tech = list("magnets" = 4, "powerstorage" = 3)
	build_path = "/obj/item/mecha_parts/mecha_equipment/tesla_energy_relay"
	category = "Exosuit Equipment"

datum/design/mech_ccw_armor
	name = "Exosuit Module Design(Reactive Armor Booster Module)"
	desc = "Exosuit-mounted armor booster."
	id = "mech_ccw_armor"
	build_type = MECHFAB
	req_tech = list("materials" = 5, "combat" = 4)
	build_path = "/obj/item/mecha_parts/mecha_equipment/anticcw_armor_booster"
	category = "Exosuit Equipment"

datum/design/mech_proj_armor
	name = "Exosuit Module Design(Reflective Armor Booster Module)"
	desc = "Exosuit-mounted armor booster."
	id = "mech_proj_armor"
	build_type = MECHFAB
	req_tech = list("materials" = 5, "combat" = 5, "engineering"=3)
	build_path = "/obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster"
	category = "Exosuit Equipment"

datum/design/mech_syringe_gun
	name = "Exosuit Module Design(Syringe Gun)"
	desc = "Exosuit-mounted syringe gun and chemical synthesizer."
	id = "mech_syringe_gun"
	build_type = MECHFAB
	req_tech = list("materials" = 3, "biotech"=4, "magnets"=4, "programming"=3)
	build_path = "/obj/item/mecha_parts/mecha_equipment/tool/syringe_gun"
	category = "Exosuit Equipment"

datum/design/mech_diamond_drill
	name = "Exosuit Module Design (Diamond Mining Drill)"
	desc = "An upgraded version of the standard drill"
	id = "mech_diamond_drill"
	build_type = MECHFAB
	req_tech = list("materials" = 4, "engineering" = 3)
	build_path = "/obj/item/mecha_parts/mecha_equipment/tool/drill/diamonddrill"
	category = "Exosuit Equipment"

datum/design/mech_generator_nuclear
	name = "Exosuit Module Design (ExoNuclear Reactor)"
	desc = "Compact nuclear reactor module"
	id = "mech_generator_nuclear"
	build_type = MECHFAB
	req_tech = list("powerstorage"= 3, "engineering" = 3, "materials" = 3)
	build_path = "/obj/item/mecha_parts/mecha_equipment/generator/nuclear"
	category = "Exosuit Equipment"


////////////////////////////////////////
//////////Disk Construction Disks///////
////////////////////////////////////////
datum/design/design_disk
	name = "Design Storage Disk"
	desc = "Produce additional disks for storing device designs."
	id = "design_disk"
	req_tech = list("programming" = 1)
	build_type = PROTOLATHE | AUTOLATHE
	materials = list("$metal" = 30, "$glass" = 10)
	build_path = "/obj/item/weapon/disk/design_disk"
	category = "Information Technology"

datum/design/tech_disk
	name = "Technology Data Storage Disk"
	desc = "Produce additional disks for storing technology data."
	id = "tech_disk"
	req_tech = list("programming" = 1)
	build_type = PROTOLATHE | AUTOLATHE
	materials = list("$metal" = 30, "$glass" = 10)
	build_path = "/obj/item/weapon/disk/tech_disk"
	category = "Information Technology"
datum/design/clone_disk
	name = "Cloning Data Storage Disk"
	desc = "Produce additional disks for storing genetic data."
	id = "clone_disk"
	req_tech = list("programming" = 1)
	build_type = PROTOLATHE | AUTOLATHE
	materials = list("$metal" = 30, "$glass" = 10)
	build_path = "/obj/item/weapon/disk/data"
	category = "Information Technology"

////////////////////////////////////////
/////////////Stock Parts////////////////
////////////////////////////////////////

datum/design/basic_capacitor
	name = "Basic Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "basic_capacitor"
	req_tech = list("powerstorage" = 1)
	build_type = PROTOLATHE | AUTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/stock_parts/capacitor"
	category = "Components"

datum/design/basic_sensor
	name = "Basic Sensor Module"
	desc = "A stock part used in the construction of various devices."
	id = "basic_sensor"
	req_tech = list("magnets" = 1)
	build_type = PROTOLATHE | AUTOLATHE
	materials = list("$metal" = 50, "$glass" = 20)
	build_path = "/obj/item/weapon/stock_parts/scanning_module"
	category = "Components"

datum/design/micro_mani
	name = "Micro Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "micro_mani"
	req_tech = list("materials" = 1, "programming" = 1)
	build_type = PROTOLATHE | AUTOLATHE
	materials = list("$metal" = 30)
	build_path = "/obj/item/weapon/stock_parts/manipulator"
	category = "Components"

datum/design/basic_micro_laser
	name = "Basic Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "basic_micro_laser"
	req_tech = list("magnets" = 1)
	build_type = PROTOLATHE | AUTOLATHE
	materials = list("$metal" = 10, "$glass" = 20)
	build_path = "/obj/item/weapon/stock_parts/micro_laser"
	category = "Components"

datum/design/basic_matter_bin
	name = "Basic Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "basic_matter_bin"
	req_tech = list("materials" = 1)
	build_type = PROTOLATHE | AUTOLATHE
	materials = list("$metal" = 80)
	build_path = "/obj/item/weapon/stock_parts/matter_bin"
	category = "Components"

datum/design/adv_capacitor
	name = "Advanced Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "adv_capacitor"
	req_tech = list("powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/stock_parts/capacitor/adv"
	category = "Components"

datum/design/adv_sensor
	name = "Advanced Sensor Module"
	desc = "A stock part used in the construction of various devices."
	id = "adv_sensor"
	req_tech = list("magnets" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 20)
	build_path = "/obj/item/weapon/stock_parts/scanning_module/adv"
	category = "Components"

datum/design/nano_mani
	name = "Nano Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "nano_mani"
	req_tech = list("materials" = 3, "programming" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 30)
	build_path = "/obj/item/weapon/stock_parts/manipulator/nano"
	category = "Components"

datum/design/high_micro_laser
	name = "High-Power Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "high_micro_laser"
	req_tech = list("magnets" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 10, "$glass" = 20)
	build_path = "/obj/item/weapon/stock_parts/micro_laser/high"
	category = "Components"

datum/design/adv_matter_bin
	name = "Advanced Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "adv_matter_bin"
	req_tech = list("materials" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 80)
	build_path = "/obj/item/weapon/stock_parts/matter_bin/adv"
	category = "Components"

datum/design/super_capacitor
	name = "Super Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "super_capacitor"
	req_tech = list("powerstorage" = 5, "materials" = 4)
	build_type = PROTOLATHE
	reliability_base = 71
	materials = list("$metal" = 50, "$glass" = 50, "$gold" = 20)
	build_path = "/obj/item/weapon/stock_parts/capacitor/super"
	category = "Components"

datum/design/phasic_sensor
	name = "Phasic Sensor Module"
	desc = "A stock part used in the construction of various devices."
	id = "phasic_sensor"
	req_tech = list("magnets" = 5, "materials" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 20, "$silver" = 10)
	reliability_base = 72
	build_path = "/obj/item/weapon/stock_parts/scanning_module/phasic"
	category = "Components"

datum/design/pico_mani
	name = "Pico Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "pico_mani"
	req_tech = list("materials" = 5, "programming" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 30)
	reliability_base = 73
	build_path = "/obj/item/weapon/stock_parts/manipulator/pico"
	category = "Components"

datum/design/ultra_micro_laser
	name = "Ultra-High-Power Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "ultra_micro_laser"
	req_tech = list("magnets" = 5, "materials" = 5)
	build_type = PROTOLATHE
	materials = list("$metal" = 10, "$glass" = 20, "$uranium" = 10)
	reliability_base = 70
	build_path = "/obj/item/weapon/stock_parts/micro_laser/ultra"
	category = "Components"

datum/design/super_matter_bin
	name = "Super Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "super_matter_bin"
	req_tech = list("materials" = 5)
	build_type = PROTOLATHE
	materials = list("$metal" = 80)
	reliability_base = 75
	build_path = "/obj/item/weapon/stock_parts/matter_bin/super"
	category = "Components"



datum/design/subspace_ansible
	name = "Subspace Ansible"
	desc = "A compact module capable of sensing extradimensional activity."
	id = "s-ansible"
	req_tech = list("programming" = 3, "magnets" = 4, "materials" = 4, "bluespace" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 80, "$silver" = 20)
	build_path = "/obj/item/weapon/stock_parts/subspace/ansible"
	category = "Bluespace Technology"

datum/design/hyperwave_filter
	name = "Hyperwave Filter"
	desc = "A tiny device capable of filtering and converting super-intense radiowaves."
	id = "s-filter"
	req_tech = list("programming" = 3, "magnets" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 40, "$silver" = 10)
	build_path = "/obj/item/weapon/stock_parts/subspace/filter"
	category = "Bluespace Technology"

datum/design/subspace_amplifier
	name = "Subspace Amplifier"
	desc = "A compact micro-machine capable of amplifying weak subspace transmissions."
	id = "s-amplifier"
	req_tech = list("programming" = 3, "magnets" = 4, "materials" = 4, "bluespace" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 10, "$gold" = 30, "$uranium" = 15)
	build_path = "/obj/item/weapon/stock_parts/subspace/amplifier"
	category = "Bluespace Technology"

datum/design/subspace_treatment
	name = "Subspace Treatment Disk"
	desc = "A compact micro-machine capable of stretching out hyper-compressed radio waves."
	id = "s-treatment"
	req_tech = list("programming" = 3, "magnets" = 2, "materials" = 4, "bluespace" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 10, "$silver" = 20)
	build_path = "/obj/item/weapon/stock_parts/subspace/treatment"
	category = "Bluespace Technology"

datum/design/subspace_analyzer
	name = "Subspace Analyzer"
	desc = "A sophisticated analyzer capable of analyzing cryptic subspace wavelengths."
	id = "s-analyzer"
	req_tech = list("programming" = 3, "magnets" = 4, "materials" = 4, "bluespace" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 10, "$gold" = 15)
	build_path = "/obj/item/weapon/stock_parts/subspace/analyzer"
	category = "Bluespace Technology"

datum/design/subspace_crystal
	name = "Ansible Crystal"
	desc = "A sophisticated analyzer capable of analyzing cryptic subspace wavelengths."
	id = "s-crystal"
	req_tech = list("magnets" = 4, "materials" = 4, "bluespace" = 2)
	build_type = PROTOLATHE
	materials = list("$glass" = 1000, "$silver" = 20, "$gold" = 20)
	build_path = "/obj/item/weapon/stock_parts/subspace/crystal"
	category = "Bluespace Technology"

datum/design/subspace_transmitter
	name = "Subspace Transmitter"
	desc = "A large piece of equipment used to open a window into the subspace dimension."
	id = "s-transmitter"
	req_tech = list("magnets" = 5, "materials" = 5, "bluespace" = 3)
	build_type = PROTOLATHE
	materials = list("$glass" = 100, "$silver" = 10, "$uranium" = 15)
	build_path = "/obj/item/weapon/stock_parts/subspace/transmitter"
	category = "Bluespace Technology"

////////////////////////////////////////
//////////////////Power/////////////////
////////////////////////////////////////

datum/design/basic_cell
	name = "Basic Power Cell"
	desc = "A basic power cell that holds 1000 units of energy"
	id = "basic_cell"
	req_tech = list("powerstorage" = 1)
	build_type = PROTOLATHE | AUTOLATHE |MECHFAB
	materials = list("$metal" = 700, "$glass" = 50)
	build_path = "/obj/item/weapon/cell"
	category = "Engineering Equipment"

datum/design/high_cell
	name = "High-Capacity Power Cell"
	desc = "A power cell that holds 10000 units of energy"
	id = "high_cell"
	req_tech = list("powerstorage" = 2)
	build_type = PROTOLATHE | AUTOLATHE | MECHFAB
	materials = list("$metal" = 700, "$glass" = 60)
	build_path = "/obj/item/weapon/cell/high"
	category = "Engineering Equipment"

datum/design/super_cell
	name = "Super-Capacity Power Cell"
	desc = "A power cell that holds 20000 units of energy"
	id = "super_cell"
	req_tech = list("powerstorage" = 3, "materials" = 2)
	reliability_base = 75
	build_type = PROTOLATHE | MECHFAB
	materials = list("$metal" = 700, "$glass" = 70)
	build_path = "/obj/item/weapon/cell/super"
	category = "Engineering Equipment"

datum/design/hyper_cell
	name = "Hyper-Capacity Power Cell"
	desc = "A power cell that holds 30000 units of energy"
	id = "hyper_cell"
	req_tech = list("powerstorage" = 5, "materials" = 4)
	reliability_base = 70
	build_type = PROTOLATHE | MECHFAB
	materials = list("$metal" = 400, "$gold" = 150, "$silver" = 150, "$glass" = 70)
	build_path = "/obj/item/weapon/cell/hyper"
	category = "Engineering Equipment"

datum/design/light_replacer
	name = "Light Replacer"
	desc = "A device to automatically replace lights. Refill with working lightbulbs."
	id = "light_replacer"
	req_tech = list("magnets" = 3, "materials" = 4)
	build_type = PROTOLATHE
	materials = list("$metal" = 1500, "$silver" = 150, "$glass" = 3000)
	build_path = "/obj/item/device/lightreplacer"
	category = "Engineering Equipment"


datum/design/heavy_flashlight
	name = "heavy duty flashlight"
	desc = "A high-luminosity flashlight for specialist duties."
	id = "heavy_flashlight"
	req_tech = list("powerstorage" = 4, "materials" = 3, "engineering" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 2000, "$glass" = 4000)
	build_path = "/obj/item/device/flashlight/heavy"
	category = "Engineering Equipment"

////////////////////////////////////////
//////////////MISC Boards///////////////
////////////////////////////////////////

datum/design/destructive_analyzer
	name = "Destructive Analyzer Board"
	desc = "The circuit board for a destructive analyzer."
	id = "destructive_analyzer"
	req_tech = list("programming" = 2, "magnets" = 2, "engineering" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/destructive_analyzer"

datum/design/protolathe
	name = "Protolathe Board"
	desc = "The circuit board for a protolathe."
	id = "protolathe"
	req_tech = list("programming" = 2, "engineering" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/protolathe"

datum/design/circuit_imprinter
	name = "Circuit Imprinter Board"
	desc = "The circuit board for a circuit imprinter."
	id = "circuit_imprinter"
	req_tech = list("programming" = 2, "engineering" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/circuit_imprinter"

datum/design/autolathe
	name = "Autolathe Board"
	desc = "The circuit board for a autolathe."
	id = "autolathe"
	req_tech = list("programming" = 2, "engineering" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/autolathe"

datum/design/rdservercontrol
	name = "R&D Server Control Console Board"
	desc = "The circuit board for a R&D Server Control Console"
	id = "rdservercontrol"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/rdservercontrol"

datum/design/rdserver
	name = "R&D Server Board"
	desc = "The circuit board for an R&D Server"
	id = "rdserver"
	req_tech = list("programming" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/rdserver"

datum/design/mechfab
	name = "Exosuit Fabricator Board"
	desc = "The circuit board for an Exosuit Fabricator"
	id = "mechfab"
	req_tech = list("programming" = 3, "engineering" = 3)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/mechfab"

datum/design/optable
	name = "Operating Table"
	desc = "The circuit board for an Operating Table"
	id = "optable"
	req_tech = list("programming" = 1, "biotech" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/optable"

datum/design/optable_lifesupport
	name = "Life Support Enabled Operating Table"
	desc = "The circuit board for an advanced Operating Table"
	id = "adv_optable"
	req_tech = list("programming" = 3, "biotech" = 4)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/optable_lifesupport"

/////////////////////////////////////////
////////////Power Stuff//////////////////
/////////////////////////////////////////

datum/design/pacman
	name = "PACMAN-type Generator Board"
	desc = "The circuit board that for a PACMAN-type portable generator."
	id = "pacman"
	req_tech = list("programming" = 3, "plasmatech" = 3, "powerstorage" = 3, "engineering" = 3)
	build_type = IMPRINTER
	reliability_base = 79
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/pacman"

datum/design/superpacman
	name = "SUPERPACMAN-type Generator Board"
	desc = "The circuit board that for a SUPERPACMAN-type portable generator."
	id = "superpacman"
	req_tech = list("programming" = 3, "powerstorage" = 4, "engineering" = 4)
	build_type = IMPRINTER
	reliability_base = 76
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/pacman/super"

datum/design/mrspacman
	name = "MRSPACMAN-type Generator Board"
	desc = "The circuit board that for a MRSPACMAN-type portable generator."
	id = "mrspacman"
	req_tech = list("programming" = 3, "powerstorage" = 5, "engineering" = 5)
	build_type = IMPRINTER
	reliability_base = 74
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/pacman/mrs"

datum/design/batteryrack
	name = "Cell rack PSU Board"
	desc = "The circuit board for a power cell rack PSU."
	id = "batteryrack"
	req_tech = list("powerstorage" = 3, "engineering" = 2)
	build_type = IMPRINTER
	materials = list("$glass" = 2000, "sacid" = 20)
	build_path = "/obj/item/weapon/circuitboard/batteryrack"


/////////////////////////////////////////
////////////Medical Tools////////////////
/////////////////////////////////////////

datum/design/mass_spectrometer
	name = "Mass-Spectrometer"
	desc = "A device for analyzing chemicals in the blood."
	id = "mass_spectrometer"
	req_tech = list("biotech" = 2, "magnets" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 30, "$glass" = 20)
	reliability_base = 76
	build_path = "/obj/item/device/mass_spectrometer"
	category = "Medical Equipment"

datum/design/adv_mass_spectrometer
	name = "Advanced Mass-Spectrometer"
	desc = "A device for analyzing chemicals in the blood and their quantities."
	id = "adv_mass_spectrometer"
	req_tech = list("biotech" = 2, "magnets" = 4)
	build_type = PROTOLATHE
	materials = list("$metal" = 30, "$glass" = 20)
	reliability_base = 74
	build_path = "/obj/item/device/mass_spectrometer/adv"
	category = "Medical Equipment"

datum/design/reagent_scanner
	name = "Reagent Scanner"
	desc = "A device for identifying chemicals."
	id = "reagent_scanner"
	req_tech = list("biotech" = 2, "magnets" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 30, "$glass" = 20)
	reliability_base = 76
	build_path = "/obj/item/device/reagent_scanner"
	category = "Medical Equipment"

datum/design/adv_reagent_scanner
	name = "Advanced Reagent Scanner"
	desc = "A device for identifying chemicals and their proportions."
	id = "adv_reagent_scanner"
	req_tech = list("biotech" = 2, "magnets" = 4)
	build_type = PROTOLATHE
	materials = list("$metal" = 30, "$glass" = 20)
	reliability_base = 74
	build_path = "/obj/item/device/reagent_scanner/adv"
	category = "Medical Equipment"

datum/design/mmi
	name = "Man-Machine Interface"
	desc = "The Warrior's bland acronym, MMI, obscures the true horror of this monstrosity."
	id = "mmi"
	req_tech = list("programming" = 2, "biotech" = 3)
	build_type = PROTOLATHE | MECHFAB
	materials = list("$metal" = 1000, "$glass" = 500)
	reliability_base = 76
	build_path = "/obj/item/device/mmi"
	category = "Engineering Equipment"

datum/design/mmi_radio
	name = "Radio-enabled Man-Machine Interface"
	desc = "The Warrior's bland acronym, MMI, obscures the true horror of this monstrosity. This one comes with a built-in radio."
	id = "mmi_radio"
	req_tech = list("programming" = 2, "biotech" = 4)
	build_type = PROTOLATHE | MECHFAB
	materials = list("$metal" = 1200, "$glass" = 500)
	reliability_base = 74
	build_path = "/obj/item/device/mmi/radio_enabled"
	category = "Engineering Equipment"

datum/design/synthetic_flash
	name = "Synthetic Flash"
	desc = "When a problem arises, SCIENCE is the solution."
	id = "sflash"
	req_tech = list("magnets" = 3, "combat" = 2)
	build_type = MECHFAB
	materials = list("$metal" = 750, "$glass" = 750)
	reliability_base = 76
	build_path = "/obj/item/device/flash/synthetic"
	category = "Engineering Equipment"

datum/design/nanopaste
	name = "nanopaste"
	desc = "A tube of paste containing swarms of repair nanites. Very effective in repairing robotic machinery."
	id = "nanopaste"
	req_tech = list("materials" = 4, "engineering" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 7000, "$glass" = 7000)
	build_path = "/obj/item/stack/nanopaste"
	category = "Medical Equipment"

datum/design/laserpointer
	name = "laser pointer"
	desc = "Don't shine it in your eyes!"
	id = "laser_pointer"
	req_tech = list("magnets" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 100, "$glass" = 50)
	build_path = "/obj/item/device/laser_pointer"
	category = "General"

datum/design/implant_loyal
	name = "loyalty implant"
	desc = "Makes you loyal or such."
	id = "implant_loyal"
	req_tech = list("materials" = 2, "biotech" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 7000, "$glass" = 7000)
	build_path = "/obj/item/weapon/implantcase/loyalty"
	category = "Medical Equipment"

datum/design/implant_chem
	name = "chemical implant"
	desc = "Injects things."
	id = "implant_chem"
	req_tech = list("materials" = 2, "biotech" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/implantcase/chem"
	category = "Medical Equipment"

datum/design/implant_free
	name = "freedom implant"
	desc = "Use this to escape from those evil Red Shirts."
	id = "implant_free"
	req_tech = list("syndicate" = 2, "biotech" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/implantcase/freedom"
	category = "High-Risk Items"

datum/design/energy_shield
	name = "energy shield"
	desc = "An energy shield."
	id = "energy_shield"
	req_tech = list("syndicate" = 4, "materials" = 4, "magnets" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 1000, "$glass" = 3000, "$plasma" = 1000)
	build_path = "/obj/item/weapon/shield/energy"
	category = "Weapons"

datum/design/implant_death_alarm
	name = "death alarm implant"
	desc = "Alerts others to your death."
	id = "implant_death_alarm"
	req_tech = list("materials" = 2, "biotech" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/implantcase/death_alarm"
	category = "Medical Equipment"

datum/design/chameleon
	name = "Chameleon Jumpsuit"
	desc = "It's a plain jumpsuit. It seems to have a small dial on the wrist."
	id = "chameleon"
	req_tech = list("syndicate" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 500)
	build_path = "/obj/item/clothing/under/chameleon"
	category = "High-Risk Items"

datum/design/bluespacebeaker
	name = "bluespace beaker"
	desc = "A bluespace beaker, powered by experimental bluespace technology and Element Cuban combined with the Compound Pete. Can hold up to 300 units."
	id = "bluespacebeaker"
	req_tech = list("bluespace" = 2, "materials" = 6)
	build_type = PROTOLATHE
	materials = list("$metal" = 3000, "$plasma" = 3000, "$diamond" = 500)
	reliability_base = 76
	build_path = "/obj/item/weapon/reagent_containers/glass/beaker/bluespace"
	category = "Medical Equipment"

datum/design/noreactbeaker
	name = "cryostasis beaker"
	desc = "A cryostasis beaker that allows for chemical storage without reactions. Can hold up to 60 units."
	id = "splitbeaker"
	req_tech = list("materials" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 3000)
	reliability_base = 76
	build_path = "/obj/item/weapon/reagent_containers/glass/beaker/noreact"
	category = "Medical Equipment"

datum/design/scalpel_laser1
	name = "Basic Laser Scalpel"
	desc = "A scalpel augmented with a directed laser, for more precise cutting without blood entering the field.  This one looks basic and could be improved."
	id = "scalpel_laser1"
	req_tech = list("biotech" = 2, "materials" = 2, "magnets" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 12500, "$glass" = 7500)
	build_path = "/obj/item/weapon/scalpel/laser1"
	category = "Medical Equipment"

datum/design/scalpel_laser2
	name = "Improved Laser Scalpel"
	desc = "A scalpel augmented with a directed laser, for more precise cutting without blood entering the field.  This one looks somewhat advanced."
	id = "scalpel_laser2"
	req_tech = list("biotech" = 3, "materials" = 4, "magnets" = 4)
	build_type = PROTOLATHE
	materials = list("$metal" = 12500, "$glass" = 7500, "$silver" = 2500)
	build_path = "/obj/item/weapon/scalpel/laser2"
	category = "Medical Equipment"

datum/design/scalpel_laser3
	name = "Advanced Laser Scalpel"
	desc = "A scalpel augmented with a directed laser, for more precise cutting without blood entering the field.  This one looks to be the pinnacle of precision energy cutlery!"
	id = "scalpel_laser3"
	req_tech = list("biotech" = 4, "materials" = 6, "magnets" = 5)
	build_type = PROTOLATHE
	materials = list("$metal" = 12500, "$glass" = 7500, "$silver" = 2000, "$gold" = 1500)
	build_path = "/obj/item/weapon/scalpel/laser3"
	category = "Medical Equipment"

datum/design/scalpel_manager
	name = "Incision Management System"
	desc = "A true extension of the surgeon's body, this marvel instantly and completely prepares an incision allowing for the immediate commencement of therapeutic steps."
	id = "scalpel_manager"
	req_tech = list("biotech" = 4, "materials" = 7, "magnets" = 5, "programming" = 4)
	build_type = PROTOLATHE
	materials = list ("$metal" = 12500, "$glass" = 7500, "$silver" = 1500, "$gold" = 1500, "$diamond" = 750)
	build_path = "/obj/item/weapon/scalpel/manager"
	category = "Medical Equipment"

/////////////////////////////////////////
/////////////////Weapons/////////////////
/////////////////////////////////////////

datum/design/nuclear_gun
	name = "Advanced Energy Gun"
	desc = "An energy gun with an experimental miniaturized reactor."
	id = "nuclear_gun"
	req_tech = list("combat" = 3, "materials" = 5, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 5000, "$glass" = 1000, "$uranium" = 500)
	reliability_base = 76
	build_path = "/obj/item/weapon/gun/energy/rifle/gun/nuclear"
	locked = 1
	category = "Weapons"

datum/design/stunrevolver
	name = "Stun Revolver"
	desc = "Occasionally prize of the Head of Security, but usually of asshole scientists."
	id = "stunrevolver"
	req_tech = list("combat" = 3, "materials" = 3, "powerstorage" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 4000)
	build_path = "/obj/item/weapon/gun/energy/stunrevolver"
	locked = 1
	category = "Weapons"

datum/design/lasercannon
	name = "Laser Cannon"
	desc = "A heavy duty laser cannon."
	id = "lasercannon"
	req_tech = list("combat" = 4, "materials" = 3, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 10000, "$glass" = 1000, "$diamond" = 2000)
	build_path = "/obj/item/weapon/gun/energy/rifle/lasercannon"
	locked = 1
	category = "Weapons"

datum/design/decloner
	name = "Decloner"
	desc = "Your opponent will bubble into a messy pile of goop."
	id = "decloner"
	req_tech = list("combat" = 5, "materials" = 7, "biotech" = 4, "powerstorage" = 5)
	build_type = PROTOLATHE
	materials = list("$gold" = 5000,"$uranium" = 5000, "$plasma" = 1500) //"mutagen" = 40 Don't think protolathe can hold chems anymore.  Not sure.  It's redundant anyway.  Mutagen is easy.
	build_path = "/obj/item/weapon/gun/energy/decloner"
	locked = 1
	category = "Weapons"

datum/design/chemsprayer
	name = "Chem Sprayer"
	desc = "An advanced chem spraying device."
	id = "chemsprayer"
	req_tech = list("materials" = 3, "engineering" = 5, "biotech" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 5000, "$glass" = 1000, "$plasma" = 3000)
	reliability_base = 100
	build_path = "/obj/item/weapon/reagent_containers/spray/chemsprayer"
	category = "Weapons"

datum/design/rapidsyringe
	name = "Rapid Syringe Gun"
	desc = "A gun that fires many syringes."
	id = "rapidsyringe"
	req_tech = list("combat" = 3, "materials" = 3, "engineering" = 3, "biotech" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 5000, "$glass" = 1000)
	build_path = "/obj/item/weapon/gun/syringe/rapidsyringe"
	category = "Medical Equipment"

datum/design/largecrossbow
	name = "Energy Crossbow"
	desc = "A weapon favoured by syndicate infiltration teams."
	id = "largecrossbow"
	req_tech = list("combat" = 4, "materials" = 5, "engineering" = 3, "biotech" = 4, "syndicate" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 5000, "$glass" = 1000, "$uranium" = 1000, "$silver" = 1000)
	build_path = "/obj/item/weapon/gun/energy/crossbow/largecrossbow"
	category = "High-Risk Items"

datum/design/temp_gun
	name = "Freeze Ray"
	desc = "A gun that shoots temperature bullet energythings to change temperature."//Change it if you want
	id = "temp_gun"
	req_tech = list("combat" = 3, "materials" = 4, "powerstorage" = 3, "magnets" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 5000, "$glass" = 500, "$silver" = 3000)
	build_path = "/obj/item/weapon/gun/energy/temperature"
	locked = 1
	category = "General"

datum/design/flora_gun
	name = "Floral Somatoray"
	desc = "A tool that discharges controlled radiation which induces mutation in plant cells. Harmless to other organic life."
	id = "flora_gun"
	req_tech = list("materials" = 2, "biotech" = 3, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 2000, "$glass" = 500, "$uranium" = 500)
	build_path = "/obj/item/weapon/gun/energy/floragun"
	category = "General"

datum/design/large_grenade
	name = "Large Grenade"
	desc = "A grenade that affects a larger area and use larger containers."
	id = "large_Grenade"
	req_tech = list("combat" = 3, "materials" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 3000)
	reliability_base = 79
	build_path = "/obj/item/weapon/grenade/chem_grenade/large"
	category = "General"

datum/design/smg
	name = "Submachine Gun"
	desc = "A lightweight, fast firing gun."
	id = "smg"
	req_tech = list("combat" = 4, "materials" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 8000, "$silver" = 2000, "$diamond" = 1000)
	build_path = "/obj/item/weapon/gun/projectile/automatic"
	locked = 1
	category = "Weapons"

datum/design/rapidlaser
	name = "Rapid-fire Laser"
	desc = "A fast-firing laser that shoots bursts of weaker beams."
	id = "rapidlaser"
	req_tech = list("combat" = 4, "materials" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 5000, "$uranium" = 1000)
	build_path = "/obj/item/weapon/gun/energy/automatic/rapidlaser"
	locked = 1
	category = "Weapons"

datum/design/ammo_9mm
	name = "Ammunition Box (9mm)"
	desc = "A box of prototype 9mm ammunition."
	id = "ammo_9mm"
	req_tech = list("combat" = 4, "materials" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 3750, "$silver" = 100)
	build_path = "/obj/item/ammo_magazine/c9mm"
	category = "Weapons"

datum/design/stunshell
	name = "Stun Shell"
	desc = "A stunning shell for a shotgun."
	id = "stunshell"
	req_tech = list("combat" = 3, "materials" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 4000)
	build_path = "/obj/item/ammo_casing/shotgun/stunshell"
	category = "Weapons"

datum/design/stunshellbox
	name = "Stun Shell box"
	desc = "A box full of stun shells."
	id = "stunshellbox"
	req_tech = list("combat" = 3, "materials" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 20000)
	build_path = "/obj/item/ammo_magazine/shotgun/stun"
	category = "Weapons"

datum/design/plasmapistol
	name = "plasma pistol"
	desc = "A specialized firearm designed to fire lethal bolts of toxins."
	id = "ppistol"
	req_tech = list("combat" = 5, "plasmatech" = 4)
	build_type = PROTOLATHE
	materials = list("$metal" = 5000, "$glass" = 1000, "$plasma" = 3000)
	build_path = "/obj/item/weapon/gun/energy/toxgun"
	category = "Weapons"

datum/design/lawgiver
	name = "Lawgiver Mk II"
	desc = "A highly advanced firearm for the modern police force. It has multiple voice-activated firing modes."
	id = "lawgiver"
	req_tech = list("combat" = 6, "plasmatech" = 4, "bluespace" = 5, "materials" = 7)
	build_type = PROTOLATHE
	materials = list("$metal" = 6000, "$glass" = 1000, "$uranium" = 1000, "$plasma" = 1000, "$diamond" = 3000)
	build_path = "/obj/item/weapon/gun/energy/lawgiver"
	category = "Weapons"

datum/design/bprotopistol
	name = "Basic Protopistol"
	desc = "A highly customizeable handgun.  This one looks pretty basic."
	id = "bprotopistol"
	req_tech = list("combat" = 3, "materials" = 3, "powerstorage" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 4000, "$glass" = 1000)
	build_path = "/obj/item/weapon/gun/energy/laser/modular/pistol/crap"
	locked = 1
	category = "Weapons"

datum/design/protopistol
	name = "Protopistol"
	desc = "A highly customizeable handgun."
	id = "protopistol"
	req_tech = list("combat" = 4, "materials" = 3, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 8000, "$glass" = 3000, "$uranium" = 1000, "$plasma" = 1000)
	build_path = "/obj/item/weapon/gun/energy/laser/modular/pistol"
	locked = 1
	category = "Weapons"

datum/design/aprotopistol
	name = "Advanced Protopistol"
	desc = "A highly customizeable handgun.  This one has a more powerful frame."
	id = "aprotopistol"
	req_tech = list("combat" = 6, "materials" = 7, "powerstorage" = 5)
	build_type = PROTOLATHE
	materials = list("$metal" = 8000, "$glass" = 4000, "$uranium" = 2000, "$plasma" = 2000, "$diamond" = 1000)
	build_path = "/obj/item/weapon/gun/energy/laser/modular/pistol/advanced"
	locked = 1
	category = "Weapons"
/*This is all the station gets for producable force gloves. It's a high-risk item and thus considered contraband
outside of RnD without paperwork with the RD's stamp on it. */
datum/design/forcegloves
 	name = "Force Gloves"
 	desc = "These gloves bend gravity and bluespace, dampening inertia and augmenting the wearer's melee capabilities."
 	id = "forcegloves"
 	req_tech = list("combat" = 3,"bluespace" = 3, "engineering" = 3, "magnets" = 3)
 	build_type = PROTOLATHE
 	materials = list("$metal" = 4000)
 	build_path = "/obj/item/clothing/gloves/force/basic"
 	locked = 1
 	category = "Weapons"

/////////////////////////////////////////
/////////////////Mining//////////////////
/////////////////////////////////////////

datum/design/jackhammer
	name = "Sonic Jackhammer"
	desc = "Cracks rocks with sonic blasts, perfect for killing cave lizards."
	id = "jackhammer"
	req_tech = list("materials" = 3, "powerstorage" = 2, "engineering" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 2000, "$glass" = 500, "$silver" = 500)
	build_path = "/obj/item/weapon/pickaxe/jackhammer"
	category = "Engineering Equipment"

datum/design/drill
	name = "Mining Drill"
	desc = "Yours is the drill that will pierce through the rock walls."
	id = "drill"
	req_tech = list("materials" = 2, "powerstorage" = 3, "engineering" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 6000, "$glass" = 1000) //expensive, but no need for miners.
	build_path = "/obj/item/weapon/pickaxe/drill"
	category = "Engineering Equipment"

datum/design/plasmacutter
	name = "Plasma Cutter"
	desc = "You could use it to cut limbs off of xenos! Or, you know, mine stuff."
	id = "plasmacutter"
	req_tech = list("materials" = 4, "plasmatech" = 3, "engineering" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 1500, "$glass" = 500, "$gold" = 500, "$plasma" = 500)
	reliability_base = 79
	build_path = "/obj/item/weapon/pickaxe/plasmacutter"
	category = "Engineering Equipment"

/* I'm sorry, but the diamond drill is pretty much redundant.  And it messes with my immersions.
datum/design/pick_diamond
	name = "Diamond Pickaxe"
	desc = "A pickaxe with a diamond pick head, this is just like minecraft."
	id = "pick_diamond"
	req_tech = list("materials" = 6)
	build_type = PROTOLATHE
	materials = list("$diamond" = 3000)
	build_path = "/obj/item/weapon/pickaxe/diamond"
*/
datum/design/drill_diamond
	name = "Diamond Mining Drill"
	desc = "Yours is the drill that will pierce the heavens!"
	id = "drill_diamond"
	req_tech = list("materials" = 6, "powerstorage" = 4, "engineering" = 4)
	build_type = PROTOLATHE
	materials = list("$metal" = 3000, "$glass" = 1000, "$diamond" = 3750) //Yes, a whole diamond is needed.
	reliability_base = 79
	build_path = "/obj/item/weapon/pickaxe/diamonddrill"
	category = "Engineering Equipment"

datum/design/mesons
	name = "Optical Meson Scanners"
	desc = "Used for seeing walls, floors, and stuff through anything."
	id = "mesons"
	req_tech = list("magnets" = 2, "engineering" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/clothing/glasses/meson"
	category = "Engineering Equipment"

datum/design/materialscan
	name = "Optical Material Scanner"
	desc = "Used for seeing objects through walls."
	id = "optical_scanner"
	build_type = PROTOLATHE
	req_tech = list("magnets" = 3, "engineering" = 3)
	materials = list("$metal" = 50, "$glass" = 50, "$silver" = 50)
	build_path = "/obj/item/clothing/glasses/material"
	category = "General"

datum/design/nightvisiongoggles
	name = "Night Vision Goggles"
	desc = "Used to see in the dark"
	id = "night_vision_goggles"
	build_type = PROTOLATHE
	req_tech = list("magnets" = 4, "engineering" = 2, "combat" = 2)
	materials = list("$metal" = 50, "$glass" = 50, "$gold" = 50)
	build_path = "/obj/item/clothing/glasses/night"
	category = "High-Risk Items"

datum/design/sciencegoggles
	name = "Science Goggles"
	desc = "They still do nothing."
	id = "science_goggles"
	build_type = PROTOLATHE
	req_tech = list("magnets" = 1)
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/clothing/glasses/science"
	category = "General"

datum/design/superiorweldgoggles
	name = "Superior Welding Goggles"
	desc = "Welding Goggles made of slightly better materials."
	id = "s_weld_goggles"
	build_type = PROTOLATHE
	req_tech = list("materials" = 3)
	materials = list("$metal" = 50, "$glass" = 50, "$plasma" = 50, "$uranium" = 50)
	build_path = "/obj/item/clothing/glasses/welding/superior"
	category = "Engineering Equipment"

/////////////////////////////////////////
//////////////Blue Space/////////////////
/////////////////////////////////////////

datum/design/beacon
	name = "Tracking Beacon"
	desc = "A blue space tracking beacon."
	id = "beacon"
	req_tech = list("bluespace" = 1)
	build_type = PROTOLATHE
	materials = list ("$metal" = 20, "$glass" = 10)
	build_path = "/obj/item/device/radio/beacon"
	category = "Bluespace Technology"

datum/design/bag_holding
	name = "Bag of Holding"
	desc = "A backpack that opens into a localized pocket of Blue Space."
	id = "bag_holding"
	req_tech = list("bluespace" = 4, "materials" = 6)
	build_type = PROTOLATHE
	materials = list("$gold" = 3000, "$diamond" = 1500, "$uranium" = 250)
	reliability_base = 80
	build_path = "/obj/item/weapon/storage/backpack/holding"
	category = "Bluespace Technology"

datum/design/bluespace_crystal
	name = "Artificial Bluespace Crystal"
	desc = "A small blue crystal with mystical properties."
	id = "bluespace_crystal"
	req_tech = list("bluespace" = 5, "materials" = 7)
	build_type = PROTOLATHE
	materials = list("$gold" = 1500, "$diamond" = 3000, "$plasma" = 1500)
	reliability_base = 100
	build_path = "/obj/item/bluespace_crystal/artificial"
	category = "Bluespace Technology"

/////////////////////////////////////////
/////////////////HUDs////////////////////
/////////////////////////////////////////

datum/design/health_hud
	name = "Health Scanner HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their health status."
	id = "health_hud"
	req_tech = list("biotech" = 2, "magnets" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/clothing/glasses/hud/health"
	category = "Information Technology"

datum/design/security_hud
	name = "Security HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their ID status."
	id = "security_hud"
	req_tech = list("magnets" = 3, "combat" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/clothing/glasses/hud/security"
	locked = 1
	category = "Information Technology"

datum/design/security_glasses //added to list 6/4/15
	name = "Security HUD Sunglasses"
	desc = "A combination security HUD and sunglasses commonly worn by high-ranking security officers."
	id = "hudglasses"
	req_tech = list("magnets" = 5, "combat" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50, "$gold" = 50, "$silver" = 50)
	build_path = "/obj/item/clothing/glasses/sunglasses/sechud"
	category = "Information Technology"

/////////////////////////////////////////
//////////////////Test///////////////////
/////////////////////////////////////////

	/*	test
			name = "Test Design"
			desc = "A design to test the new protolathe."
			id = "protolathe_test"
			build_type = PROTOLATHE
			req_tech = list("materials" = 1)
			materials = list("$gold" = 3000, "iron" = 15, "copper" = 10, "$silver" = 2500)
			build_path = "/obj/item/weapon/banhammer" */

////////////////////////////////////////
//Disks for transporting design datums//
////////////////////////////////////////

/obj/item/weapon/disk/design_disk
	name = "Component Design Disk"
	desc = "A disk for storing device design data for construction in lathes."
	icon = 'icons/obj/cloning.dmi'
	icon_state = "datadisk2"
	item_state = "card-id"
	w_class = 1.0
	matter = list("metal" = 30, "glass" = 10)
	var/datum/design/blueprint

/obj/item/weapon/disk/design_disk/New()
	src.pixel_x = rand(-5.0, 5)
	src.pixel_y = rand(-5.0, 5)


/////////////////////////////////////////
//////////////Borg Upgrades//////////////
/////////////////////////////////////////
datum/design/borg_syndicate_module
	name = "Borg Illegal Weapons Upgrade"
	desc = "Allows for the construction of illegal upgrades for cyborgs"
	id = "borg_syndicate_module"
	build_type = MECHFAB
	req_tech = list("combat" = 4, "syndicate" = 3)
	build_path = "/obj/item/borg/upgrade/syndicate"
	category = "Cyborg Upgrade Modules"

/////////////////////////////////////////
/////////////PDA and Radio stuff/////////
/////////////////////////////////////////
datum/design/binaryencrypt
	name = "Binary Encryption Key"
	desc = "An encyption key for a radio headset.  Contains cypherkeys."
	id = "binaryencrypt"
	req_tech = list("syndicate" = 2)
	build_type = PROTOLATHE
	materials = list("$metal" = 300, "$glass" = 300)
	build_path = "/obj/item/device/encryptionkey/binary"
	category = "High-Risk Items"

datum/design/pda
	name = "PDA"
	desc = "A portable microcomputer by Thinktronic Systems, LTD. Functionality determined by a preprogrammed ROM cartridge."
	id = "pda"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/device/pda"
	category = "PDA Cartridges"

datum/design/cart_basic
	name = "Generic Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_basic"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge"
	category = "PDA Cartridges"

datum/design/cart_engineering
	name = "Power-ON Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_engineering"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/engineering"
	category = "PDA Cartridges"

datum/design/cart_atmos
	name = "BreatheDeep Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_atmos"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/atmos"
	category = "PDA Cartridges"

datum/design/cart_medical
	name = "Med-U Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_medical"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/medical"
	category = "PDA Cartridges"

datum/design/cart_chemistry
	name = "ChemWhiz Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_chemistry"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/chemistry"
	category = "PDA Cartridges"

datum/design/cart_security
	name = "R.O.B.U.S.T. Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_security"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/security"
	locked = 1
	category = "PDA Cartridges"

datum/design/cart_janitor
	name = "CustodiPRO Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_janitor"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/janitor"
	category = "PDA Cartridges"

/*
datum/design/cart_clown
	name = "Honkworks 5.0 Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_clown"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/clown"
datum/design/cart_mime
	name = "Gestur-O 1000 Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_mime"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/mime"
*/

datum/design/cart_toxins
	name = "Signal Ace 2 Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_toxins"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/signal/science"
	category = "PDA Cartridges"

datum/design/cart_quartermaster
	name = "Space Parts & Space Vendors Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_quartermaster"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/quartermaster"
	locked = 1
	category = "PDA Cartridges"

datum/design/cart_hop
	name = "Human Resources 9001 Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_hop"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/hop"
	locked = 1
	category = "PDA Cartridges"

datum/design/cart_hos
	name = "R.O.B.U.S.T. DELUXE Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_hos"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/hos"
	locked = 1
	category = "PDA Cartridges"

datum/design/cart_ce
	name = "Power-On DELUXE Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_ce"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/ce"
	locked = 1
	category = "PDA Cartridges"

datum/design/cart_cmo
	name = "Med-U DELUXE Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_cmo"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/cmo"
	locked = 1
	category = "PDA Cartridges"

datum/design/cart_rd
	name = "Signal Ace DELUXE Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_rd"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/rd"
	locked = 1
	category = "PDA Cartridges"

datum/design/cart_captain
	name = "Value-PAK Cartridge"
	desc = "A data cartridge for portable microcomputers."
	id = "cart_captain"
	req_tech = list("engineering" = 2, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = "/obj/item/weapon/cartridge/captain"
	locked = 1
	category = "PDA Cartridges"
