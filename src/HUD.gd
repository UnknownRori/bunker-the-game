extends CanvasLayer

# Fix this shit if the game is over and the player start again
@onready var hp = get_parent().get_node("Player").get_node("Health")
@onready var hp_bar = get_node("hp_bar")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_ui():
	if get_parent().get_node("Player"):
		hp_bar.text = "[right]" + str(hp.hp) + "[/right]"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_ui()
