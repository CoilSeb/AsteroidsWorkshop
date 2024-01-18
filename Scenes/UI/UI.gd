extends CanvasLayer

var screen_size


func _ready():
	Globals.connect("increase_score", update_score)
	Globals.connect("take_damage", update_lives)
	screen_size = get_viewport().get_visible_rect().size


func _process(_delta):
	if Input.is_action_just_pressed("Escape"):
		toggle_pause_menu()
	if $Restart_Button.visible == true && Input.is_action_just_pressed("shoot"):
		restart()


func update_score(value):
	Globals.score += value
	$Score_Label.text = "Score: " + Globals.get_score_text(Globals.score)


func update_lives(player):
	Globals.lives -= 1
	if Globals.lives == 2:
		$Life3_Texture.visible = false
		player.position = Vector2(960,540)
		player.velocity = Vector2(0,0)
		player.rotation = 0
	elif Globals.lives == 1:
		player.position = Vector2(960,540)
		player.velocity = Vector2(0,0)
		player.rotation = 0
		$Life2_Texture.visible = false
	elif Globals.lives == 0:
		game_over()
		player.queue_free()
		$Life1_Texture.visible = false


func game_over():
	if Globals.score > Globals.high_score:
		Globals.high_score = Globals.score
		$High_Score_Label.text = "New High Score: " + Globals.get_score_text(Globals.high_score)
		Globals.save_high_score()
	else: $High_Score_Label.text = "High Score: " + Globals.get_score_text(Globals.high_score)
	$Score_Label.set("theme_override_font_sizes/font_size", 56)
	$Score_Label.position.y = screen_size.y/2 - 45
	$High_Score_Label.visible = true
	$Restart_Button.visible = true


func toggle_pause_menu():
	get_tree().paused = not get_tree().paused
	$Pause_Menu.visible = !$Pause_Menu.visible


func restart():
	if get_tree().paused:
		toggle_pause_menu()
	get_tree().reload_current_scene()
	Globals.reset_variables()


func _on_restart_button_pressed():
	restart()


func _on_resume_button_pressed():
	toggle_pause_menu()


func _on_exit_button_pressed():
	toggle_pause_menu()
	get_tree().change_scene_to_file("res://Scenes/Start_Screen/Start_Screen.tscn")
