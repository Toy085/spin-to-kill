extends CharacterBody2D

@export var speed : float = 50

var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func die():
	var reward = randi_range(1, 5)
	Global.current_run_money += reward
	
	queue_free()
