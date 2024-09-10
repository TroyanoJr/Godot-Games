extends Node2D

export (PackedScene) var GalaxyBlueBoss_2 : PackedScene
var enemey_scene = preload("res://enemy/scene/Enemy_2.tscn")
var screen_size:Vector2
var life
var score

func _ready():
	randomize()
	init_ui()
	screen_size = get_viewport_rect().size
	$GameOverLabel.hide()
	
	
	
func init_ui():
	life = AutoLoad.life
	score = AutoLoad.score
	for i in life:
		$GameUI.add_life()
	
func Enemy_Loader_timeout():
	var enemy = enemey_scene.instance()
	enemy.position = Vector2(screen_size.x +400,rand_range(35,screen_size.y-35))	
	enemy.connect("destroy",self,"on_Enemy_destroy")
	add_child(enemy)
	Enemy_attack(enemy)
	
func on_Enemy_destroy():
	score+=100
	$GameUI.update_score(score)
	
	
func Enemy_attack(enemy):
	var bullet = enemy.BulletScene.instance()
	bullet.is_enemy = true
	bullet.position = enemy.get_node("BulletPosition").global_position
	add_child(bullet)

func _on_Player_destroy():
	life-=1
	if life <0:
		game_over()
	else:
		$GameUI.reduce_life()
		$RestorePlayer.start()

func _on_RestorePlayer_timeout():
	$Player.show()
	$Player/PlayerEffect.start()
	
func game_over():
	$GameOverLabel.show()
	$GameOverDelay.start()

func _on_GameOverDelay_timeout():
	yield(get_tree().create_timer(1),"timeout")
	get_tree().change_scene("res://ui/scene/Menu.tscn")

func _on_GameTimer_timeout():
	var boss = _load_boss()
	$EnemyLoader.stop()
	yield(get_tree().create_timer(3),"timeout")
	$Player._can_play = false
	yield(get_tree().create_timer(2),"timeout")
	boss._move_on()
	yield(get_tree().create_timer(2),"timeout")
	$Player._can_play = true
	boss.get_node("CollisionPolygon2D").disabled = false

func _load_boss():
	var boss = GalaxyBlueBoss_2.instance()
	boss.position = $BossPosition.position
	boss.connect("dead",self,"_on_boss_defeated")
	add_child(boss)
	return boss
	
func _on_boss_defeated():
	score +=1000
	$GameUI.update_score(score)
	yield(get_tree().create_timer(2),"timeout")
	$Player._can_play = false
	yield(get_tree().create_timer(3),"timeout")
	#print("Muevete!")
	$Player._move_on()
	
	
	
	#print("Se movio!")
