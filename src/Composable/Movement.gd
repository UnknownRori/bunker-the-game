extends Node

@export var speed: float = 250
@export var jump_power: float = -800

@export var friction: float = 40
@export var acceleration: float = 100

@export var gravity: float = 60
@export var max_jumps: int = 2
@export var direction_face: int = 1
var current_jump: int = 0

@onready var parent: Object = get_parent()
@onready var sprite: AnimatedSprite2D = get_parent().get_node("Sprite")
@onready var controllable: Node = get_parent().get_node("Controllable")
@onready var hp: Node = get_parent().get_node("Health")
@onready var sound_chip: Node = get_node("/root/World/SoundChip")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if (controllable):
		direction = controllable.MOVE_DIR

	if direction != Vector2.ZERO:
		accelerate(direction)
		flip_animate(direction)
		jump(direction)
	elif direction.x == 0:
		add_friction()
	
	gravity_update()
	parent.move_and_slide()

	for i in parent.get_slide_collision_count():
		var collision = parent.get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.name == "Platform":
			var tilemap = collider
			# Stupid way to get map
			var coordinate = tilemap.local_to_map(parent.position)
			var tile = tilemap.get_cell_tile_data(0, coordinate)
			if tile:
				if tile.get_custom_data("spike"):
					if hp:
						hp.damage_spike(10)

	pass
	
func flip_animate(direction):
	if (!sprite):
		return
		
	if (parent.velocity.x > 0):
		direction_face = 1
	elif (parent.velocity.x < 0):
		direction_face = -1

	if (direction_face == 0 || direction_face == 1):
		sprite.flip_h = false
	else:
		sprite.flip_h = true

func accelerate(direction):
	parent.velocity = parent.velocity.move_toward(speed * Vector2(direction.x, 0), acceleration)

func add_friction():
	parent.velocity = parent.velocity.move_toward(Vector2.ZERO, friction)

func gravity_update():
	parent.velocity.y += gravity

func jump(direction):
	if direction.y:
		if current_jump <= max_jumps:
			parent.velocity.y = jump_power
			current_jump = current_jump + 1
			if (controllable):
				sound_chip.play_jump()
	
	if parent.is_on_floor():
		current_jump = 1
