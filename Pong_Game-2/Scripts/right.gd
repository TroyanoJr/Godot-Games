extends Area2D


const MOVE_SPEDD = 200

onready var _screeen_size_y = get_viewport_rect().size.y

var _ball_dir

func _ready():
	var n = String(name).to_lower()
	if n=="right":
		_ball_dir=-1
	else:
		_ball_dir=1


func _process(delta):
	var input = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	position.y = clamp(position.y + input * MOVE_SPEDD*delta,16,_screeen_size_y - 16)

func _on_area_entered(area):
	if(area.name == "ball"):
		area.direction = Vector2(_ball_dir,randf()*2 -1).normalized()
		$Music_right.play()
		
	

