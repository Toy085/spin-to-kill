extends CharacterBody2D

@onready var axe_pivot: Node2D = $AxePivot

@export var speed : float = 300
@export var spin_speed: float = 12

var is_spinning: bool = false

func _physics_process(delta:float) -> void:
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vector * speed
	move_and_slide()

	if Input.is_action_just_pressed("attack"):
		is_spinning = true
		axe_pivot.show()
		
	if is_spinning:
		axe_pivot.rotation += spin_speed * delta
		
		if axe_pivot.rotation >= 2 * PI: # Stop rotation at 360
			axe_pivot.rotation = 0
			is_spinning = false
			axe_pivot.hide()
