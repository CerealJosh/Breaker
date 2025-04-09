extends Node2D

@export var scene:PackedScene;
@export var resources:Array[Resource];

const boundary:float = 150;
const row_number:int = 10;
const block_size:int = 32;
const left_boundary:float = 96;
const right_boundary:float = 480;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateblock(13);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_key_pressed(KEY_BACKSPACE)):
		get_tree().reload_current_scene();

func generateblock(number: int)-> void:
	for j in range(row_number):
		for i in range(number):
			var block:Block = scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE);
			block.position = Vector2(left_boundary+ i*block_size,boundary - j*block_size/2);
			block.resource = resources[j%4];
			block.name = "block_" + str(i)+"_"+str(j);
			if(randf()* row_number/10>0.5):
				block.queue_free();
			else:
				add_child(block);
