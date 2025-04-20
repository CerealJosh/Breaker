extends Node2D

@export var scene:PackedScene;
@export var resources:Array[Resource];
var startTimer:Timer;

var lives:int = 4;
var randomizerThreshold:float =0.4;

const boundary:float = 150;
const row_number:int = 10;
const block_size:int = 32;
const left_boundary:float = 80;
const right_boundary:float = 496;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startTimer = get_node("startTimer");
	get_tree().paused =true;
	#%Music.play(AutoLoad.musicProgress);
	generateblock(14);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_key_pressed(KEY_BACKSPACE)):
		get_tree().reload_current_scene();
	get_node("Score").text = _format_score(AutoLoad.score);
	if(get_children().size()<=12):
		%Ball.resetBall(get_node("Paddle").position.x);
		if(randomizerThreshold<0.9):
			randomizerThreshold+=0.1;
		generateblock(14);

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
			if(randf()* row_number/10>randomizerThreshold):
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
		AutoLoad.gamePlaying = false;
		%GOScore.text = "Score: " + _format_score(AutoLoad.score);
		%GameOver.visible = true;

func _death() -> void:
	lives -=1;
	var livesss = get_node("Lives").get_children();
	livesss.pop_back().queue_free();

func _format_score(score: int) -> String:
	return str(score).pad_zeros(8);

func _on_retry_pressed() -> void:
	AutoLoad.musicProgress = %Music.get_playback_position();
	AutoLoad.score =000000;
	get_tree().reload_current_scene();
	AutoLoad.gamePlaying = true;

func _on_quit_pressed() -> void:
	get_tree().quit();

func _on_start_timer_timeout() -> void:
	get_tree().paused = false; # Replace with function body.

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Intro.tscn");
