extends Control

func _ready():
	pass
	
func on_Play_pressed():
	get_tree().change_scene("res://Niveles/scene/Nivel_1.tscn")
			
func on_Exit_pressed():
	get_tree().quit()
	pass

