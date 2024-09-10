extends MarginContainer

export (PackedScene) var PlayerLife: PackedScene

const Score = "SCORE : "

func _ready():
	update_score(0)

	
func  update_score(score):
	$HSplitContainer/Score.text = Score + str(score)
	
func reduce_life():
	$HSplitContainer/CenterContainer/HBoxContainer.get_child(0).queue_free()
	
func add_life():
	if $HSplitContainer/CenterContainer/HBoxContainer.get_child_count() < 5:
		var instance = PlayerLife.instance()
		$HSplitContainer/CenterContainer/HBoxContainer.add_child(instance)
	
