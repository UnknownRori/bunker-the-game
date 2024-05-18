extends Node

@export var speed: float = 250
@export var jump_power: float = -600

@export_range(0.0 , 1.0) var friction: float = 0.5
@export_range(0.0 , 1.0) var acceleration: float = 0.8

@export var gravity: float = 4000
@export var max_jumps: int = 2
@export var direction_face: int = 1
@export var direction := Vector2.ZERO
var jump_lerp = 0.
var current_jump: int = 0

@onready var parent: CharacterBody2D = get_parent()
@onready var sprite: AnimatedSprite2D = get_parent().get_node("Sprite")
@onready var controllable: Node = get_parent().get_node("Controllable")
@onready var hp: Node = get_parent().get_node("Health")
@onready var sound_chip: Node = SoundChip

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (controllable):
		direction = controllable.MOVE_DIR

	move(direction, delta)
	flip_animate(direction)

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

	direction = Vector2.ZERO

func _process(delta):
	if parent.is_on_floor():
		current_jump = 1
	
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

func move(direction: Vector2, delta: float):
	# gravity
	if parent.velocity.y < gravity:
		parent.velocity.y = min(800, parent.velocity.y + gravity * delta)
	if direction.x != 0:
		parent.velocity.x = lerp(parent.velocity.x, direction.x * speed, acceleration)
	else:
		parent.velocity.x = lerp(parent.velocity.x, 0.0, friction)

	parent.move_and_slide()
	
	jump(direction, delta)

# TODO : Refactor this later
func jump(direction, delta):
	if controllable:
		if !controllable.SWAP:
			if direction.y:
				if current_jump <= max_jumps:
					if jump_lerp == 0:
						current_jump = current_jump + 1
					parent.velocity.y = lerp(jump_power, gravity, jump_lerp)
					jump_lerp += delta
					if (controllable):
						sound_chip.play_jump()
			else:
				jump_lerp = 0
		else:
			if controllable.ACTION_B:
				if current_jump <= max_jumps:
					if jump_lerp == 0:
						current_jump = current_jump + 1
					parent.velocity.y = lerp(jump_power, gravity, jump_lerp)
					jump_lerp += delta
					if (controllable):
						sound_chip.play_jump()
			else:
				jump_lerp = 0
	else:
		if direction.y:
			if current_jump <= max_jumps:
				if jump_lerp == 0:
					current_jump = current_jump + 1
				parent.velocity.y = lerp(jump_power, gravity, jump_lerp)
				jump_lerp += delta
				if (controllable):
					sound_chip.play_jump()
		else:
			jump_lerp = 0
