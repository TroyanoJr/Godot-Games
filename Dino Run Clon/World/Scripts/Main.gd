extends Node

#preload obstacles
var stump_scene = preload("res://World/Scenes/Obstacles/Stump.tscn")
var rock_scene = preload("res://World/Scenes/Obstacles/Rock.tscn")
var barrel_scene = preload("res://World/Scenes/Obstacles/Barrel.tscn")
var bird_scene = preload("res://World/Scenes/Obstacles/Bird.tscn")

var obstacles_types=[stump_scene,rock_scene,barrel_scene]
var obstacles:Array
var bird_heights=[200,390]
var ground_height:int

const DINO_START_POS=Vector2(150,485)
const CAM_START_POS=Vector2(576,324)

var speed
const START_SPEED=5.0
const MAX_SPEED=25
var screen_size = Vector2()
var score:int
var SCORE_MODIFIER=10
const SPEED_MODIFIER=5000
var game_running:bool
var last_obs
#called when the node enters the scene tree for the first time.
func _ready():
	screen_size=get_viewport().size
	_new_game()

func _new_game():
	#reset the nodes
	score=0
	show_score()
	game_running=false
	$Player.position =DINO_START_POS
	$Player.velocity=Vector2(0,0)
	$Camera2D.position= CAM_START_POS
	$Ground.position=Vector2(0,0)
	$HUD/StartLabel.show()

#Called every frame. 'delta' is the elapse time since the previous frame.
func _process(delta):
	
	if game_running:	
		speed = START_SPEED+score / SPEED_MODIFIER
		if speed > MAX_SPEED:
			speed = MAX_SPEED
			
			
		#genrate obstacles
		generate_obs()
		#move dino and camera
		$Player.position.x+=speed
		$Camera2D.position.x+=speed
		
		#Update Score
		score+=speed
		show_score()

		#Update ground position
		if $Camera2D.position.x - $Ground.position.x > screen_size.x*1.5:
			$Ground.position.x+=screen_size.x
			
	else:
		if(Input.is_action_pressed("ui_accept")):
			game_running = true;
			$HUD/StartLabel.hide()

func generate_obs():
	#generate ground obstacles
	if obstacles.empty():
		var obs_type = obstacles_types[randi() % obstacles_types.size()]
		var obs
		obs = obs_type.instance()
		var obs_height = obs.get_node("Sprite2D").texture.get_height()
		var obs_scale = obs.get_node("Sprite2D").scale
		var obs_x : int = screen_size.x+score+100
		var obs_y: int = screen_size.y - ground_height -(obs_height*obs_scale.y/2)+5
		last_obs = obs
		add_child(obs)
		obstacles.append(obs)
		
	
func show_score():
	$HUD/ScoreLabel.text = "SCORE: "+str(score/SCORE_MODIFIER)
