extends RigidBody2D

@export var launchSpeed:float;

var InitialPosition:Vector2 = Vector2(0,0);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InitialPosition = position;
	var direction =  Vector2(1,1);
	print(direction)
	linear_velocity += direction * launchSpeed;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(linear_velocity);
