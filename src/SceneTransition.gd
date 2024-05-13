extends CanvasLayer

func change_scene(scene: PackedScene):
	var img = get_viewport().get_texture().get_image()
	img.flip_y()
	var screenshot := ImageTexture.new()
	screenshot.create_from_image(img)
	$TextureRect.texture = screenshot

	$AnimationPlayer.play_backwards("SceneTransition")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(scene)
	$AnimationPlayer.play("SceneTransition")
	get_tree().paused = true
	await $AnimationPlayer.animation_finished
	get_tree().paused = false

func _ready():
	$AnimationPlayer.play("RESET")
