extends Node2D

var score = 0
func _ready():
	$Player.connect("stomb",self,"Update_Score")
	
	
func _Update_Score():
	score+=10
	$game_ui/GameUI.update_score(score)
