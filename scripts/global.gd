extends Node

var total_money : int = 0
var current_run_money : int = 0
var cooldown: float = 0.75
var health: int = 10
var speed: int = 300
var damage: int = 5
var greed: int = 0
var coin_radius: float = 6

func player_died():
	total_money += current_run_money
	current_run_money = 0
	
	get_tree().change_scene_to_file("res://ShopMenu.tscn")
