@icon ("res://addons/at-icons/node2d/axe.svg")
extends Area2D
class_name Axe

@export var Thrown: bool = false
@export var speed: float = 250
@export var spin_speed: float = 32

var dir
var mouse_pos: Vector2
var returning: bool = false
var player: CharacterBody2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	if Thrown:
		dir = (mouse_pos - global_position).normalized()

func _process(delta: float) -> void:
	if not Thrown:
		return
		
	if not returning and global_position.distance_to(mouse_pos) < 10:
		returning = true
	
	if returning and player:
		dir = (player.global_position - global_position).normalized()
		
		if global_position.distance_to(player.global_position) < 10:
			queue_free()

	global_position += dir * speed * delta
	rotation += spin_speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and is_visible_in_tree():
		body.damage(Global.damage)
