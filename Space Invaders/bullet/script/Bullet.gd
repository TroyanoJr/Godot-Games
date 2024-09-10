extends Area2D
export (bool) var is_enemy = false
export var move_speed = 350


func _ready():
	$AnimationPlayer.play("fire")
	
func _process(delta):
	if is_enemy:
		position.x-=500*delta
	else:
		position.x+=move_speed*delta
		

	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
