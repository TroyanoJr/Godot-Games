extends Area2D

signal hit

func _on_Ground_area_entered(area):
	emit_signal("hti")
