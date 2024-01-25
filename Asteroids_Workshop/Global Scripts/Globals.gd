extends Node

var score: int
var lives = 3
var high_score = 0

signal increase_score(value)
signal take_damage(player)
signal toggle_attack_cheats
signal toggle_spawn_cheats
signal toggle_inv_cheats
signal player_pos(player_coords)


func _ready():
	high_score = load_high_score()


func _process(_delta):
	pass


func reset_variables():
	score = 0
	lives = 3

func get_score_text(number):
	var score_string = str(number)
	var score_text = ""
	for i in range(len(score_string)):
		score_text += score_string[i]
		var distance = len(score_string) - i
		if distance != 1 and distance % 3 == 1:
			score_text += ","
	return score_text


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
