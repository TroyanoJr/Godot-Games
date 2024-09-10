extends Area2D


func _on_wall_area_entered(area):
	if(area.name=="ball"):
		area.reset()
		Controlador.puntaje_Der()
		$Score_left.play()
