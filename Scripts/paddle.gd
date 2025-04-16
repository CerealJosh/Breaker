extends CharacterBody2D


@export var SPEED = 300.0

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	position.y = clamp(position.y,296,296);
	velocity.y = clamp(velocity.y,0,0);

	move_and_slide()
