extends RigidBody2D

@export var launchSpeed:float;

var playing:bool = true;
var InitialPosition:Vector2 = Vector2(0,0);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InitialPosition = position;
	var direction =  Vector2(1,1);
	linear_velocity += direction * launchSpeed;

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if(playing == true):
		linear_velocity = state.linear_velocity.normalized() * absf(launchSpeed);
	else:
		linear_velocity = linear_velocity*0;


func _on_body_entered(body: Node) -> void:
		if(body.name.begins_with("block")):
			body._damage();
			
func resetBall() -> void:
	playing = false;
	position = InitialPosition;
