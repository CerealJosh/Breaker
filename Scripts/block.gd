class_name Block;
extends StaticBody2D

@export var resource: Resource;
var health:int;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%BlockSprite.texture = resource.texture;
	health = resource.health;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health<= 0):
		queue_free();
	
func _damage() -> void:
	health -= 1;
