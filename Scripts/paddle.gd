extends CharacterBody2D


@export var SPEED = 300.0
var floaty: float;

func  _ready() -> void:
	floaty = position.y;

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	velocity.y = move_toward(velocity.y,0,0)
	if(AutoLoad.gamePlaying):
		move_and_slide()
		position.y = clamp(position.y,floaty,floaty)
