extends Area2D

@onready var martian = $".."

var volume = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func destroy():
	Globals.increase_score.emit(750)
	martian.queue_free()
