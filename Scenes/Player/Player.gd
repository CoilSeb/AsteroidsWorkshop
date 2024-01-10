extends CharacterBody2D

@onready var shoot_Timer = $ShootTimer
var screen_size
var thrust = 500
var maxSpeed = 10
var rotateSpeed = 5
var slowDown = 1


func _ready():
	screen_size = get_viewport_rect().size


func _physics_process(delta):
	if position.x < 0:
		position.x = screen_size.x
	if position.x > screen_size.x:
		position.x = 0
	if position.y < 0:
		position.y = screen_size.y
	if position.y > screen_size.y:
		position.y = 0
		
	if Input.is_action_pressed("rotate_left"):
		rotation += -1 * rotateSpeed * delta
	if Input.is_action_pressed("rotate_right"):
		rotation += 1 * rotateSpeed * delta
	if Input.is_action_pressed("thrust"):
		velocity += ((Vector2(0, -1) * thrust * delta).rotated(rotation))
	else:
		velocity = lerp(velocity, Vector2.ZERO, slowDown * delta)
		if velocity.y >= -1 && velocity.y <= 1:
			velocity.y = 0
			
	move_and_collide(velocity * delta)
