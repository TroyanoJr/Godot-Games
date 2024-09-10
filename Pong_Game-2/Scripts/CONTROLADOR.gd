extends Node

var puntos_izq=0
var puntos_der=0

func puntaje_Izq():
	puntos_izq += 1
	get_tree().get_nodes_in_group("Score_Left")[0].text = str(puntos_izq)

func puntaje_Der():
	puntos_der += 1
	get_tree().get_nodes_in_group("Score_Right")[0].text = str(puntos_der)

