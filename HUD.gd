extends CanvasLayer

signal start_game()

func update_score(score):
	$ScoreLabelL.text = str(score)
	
func update_score2(score2):
	$ScoreLabelR.text = str(score2)
	
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func _on_Button_pressed():
	$Button.hide()
	emit_signal("start_game")
	

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Dodge the Aliens!"
	$MessageLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$Button.show()

func _on_MessageTimer_timeout():
	$MessageLabel.hide()
