class_name Block;
extends StaticBody2D

var flashTimer:Timer;
@export var resource: Resource;
var health:int;
var initial_health:int;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flashTimer = %flashTimer;
	health = resource.health;
	initial_health = resource.health;
	%BlockSprite.texture = resource.textures[0];
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health<1):
		queue_free();
	else:
		%BlockSprite.texture = resource.textures[initial_health-health];
	
func _damage() -> void:
	flash();
	get_parent().get_node("HitSound").play();
	health -= 1;

func flash()-> void:
	%BlockSprite.material.set_shader_parameter("flash_modifier",1);
	flashTimer.start();

func _on_flash_timer_timeout() -> void:
	%BlockSprite.material.set_shader_parameter("flash_modifier", 0);
