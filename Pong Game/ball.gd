extends Area2D

const DEFAULT_SPEED = 200
var speed = DEFAULT_SPEED
var direction = Vector2.DOWN

onready var _initial_pos = position

func _process(delta):
		#speed+= delta*2
		position += speed * delta * direction
		
func reset():
		direction = Vector2.LEFT
		position = _initial_pos
		speed = DEFAULT_SPEED
