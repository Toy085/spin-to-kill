## This is used for creating new shop items
class_name ShopItem
extends Resource

enum ItemType { 
	HEALTH, ## Increase health
	SPEED, ## Player moves faster
	DAMAGE, ## Deal more damage
	MAGNET_RADIUS, ## Increase magnet radius for picking up coins
	COOLDOWN_REDUCTION, ## For the spin attack
	GREED ## More coins dropped during runs
}

@export_group("Visuals & Info")
@export var item_name: String = "Default Item"
@export_multiline var description: String = ""
@export var icon: Texture2D

@export_group("Mechanics")
@export var type: ItemType = ItemType.HEALTH
@export var stat_modifier: float = 0.1 ## e.g., 0.1 means +10% speed or damage

@export_group("Shop Progression") 
@export var base_price: int = 100
@export var price_multiplier_per_level: float = 1.5
@export var current_level: int = 0
@export var max_level: int = 5
