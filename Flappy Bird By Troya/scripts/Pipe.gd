extends Area2D

signal hit
signal scored

func _on_Pipe_body_entered(body):
		emit_signal("hit")


func _on_ScoredArea_body_entered(body):
	emit_signal("scored")
