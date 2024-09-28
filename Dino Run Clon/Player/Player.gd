extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY : int = 4200
const JUMP_SPEED:int = -1800
var velocity = Vector2.ZERO

func _physics_process(delta):
	
	velocity.y+=GRAVITY*delta
	
	if is_on_floor():
		if not get_parent().game_running:
			$AnimatedSprite.play("Idle")
		else:
			$RunCol.disabled=false
			if Input.is_action_pressed("ui_accept"):
				#$AnimatedSprite.play("Jump")
				velocity.y= JUMP_SPEED
				print("salta")
			elif Input.is_action_pressed("ui_down"):
					$AnimatedSprite.play("Duck")
					$RunCol.disabled=true
			else:
				$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("Jump")
	
	move_and_slide(velocity,UP)
