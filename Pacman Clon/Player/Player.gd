extends KinematicBody2D


var direction
var speed = 250

func _physics_process(delta):
	direction = Vector2.ZERO
	$AnimationPlayer.play("Walk")
	if Input.is_action_pressed("ui_up"):
		direction.y-=1
		#@$AnimationPlayer.play("Walk")
	if Input.is_action_pressed("ui_down"):
		direction.y+=1
		#$AnimationPlayer.play("Walk")
	if Input.is_action_pressed("ui_left"):
		$Sprite.flip_h=true
		direction.x-=1
		#$AnimationPlayer.play("Walk")
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		direction.x+=1
		#$AnimationPlayer.play("Walk")
		
	position+=speed*direction*delta
