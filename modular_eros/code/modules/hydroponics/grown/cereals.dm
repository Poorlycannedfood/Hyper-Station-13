/obj/item/seeds/wheat/ashen
	name = "ashen hair seeds"
	desc = "Brought over by the western tribe, these seeds grow into ashen hair."
	icon_state = "seed-ashhair"
	species = "ashhair"
	plantname = "Ash Hair Stalks"
	product = /obj/item/reagent_containers/food/snacks/grown/wheat/ashen
	production = 1
	yield = 4
	potency = 15
	icon_dead = "ashhair-dead"
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	mutatelist = list()
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.04)

/obj/item/reagent_containers/food/snacks/grown/wheat/ashen
	seed = /obj/item/seeds/wheat/ashen
	name = "ashen hair"
	desc = "A westerners' delicacy."
	gender = PLURAL
	icon_state = "ashhair"
	filling_color = "#F0E68C"
	bitesize_mod = 2
	foodtype = VEGETABLES
	grind_results = list(/datum/reagent/consumable/flour = 0)
	tastes = list("ash" = 3, "wheat" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/beer
