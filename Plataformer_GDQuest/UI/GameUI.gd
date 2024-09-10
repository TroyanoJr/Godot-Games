extends CanvasLayer

const Score = "SCORE : "

func _ready():
	update_score(0)
	
func update_score(score):
	$HSplitContainer/Score.text = Score+str(score)

