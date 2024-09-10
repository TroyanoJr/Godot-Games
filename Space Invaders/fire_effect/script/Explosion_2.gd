extends Node2D


func _ready():
	$Animation.play("explosion")


func _on_Animation_animation_finished(anim_name):
	queue_free()
