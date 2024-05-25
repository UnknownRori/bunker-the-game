extends Node

@export_category("Item Drop")
@export var item: PackedScene
@export var number: int



func _on_health_death():
	var instance = item.instantiate()
	instance.global_position = get_parent().global_position
	instance.fill = number
	get_node("/root/World").add_child(instance)
