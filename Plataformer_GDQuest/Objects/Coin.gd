extends Area2D

onready var anim_player = get_node("AnimationPlayer")
signal get_coin

func _on_Coin_body_entered(body):
	anim_player.play("fade_out")
	emit_signal("get_coin")
	
