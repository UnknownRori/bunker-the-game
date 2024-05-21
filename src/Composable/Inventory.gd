extends Node

@export var basic: PackedScene = preload("res://scene/Player/player_bullet.tscn")
@export var special: PackedScene = preload("res://scene/Player/player_grenade.tscn")

@export var basic_has = -1
@export var special_has = 10

func fill_grenade():
	special_has += 10
