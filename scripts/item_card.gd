# shop_card.gd
extends PanelContainer

signal bought

@onready var item_name_label: Label = $VBoxContainer/ItemName
@onready var item_icon: TextureRect = $VBoxContainer/ItemIcon
@onready var description_label: Label = $VBoxContainer/Description
@onready var buy_button: Button = $VBoxContainer/BuyButton

var current_item: ShopItem = null
var current_price: int = 0

func setup_card(item: ShopItem) -> void:
	if not item:
		hide()
		return
		
	current_item = item
	show()
	
	# Calculate price based on item level progression
	current_price = int(item.base_price * pow(item.price_multiplier_per_level, item.current_level))
	
	# Set UI texts
	item_name_label.text = item.item_name
	item_icon.texture = item.icon
	description_label.text = item.description
	
	if item.current_level >= item.max_level:
		buy_button.text = "MAXED"
		buy_button.disabled = true
	else:
		buy_button.text = str(current_price) + "g"
		buy_button.disabled = false

func _on_buy_button_pressed() -> void:
	if not current_item or Global.total_money < current_price:
		print("Not enough money!")
		return
		
	Global.total_money -= current_price
	current_item.current_level += 1
	
	match current_item.type:
		ShopItem.ItemType.HEALTH:
			Global.max_health += int(current_item.stat_modifier)
			Global.health = Global.max_health
		ShopItem.ItemType.SPEED:
			Global.speed += int(current_item.stat_modifier)
		ShopItem.ItemType.DAMAGE:
			Global.damage += int(current_item.stat_modifier)
		ShopItem.ItemType.MAGNET_RADIUS:
			Global.coin_radius += current_item.stat_modifier
		ShopItem.ItemType.COOLDOWN_REDUCTION:
			Global.cooldown -= current_item.stat_modifier
		ShopItem.ItemType.GREED:
			Global.greed += int(current_item.stat_modifier)
			
	# Notify the main shop scene to refresh prices or close
	bought.emit()
	
	# Update or disable card after purchase
	setup_card(current_item)
