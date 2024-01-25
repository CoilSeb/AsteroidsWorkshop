extends CharacterBody2D

@onready var shoot_timer = $ShootTimer

const BULLET = preload("res://Scenes/Bullet/Bullet.tscn")
var screen_size
var thrust = 500
var maxSpeed = 10
var rotateSpeed = 5
var slowDown = 1
var attack_speed = 0.35
var immune = true
var using_mouse = false
var toggle_attack_cheats = false
var toggle_inv_cheats = false


func _ready():
	screen_size = get_viewport_rect().size
	Globals.connect("toggle_attack_cheats", toggle_attack_cheat)
	Globals.connect("toggle_inv_cheats", toggle_inv_cheat)


func _physics_process(delta):
	if position.x < 0:
		position.x = screen_size.x
	if position.x > screen_size.x:
		position.x = 0
	if position.y < 0:
		position.y = screen_size.y
	if position.y > screen_size.y:
		position.y = 0
		
	if Input.is_action_just_pressed("Attack_Cheat"):
		Globals.toggle_attack_cheats.emit()
	if Input.is_action_just_pressed("Invulnerability_Cheat"):
		Globals.toggle_inv_cheats.emit()
		
	if Input.is_action_pressed("rotate_left"):
		rotation += -1 * rotateSpeed * delta
		using_mouse = false
		immune = false
	if Input.is_action_pressed("rotate_right"):
		using_mouse = false
		immune = false
		rotation += 1 * rotateSpeed * delta
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) || Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		using_mouse = true
	if using_mouse:
		rotate(get_angle_to(get_global_mouse_position()) + (0.5 * PI))
	if Input.is_action_pressed("thrust"):
		velocity += ((Vector2(0, -1) * thrust * delta).rotated(rotation))
		immune = false
	else:
		velocity = lerp(velocity, Vector2.ZERO, slowDown * delta)
		if velocity.y >= -1 && velocity.y <= 1:
			velocity.y = 0
			
	move_and_collide(velocity * delta)
	Globals.player_pos.emit(position)
	
	if Input.is_action_pressed("shoot") && shoot_timer.time_left == 0 && immune == false:  # Use action_just_pressed to prevent multiple bullets on a single press
		var bulletInstance = BULLET.instantiate()  # Create a new instance of the Bullet scene
		get_parent().add_child(bulletInstance)  # Add it to the player node or a designated parent node for bullets
		bulletInstance.global_position = global_position  # Set the bullet's position
		bulletInstance.direction = Vector2.UP.rotated(rotation)  # Set the bullet's direction
		shoot_timer.start(attack_speed)


func _on_area_2d_area_entered(_area):
	if immune :
		return
	elif toggle_inv_cheats:
		return
	else:
		Globals.take_damage.emit(self)
		immune = true


func toggle_attack_cheat():
	if toggle_attack_cheats:
		attack_speed = 0.35
	else: attack_speed = 0.01
	toggle_attack_cheats = !toggle_attack_cheats


func toggle_inv_cheat():
	toggle_inv_cheats = !toggle_inv_cheats
