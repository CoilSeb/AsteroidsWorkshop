extends Node2D

@onready var spawn_timer = $Spawn_Timer

var screen_size
var asteroid_scenes = {
	0: preload("res://Scenes/Large_Asteroid/Large_Asteroid.tscn"),
	1: preload("res://Scenes/Medium_Asteroid/Medium_Asteroid.tscn"),
	2: preload("res://Scenes/Small_Asteroid/Small_Asteroid.tscn")
}


func _ready():
	screen_size = get_viewport().get_visible_rect().size


func _process(_delta):
	pass


func spawn_asteroid():
	var new_asteroid = asteroid_scenes[randi_range(0,2)].instantiate()
	add_child(new_asteroid)
	new_asteroid.global_position = generate_spawn_point()


func random_vector(left, right, bottom, top):
	return Vector2(randf_range(left, right), randf_range(bottom, top))

func generate_spawn_point():
	var locations = [
		# Upper Rectangle
		random_vector(0, screen_size.x, screen_size.y, screen_size.y),
		# Lower Rectangle
		random_vector(0, screen_size.x, -screen_size.y, -screen_size.y),
		# Right Rectangle
		random_vector(screen_size.x, screen_size.x, 0, screen_size.y),
		# Left Rectangle
		random_vector(-screen_size.x, -screen_size.x, 0, screen_size.y),
	]
	return locations[randi_range(0,3)]


func _on_spawn_timer_timeout():
	spawn_asteroid()
