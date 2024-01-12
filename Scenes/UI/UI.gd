extends CanvasLayer


func _ready():
	Globals.connect("increase_score", update_score)


func _process(delta):
	pass


func update_score(value):
	Globals.score += value
	$Score_Label.text = "Score: " + str(Globals.score)
