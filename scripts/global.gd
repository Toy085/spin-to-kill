@icon ("res://addons/at-icons/node/globe.svg")
extends Node

const SAVE_PATH := "user://save.tres"

var total_money : int = 0
var current_run_money : int = 0
var cooldown: float = 0.75
var health: int
var max_health: int = 100
var speed: int = 100
var damage: int = 5
var greed: int = 0
var coin_radius: float = 32
var axe_range: float = 50
var deaths: int = 0

var crash_scene: bool = false

var item_levels: Dictionary = {}

var is_mobile_os = OS.has_feature("mobile") or OS.has_feature("web_android") or OS.has_feature("web_ios")
var is_web = OS.has_feature("web")

func _ready() -> void:
	load_game()
	var language = "automatic"
	
	if language == "automatic":
		var preferred_language = OS.get_locale_language()
		TranslationServer.set_locale(preferred_language)
	else:
		TranslationServer.set_locale(language)

func get_item_level(item_name: String) -> int:
	return item_levels.get(item_name, 0)

func save_item_level(item_name: String, level: int) -> void:
	item_levels[item_name] = level

func player_died():
	total_money += current_run_money
	current_run_money = 0
	deaths += 1
	
	get_tree().call_deferred("change_scene_to_file", "res://ShopMenu.tscn")

func save_game() -> void:
	var data := SaveGame.new()
	data.total_money = total_money
	data.deaths = deaths
	data.item_levels = item_levels.duplicate()
	
	data.cooldown = cooldown
	data.max_health = max_health
	data.speed = speed
	data.damage = damage
	data.greed = greed
	data.coin_radius = coin_radius
	data.axe_range = axe_range
	
	ResourceSaver.save(data, SAVE_PATH)

func load_game() -> void:
	if not ResourceLoader.exists(SAVE_PATH):
		return
		
	var data := ResourceLoader.load(SAVE_PATH) as SaveGame
	if data:
		total_money = data.total_money
		deaths = data.deaths
		item_levels = data.item_levels.duplicate()
		
		cooldown = data.cooldown
		max_health = data.max_health
		speed = data.speed
		damage = data.damage
		greed = data.greed
		coin_radius = data.coin_radius
		axe_range = data.axe_range
		
		health = max_health
