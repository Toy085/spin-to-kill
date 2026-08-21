@icon ("res://addons/at-icons/node2d/ghost.svg")
extends CharacterBody2D
class_name Enemy

@export var speed : float = 50
@export var attack_damage: int = 1
@export var knockback_strength = 350

@onready var bullet_scene: PackedScene = preload("res://assets/bullet.tscn")
@onready var coin: PackedScene = preload("res://coin.tscn")
@onready var attack_cooldown: Timer = $AttackCooldown
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var player_in_range: CharacterBody2D = null

var player: CharacterBody2D
var health = randi_range(5, 20)

var knockback_velocity: Vector2 = Vector2.ZERO

enum Type { walk, fly }
var enemy_type: Type = Type.walk

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	var rng = randf()
	if rng < 0.9:
		enemy_type = Type.walk
		if randi_range(0, 1) > 0:
			animated_sprite_2d.play("Enemy1")
		else:
			animated_sprite_2d.play("Enemy3")
			health = randi_range(1, 5)
			var clone = self.duplicate() as Enemy
			clone.global_position = global_position + Vector2(20, 0)
			get_parent().add_child(clone)
			speed = speed * 1.5
	elif rng < 1:
		enemy_type = Type.fly
		speed = speed * 1.25
		animated_sprite_2d.play("Enemy2")
	

func _process(delta: float) -> void:
	if health <= 0:
		die()

	if player:
		match enemy_type:
			Type.walk:
				var direction = (player.global_position - global_position).normalized()
				if global_position.distance_to(player.global_position) < 24:
					velocity = knockback_velocity
				else:
					velocity = direction * speed + knockback_velocity
				move_and_slide()
	
				knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 500 * delta)
			Type.fly:
				if global_position.distance_to(player.global_position) < 150:
					if attack_cooldown.is_stopped():
						shoot_bullet()
						attack_cooldown.start()
					
					velocity = knockback_velocity
					move_and_slide()
					
					knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 500 * delta)
					
					return
				
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

func shoot_bullet() -> void:
	if bullet_scene and player:
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = global_position
		bullet.direction = (player.global_position - global_position).normalized()

func attack_player() -> void:
	if player_in_range and health > 0:
		player_in_range.damage(attack_damage)
		if attack_cooldown:
			attack_cooldown.start()
