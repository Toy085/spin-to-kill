extends Node2D

@export var enemy_scene : PackedScene

@onready var spawn_timer = $SpawnTimer

func _on_spawn_timer_timeout() -> void:
	if not enemy_scene:
		return
	
	var new_enemy = enemy_scene.instantiate()
	
	var random_x = randf_range(-1000, 1000)
	var random_y = randf_range(-1000, 1000)
	
	new_enemy.global_position = global_position + Vector2(random_x, random_y)
	
	get_tree().current_scene.add_child(new_enemy)
