extends Node

@export var hp: float = 100
@export var max_hp: float = 100
@export var damage_cooldown_spike: float = 1
@export var should_animate_dead = false

@onready var parent: Object = get_parent()
@onready var controllable: Node = get_parent().get_node("Controllable")
@onready var movement: Node = get_parent().get_node("Movement")
@onready var attack: Node = get_parent().get_node("AttackComponent")
@onready var drop: Node = get_parent().get_node("DropComponent")
@onready var generic_ai: Node = get_parent().get_node("GenericAI")
@onready var sprite: AnimatedSprite2D = get_parent().get_node("Sprite")
@onready var spike_timer: Timer = get_node("SpikeTimer")

signal damage_signal
signal death

var dead_animate = false

var damage_sprite_timer = 1
var spike_damage = true

func restore_full():
	hp = max_hp
	
func is_max():
	return max_hp == hp

func damage(value) -> bool:
	if dead_animate:
		return is_dead()

	hp -= value
	
	sprite.play_damage()
	SoundChip.play_hit()
	if is_dead():
		emit_signal("death")
	else:
		emit_signal("damage_signal")

	return is_dead()

func damage_spike(value) -> bool:
	if spike_timer.is_stopped():
		spike_timer.start()

	if spike_damage:
		spike_timer.start()
		spike_damage = false
		return damage(value)
	return is_dead()

func is_dead() -> bool:
	return hp <= 0

func set_damage_spike():
	spike_damage = true

func _ready():
	spike_timer.connect("timeout", set_damage_spike)
	spike_timer.wait_time = damage_cooldown_spike

func _process(delta):
	if is_dead():
		if should_animate_dead:
			if !dead_animate:
				sprite.set_state(sprite.STATE.DEAD)
				sprite.play("dead")
				if generic_ai:
					get_parent().remove_child(generic_ai)
				if movement:
					get_parent().remove_child(movement)
				if attack:
					get_parent().remove_child(attack)
				
				dead_animate = true

				await sprite.animation_looped
				await sprite.animation_looped

		if parent.is_in_group("player"):
				parent.dead_callback()
		parent.queue_free()
	pass
