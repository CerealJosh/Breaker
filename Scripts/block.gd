extends StaticBody2D
class_name Block;

@export var resource: Resource;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%BlockSprite.texture = resource.texture;
	pass
