extends Node

var total_money : int = 0
var current_run_money : int = 0

func player_died():
	total_money += current_run_money
	current_run_money = 0
	
	get_tree().change_scene_to_file("res://ShopMenu.tscn")
