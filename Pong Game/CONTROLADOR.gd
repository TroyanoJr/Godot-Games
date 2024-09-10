extends Node

var puntos = 0
var puntos2 = 0

func _puntajeIzq():
	puntos+=1
	get_tree().get_nodes_in_group("Puntaje Izquierdo")[0].text = str(puntos)
	
func _puntajeDer():
	puntos2+=1
	get_tree().get_nodes_in_group("Puntaje Derecho")[0].text = str(puntos2)
	

