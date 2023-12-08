extends CharacterBody2D

@onready var shoot_Timer = $ShootTimer
@onready var immunity_Timer = $Immunity_Timer
var screen_size
var thrust = 50 
var maxSpeed = 10
var rotateSpeed = 5


func _physics_process(delta):
	pass
