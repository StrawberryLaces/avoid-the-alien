extends Node

export (PackedScene) var mob_scene
var score = 0
var score2 = 0
var over1 = false
var over2 = false

func _ready():
	randomize()

func new_game():
	score = 0
	score2 = 0
	over1 = false
	over2 = false
	$HUD.update_score(score)
	$HUD.update_score(score2)
	
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	$Player2.start($StartPosition2.position)
	
	$StartTimer.start()
	$Music.play()
	
	$HUD.show_message("Ready...")
	
	yield($StartTimer, "timeout")
	$ScoreTimer.start()
	$ScoreTimer2.start()
	$MobTimer.start()
	
	
func game_over():
	$ScoreTimer.stop()
	over1 = true
	if over2==true:
		$MobTimer.stop()
		$HUD.show_game_over()
		$HUD.show_message("Pink Wins!")
		$Music.stop()
		$DeathSound.play()
	else:
		$Music.stop()
		$DeathSound.play()
		$Music.play()
	
func game_over2():
	$ScoreTimer2.stop()
	over2 = true
	if over1 == true:
		$MobTimer.stop()
		$HUD.show_game_over()
		$HUD.show_message("Green Wins!")
		$Music.stop()
		$DeathSound.play()
	else:
		$Music.stop()
		$DeathSound.play()
		$Music.play()

func _on_MobTimer_timeout():
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.unit_offset = randf()

	var mob = mob_scene.instance()
	add_child(mob)
	
	mob.position = mob_spawn_location.position

	var direction = mob_spawn_location.rotation + PI / 2
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)
	

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_ScoreTimer2_timeout():
	score2 += 1
	$HUD.update_score2(score2)



