extends Actor

var score = 0

signal stomb

export var stomp_impulse = 1000.0
func _on_EnemyDetector_area_entered(area):
	_velocity = calculate_stomp_velocity(_velocity,stomp_impulse)
	emit_signal("stomb")
	
	

func _on_EnemyDetector_body_entered(body):
	queue_free()
	
func _physics_process(delta):
	var direction = get_direction()
	var is_jump_interrumped = Input.is_action_just_released("space") and _velocity.y < 0.0
	_velocity = calculate_move_direction(_velocity,direction,speed,is_jump_interrumped)
	_velocity = move_and_slide(_velocity,FLOOR_NORMAL)

func get_direction():
	return Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
	-1.0 if Input.is_action_just_pressed("space") and is_on_floor() else 0.0)


func calculate_move_direction(linear_velocity,direction,speed,is_jump_interrumped):
	var out=linear_velocity
	out.x = speed.x*direction.x
	out.y += gravity*get_physics_process_delta_time()
	
	if direction.y==-1.0:
		out.y = speed.y*direction.y
	
	if is_jump_interrumped:
		out.y=0.0
	
	return out

func calculate_stomp_velocity(linear_velocity,impulse: float):
	var out = linear_velocity
	out.y = -impulse
	return out
