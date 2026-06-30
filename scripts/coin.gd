extends Area2D

@export var magnet_speed := 300.0
var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	if player:
		var distance = global_position.distance_to(player.global_position)

		if distance <= Global.coin_radius:
			global_position = global_position.move_toward(player.global_position, magnet_speed * delta)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.current_run_money += 1
		
		queue_free()
