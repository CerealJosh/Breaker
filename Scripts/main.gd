extends Node2D

@export var scene:PackedScene;
@export var resources:Array[Resource];

var lives:int = 3;

const boundary:float = 150;
const row_number:int = 10;
const block_size:int = 32;
const left_boundary:float = 80;
const right_boundary:float = 496;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateblock(14);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_key_pressed(KEY_BACKSPACE)):
		get_tree().reload_current_scene();

func generateblock(number: int)-> void:
	for j in range(row_number):
		for i in range(number/2):
			var block:Block = scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE);
			var mirror:Block = scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE);
			block.position = Vector2(left_boundary+ i*block_size,boundary - j*block_size/2);
			mirror.position = Vector2(right_boundary- i*block_size,boundary - j*block_size/2);
			var rse = j%4;
			mirror.resource = resources[rse];
			block.resource = resources[rse];
			block.name = "block_" + str(i)+"_"+str(j);
			mirror.name = "block_" + str(14-i)+"_"+str(j);
			print(block.name + "   " +mirror.name);
			if(randf()* row_number/10>0.5):
				block.queue_free();
				mirror.queue_free();
			else:
				add_child(block);
				add_child(mirror);

func _on_killzone_body_entered(body: Node2D) -> void:
	if(lives>1):
		_death();
		%Ball.resetBall(get_node("Paddle").position.x);
	else:
		get_tree().reload_current_scene();

func _death() -> void:
	lives -=1;
	var livesss = get_node("Lives").get_children();
	livesss.pop_back().queue_free();
