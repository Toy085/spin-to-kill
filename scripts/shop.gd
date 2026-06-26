extends Control

@export var item_pool: Array[ShopItem]
@export var slots: Array[TextureRect]
@export var shopslot: TextureRect

@export var cycle_speed: float = 0.02 ## Delay between symbol switches
@export var slot_ticks: Array[int] = [30, 50, 70] ## Staggered stops for windows 1, 2, and 3
@export var card_scene: PackedScene = preload("res://item_card.tscn")

@onready var card_container = $CardContainer

@onready var SlotTimer = $SlotTimer

var shoptexture: Texture2D
var shoptexturepressed: Texture2D

var rolleditems: Array[ShopItem] = [null, null, null]
var is_spinning: bool = false
var spun: bool = false
var current_tick: int = 0

func _ready() -> void:
	shoptexture = preload("res://assets/images/🎰1.png")
	shoptexturepressed = preload("res://assets/images/🎰2.png")
	
	if shopslot:
		shopslot.texture = shoptexture
		
	if card_container:
		card_container.hide()

func _on_spin_button_pressed() -> void:
	if is_spinning:
		return

	if item_pool.is_empty():
		return
		
	if spun:
		return

	is_spinning = true
	spun = true
	current_tick = 0

	if shopslot and shoptexturepressed:
		shopslot.texture = shoptexturepressed
		get_tree().create_timer(0.15).timeout.connect(func(): 
			shopslot.texture = shoptexture
		)

	SlotTimer.wait_time = cycle_speed
	SlotTimer.start()

func _on_slot_timer_timeout() -> void:
	current_tick += 1
	var max_ticks = slot_ticks[2]
	
	for i in range(slot_ticks.size()):
		if current_tick < slot_ticks[i]:
			var random_item = item_pool.pick_random()

			if current_tick == slot_ticks[i] - 1:
				rolleditems[i] = random_item

			slots[i].texture = random_item.icon

	if current_tick >= max_ticks:
		SlotTimer.stop()
		is_spinning = false
		display_reward_cards()

func display_reward_cards() -> void:
	if not card_container or not card_scene:
		return
		
	# Clear out any card clones left over from old games
	for child in card_container.get_children():
		child.queue_free()
		
	# Build 3 separate interactive item cards
	for i in range(rolleditems.size()):
		var item = rolleditems[i]
		if item == null: 
			continue
			
		var card_instance = card_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.setup_card(item)
		
		# Optional: If any card triggers a purchase, update all other cards' price tags 
		card_instance.bought.connect(_on_card_purchased)
		
	# Smooth fade or immediate visibility switch
	card_container.show()

func _on_card_purchased() -> void:
	get_tree().change_scene_to_file("res://world.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")
