extends Area2D

const MEDIUM_ASTEROID = preload("res://Scenes/Medium_Asteroid/Medium_Asteroid.tscn")
var screen_size
var speed
var rotation_speed
var direction
var volume = 24


func _ready():
	screen_size = get_viewport_rect().size
	set_direction_and_speed()


func _process(delta):
	# Screen Wrap
	if position.x < 0:
		position.x = screen_size.x
	if position.x > screen_size.x:
		position.x = 0
	if position.y < 0:
		position.y = screen_size.y
	if position.y > screen_size.y:
		position.y = 0

	# Moving 
	position += direction * speed * delta
	rotation += rotation_speed * delta


func set_direction_and_speed():
	var angle = randf_range(0, 2 * PI)  # Random angle in radians
	direction = Vector2(cos(angle), sin(angle))  # Convert angle to direction vector
	speed = randf_range(75, 200)  # Random speed between 75 and 200
	rotation_speed = randf_range(-1, 1)


func destroy():
	Globals.increase_score.emit(100)
	call_deferred("create_and_add_asteroids")


func create_and_add_asteroids():
	# Instantate two small asteroids
	var medium_asteroid1 = MEDIUM_ASTEROID.instantiate()
	var medium_asteroid2 = MEDIUM_ASTEROID.instantiate()

	# Set their positions to the position of the medium asteroid
	medium_asteroid1.position = self.position
	medium_asteroid2.position = self.position

	# Add them as children of the medium asteroid's parent
	self.get_parent().add_child(medium_asteroid1)
	self.get_parent().add_child(medium_asteroid2)

	# Queue the medium asteroid for deletion
	self.queue_free()
