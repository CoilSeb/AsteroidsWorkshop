extends Area2D

var direction: Vector2
var bullet_speed = 700
var screen_size


func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	position += direction * bullet_speed * delta
	if position.x < 0:
		queue_free()
	if position.x > screen_size.x:
		queue_free()
	if position.y < 0:
		queue_free()
	if position.y > screen_size.y:
		queue_free()


func _on_area_entered(area):
	Globals.explosion.emit(area.volume)
	area.destroy()
	queue_free()
