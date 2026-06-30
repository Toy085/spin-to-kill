extends CharacterBody2D

@export var speed : float = 50
@export var attack_damage: int = 1

@onready var coin: PackedScene = preload("res://coin.tscn")
@onready var attact_cooldown: Timer = $AttactCooldown

var player_in_range: CharacterBody2D = null

var player
var health = randi_range(5, 20)

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	if health <= 0:
		die()

	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func damage(damage: int) -> void:
	health -= damage

func die() -> void:
	var reward = randi_range(1 + Global.greed, 5 + Global.greed)
	
	for i in range(reward):
		var coin_instance = coin.instantiate()
		coin_instance.global_position = global_position
		get_parent().add_child(coin_instance)
	queue_free()


func _on_attact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = body
		attack_player()

func _on_attact_area_body_exited(body: Node2D) -> void:
	if body == player_in_range:
		player_in_range = null
		attact_cooldown.stop()

func _on_attact_cooldown_timeout() -> void:
	attack_player()

func attack_player() -> void:
	if player_in_range and health > 0:
		player_in_range.damage(attack_damage)
		attact_cooldown.start()
