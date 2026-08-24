@icon ("res://addons/at-icons/node2d/ghost.svg")
extends CharacterBody2D
class_name Enemy

@export var speed : float = 50
@export var attack_damage: int = 1
@export var knockback_strength: float = 350

@onready var bullet_scene: PackedScene = preload("res://assets/bullet.tscn")
@onready var coin: PackedScene = preload("res://coin.tscn")
@onready var attack_cooldown: Timer = $AttackCooldown
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var player_in_range: CharacterBody2D = null

var player: CharacterBody2D
var health = randi_range(5, 20)
var reward: int = randi_range(1 + Global.greed, 5 + Global.greed)

var knockback_velocity: Vector2 = Vector2.ZERO

enum Type { walk, fly }
var enemy_type: Type = Type.walk

var clone_num: int = 0

func _ready() -> void:
	var smol := RectangleShape2D.new()
	smol.size = Vector2(20, 15)
	player = get_tree().get_first_node_in_group("player")

	var rng = randi_range(1, 10)
	if rng <= 8:
		if randi_range(0, 1) > 0:
			enemy_type = Type.walk
			animated_sprite_2d.play("Enemy1")
		else:
			enemy_type = Type.walk
			animated_sprite_2d.play("Enemy3")
			collision_shape_2d.shape = smol
			health = randi_range(1, 5)
			
			if clone_num < Global.deaths:
				var clone = self.duplicate() as Enemy
				clone.clone_num = clone_num + 1
				clone.global_position = global_position + Vector2(20, 0)
				get_parent().add_child(clone)
			speed *= 1.5
			reward /= 2
	elif rng == 9:
		# Snail
		knockback_strength /= 2
		speed /= 2
		attack_damage *= 2
		reward *= 2
		health *= 2
		
		enemy_type = Type.walk
		animated_sprite_2d.play("Enemy4")
		collision_shape_2d.shape = smol
	elif rng == 10:
		enemy_type = Type.fly
		speed *= 1.25
		animated_sprite_2d.play("Enemy2")
		
	if reward <= 0:
		reward = 1

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

func _on_attack_cooldown_timeout() -> void:
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
