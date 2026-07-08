@icon ("res://addons/at-icons/node2d/ghost.svg")
extends CharacterBody2D
class_name Enemy

@export var speed : float = 50
@export var attack_damage: int = 1
@export var knockback_strength = 350

@onready var coin: PackedScene = preload("res://coin.tscn")
@onready var attack_cooldown: Timer = $AttackCooldown

var player_in_range: CharacterBody2D = null

var player: CharacterBody2D
var health = randi_range(5, 20)

var knockback_velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	if health <= 0:
		die()

	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed + knockback_velocity
		move_and_slide()
		
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 500 * delta)

func damage(damage: int, dir: Vector2) -> void:
	health -= damage
	
	knockback_velocity = dir * knockback_strength

func die() -> void:
	var reward = randi_range(1 + Global.greed, 5 + Global.greed)
	
	for i in range(reward):
		var coin_instance = coin.instantiate()
		var coin_pos = Vector2(randi_range(-32, 32), randi_range(-32, 32))
		coin_instance.global_position = global_position + coin_pos
		get_parent().add_child(coin_instance)
	queue_free()


func _on_attact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = body
		attack_player()

func _on_attact_area_body_exited(body: Node2D) -> void:
	if body == player_in_range:
		player_in_range = null
		attack_cooldown.stop()

func _on_attact_cooldown_timeout() -> void:
	attack_player()

func attack_player() -> void:
	if player_in_range and health > 0:
		player_in_range.damage(attack_damage)
		if attack_cooldown:
			attack_cooldown.start()
