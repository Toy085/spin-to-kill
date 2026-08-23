@icon ("res://addons/at-icons/node/globe.svg")
extends Node

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

func _ready() -> void:
	var language = "automatic"
# Load here language from the user settings file
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
