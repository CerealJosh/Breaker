extends RigidBody2D

@export var launchSpeed:float;

var InitialPosition:Vector2 = Vector2(0,0);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InitialPosition = position;
	var direction =  Vector2(1,1);
	print(direction)
	linear_velocity += direction * launchSpeed;

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	linear_velocity = state.linear_velocity.normalized() * absf(launchSpeed);
