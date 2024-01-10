extends CharacterBody2D

@onready var shoot_Timer = $ShootTimer
var screen_size
var thrust = 500
var maxSpeed = 10
var rotateSpeed = 5


func _physics_process(delta):
	if Input.is_action_pressed("rotate_left"):
		rotation += -1 * rotateSpeed * delta
	if Input.is_action_pressed("rotate_right"):
		rotation += 1 * rotateSpeed * delta
	if Input.is_action_pressed("thrust"):
		velocity += ((Vector2(0, -1) * thrust * delta).rotated(rotation))
		
	move_and_collide(velocity * delta)
