extends Area2D
func _on_wall_area_entered(area):
	if(area.name == "ball"):
		CONTROLADOR._puntajeIzq()
		area.reset()
		
