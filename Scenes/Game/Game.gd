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
	new_asteroid.position = generate_spawn_point()


func generate_spawn_point():
	var x = randf_range(-(100 + screen_size.x), screen_size.x + 100)
	var y = randf_range(-(100 + screen_size.y), screen_size.y + 100)
	
	if (x > screen_size.x/2 && x < screen_size.x/2) or (y > screen_size.y/2 && y < screen_size.y/2):
		generate_spawn_point()
		
	return Vector2(x,y)


func _on_spawn_timer_timeout():
	spawn_asteroid()
