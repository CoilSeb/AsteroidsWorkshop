extends Node

var score: int
var lives = 1
var high_score = 0

signal increase_score(value)
signal take_damage(player)


func _ready():
	pass # Replace with function body.


func _process(_delta):
	pass


func save_high_score():
	var saved_score = FileAccess.open("user://high_score.save", FileAccess.WRITE)
	var save_text = JSON.stringify({"High Score": Globals.high_score})
	saved_score.store_line(save_text)


func load_high_score():
	if not FileAccess.file_exists("user://high_score.save"):
		print_debug("File does not exist")
		return 0
	var saved_score = FileAccess.open("user://high_score.save", FileAccess.READ)
	var json_string = saved_score.get_line()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print_debug("No JSON")
		return 0
	var data = json.get_data()
	return data["High Score"]
