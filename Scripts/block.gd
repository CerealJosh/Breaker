class_name Block;
extends StaticBody2D

@export var resource: Resource;
var health:int;
var initial_health:int;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = resource.health;
	initial_health = resource.health;
	%BlockSprite.texture = resource.textures[0];
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health<= 0):
		
		queue_free();
	else:
		%BlockSprite.texture = resource.textures[initial_health-health];
	
func _damage() -> void:
	health -= 1;
