extends Node2D

@export var speed: float = 400.0
@export var damage_amount: int = 1
@export var lifetime: float = 5.0

var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	get_tree().create_timer(lifetime).timeout.connect(queue_free)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("damage"):
			body.damage(damage_amount)
		queue_free()
