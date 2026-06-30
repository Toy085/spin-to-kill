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

func player_died():
	total_money += current_run_money
	current_run_money = 0
	
	get_tree().change_scene_to_file("res://ShopMenu.tscn")
