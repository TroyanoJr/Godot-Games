tool
extends Area2D

export var next_scene: PackedScene
onready var anim_player = $AnimationPlayer

func _on_Portal2D_body_entered(body):
	_teleport()

func _get_configuration_warning():
	return "The next scene property can't be empty" if not next_scene else ""

func _teleport():
	anim_player.play("fade_in")
	yield(anim_player,"animation_finished")
	get_tree().change_scene_to(next_scene)



