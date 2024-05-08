extends Node

@export var hp = 100
@export var max_hp = 100
@export var damage_cooldown_spike = 1

@onready var controllable = get_parent().get_node("Controllable")
@onready var spike_timer = get_node("SpikeTimer")

var spike_damage = false

func damage(value) -> bool:
	hp -= value
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
	return hp < 0

func set_damage_spike():
	spike_damage = true

func _ready():
	spike_timer.connect("timeout", set_damage_spike)
	spike_timer.wait_time = damage_cooldown_spike

func _process(delta):
	pass
