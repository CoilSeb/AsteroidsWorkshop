extends CanvasLayer


func _ready():
	Globals.connect("increase_score", update_score)
	Globals.connect("take_damage", update_lives)


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
		player.queue_free()
		$Life1_Texture.visible = false
