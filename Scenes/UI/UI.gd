extends CanvasLayer

var screen_size


func _ready():
	Globals.connect("increase_score", update_score)
	Globals.connect("take_damage", update_lives)
	screen_size = get_viewport().get_visible_rect().size


func _process(_delta):
	pass


func update_score(value):
	Globals.score += value
	$Score_Label.text = "Score: " + str(Globals.score)


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
		$High_Score_Label.text = "New High Score: " + str(Globals.high_score)
	else: $High_Score_Label.text = "High Score: " + str(Globals.high_score)
	$Score_Label.set("theme_override_font_sizes/font_size", 56)
	$Score_Label.position = screen_size/2 - Vector2(60, 45)
	$High_Score_Label.visible = true
	
