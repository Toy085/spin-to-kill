extends Node

var total_money : int = 0
var current_run_money : int = 0
var cooldown: float = 0.75 # done
var health: int
var max_health: int = 100
var speed: int = 100 # done
var damage: int = 5 # done
var greed: int = 0 # done
var coin_radius: float = 32

var item_levels: Dictionary = {}

func get_item_level(item_name: String) -> int:
	return item_levels.get(item_name, 0)

func save_item_level(item_name: String, level: int) -> void:
	item_levels[item_name] = level

func player_died():
	total_money += current_run_money
	current_run_money = 0
	
	get_tree().change_scene_to_file("res://ShopMenu.tscn")
