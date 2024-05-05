extends Node2D

@onready var text = $Text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text.text = str(Engine.get_frames_per_second())
	pass
