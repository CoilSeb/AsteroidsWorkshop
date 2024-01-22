extends CharacterBody2D

var speed = 400
var move_direction = Vector2(0,0)
var screen_size
var moving = true
var shoot = false
const MARTIAN_BULLET = preload("res://Scenes/Martian_Bullet/Martian_Bullet.tscn")
var player_pos


func _ready():
	screen_size = get_viewport_rect().size
	get_random_vector()
	Globals.connect("player_pos", get_players_pos)


func _physics_process(delta):
	if position.x < 0:
		position.x = screen_size.x
	if position.x > screen_size.x:
		position.x = 0
	if position.y < 0:
		position.y = screen_size.y
	if position.y > screen_size.y:
		position.y = 0
		
	if moving:
		position += move_direction * delta * speed
		move_and_slide()
		
	if shoot:
		var martian_bullet_instance = MARTIAN_BULLET.instantiate()  # Create a new instance of the Bullet scene
		get_parent().add_child(martian_bullet_instance)  # Add it to the player node or a designated parent node for bullets
		martian_bullet_instance.global_position = global_position 
		martian_bullet_instance.direction = Vector2.UP.rotated(get_angle_to(player_pos) + (0.5 * PI))
		shoot = false


func get_random_vector():
	move_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()


func _on_move_timer_timeout():
	moving = false
	shoot = true
	$ShootTimer.start(1)


func _on_shoot_timer_timeout():
	get_random_vector()
	moving = true
	$MoveTimer.start(2)


func get_players_pos(pos):
	player_pos = pos


func destroy():
	queue_free()
