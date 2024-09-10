extends Node

export var pipe_scene : PackedScene
var game_running : bool
var game_over : bool
var scroll
var score : int = 0
const SCROLL_SPEED: int = 2
var screen_size : Vector2
var ground_height: int 
var pipes: Array
const PIPE_DELAY : int = 100
const PIPE_RANGE : int = 200

func _ready():
	screen_size = get_viewport().size
	ground_height = $Ground.get_node("Sprite").texture.get_height()
	new_game()
	
func new_game():
	game_running=false
	game_over = false;
	
	score =0
	scroll = 0
	pipes.clear()
	$ScoreLabel.text = str(score)
	$GameOver/RestartButton.hide()
	
	get_tree().call_group("pipes","queue_free")
	generate_pipe()
	$Bird.reset()
	
func _input(event):
	if game_over == false:
		if event is InputEvent:
			if event.is_action_pressed("saltar") and event.pressed:
				print("Salto ")
				if game_running==false:
					print("Entro al evento")
					start_game()
				else:
					if $Bird.flying:
						$Bird.flap()
						check_top()
				

func start_game():
	game_running=true
	$Bird.flying=true
	$Bird.flap()
	
	$PipeTimer.start()
	
func _process(delta):
	if game_running:
		scroll+=SCROLL_SPEED
		
		if scroll>= screen_size.x:
			scroll=0
		$Ground.position.x = -scroll
		
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED


func _on_PipeTimer_timeout():
	generate_pipe()
	

func generate_pipe():
	var pipe = pipe_scene.instance()
	#pipe.set_indexed()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height)/2 +rand_range(-PIPE_RANGE,PIPE_RANGE)
	pipe.connect("hit",self,"Bird_Hit")
	pipe.connect("scored",self,"Update_Score")
	add_child(pipe)
	pipes.append(pipe)
	
func Update_Score():
	score+=1
	$ScoreLabel.text = str(score)
	
func check_top():
	if $Bird.position.y < 0:
		$Bird.falling=true
		stop_game()
		
func stop_game():
	$PipeTimer.stop()
	$GameOver/RestartButton.show()
	$Bird.flying=false
	game_running=false
	game_over=true
	
func Bird_Hit():
	$Bird.falling=true
	stop_game()
	


func _on_Ground_hit():
	$Bird.falling=false
	stop_game()


func _on_GameOver_restart():
	new_game()
