extends CanvasLayer


# Called when the node enters the scene tree for the first time.
#var level1 = preload("res://level1.tscn")

func _ready():
	$BoxContainer.hide()
	$AnimatedSprite2D.play()
	await $AnimatedSprite2D.animation_finished
	$BoxContainer.show()

	


func _on_exit_pressed():
	fade_out()
	await get_tree().create_timer(2).timeout
	get_tree().quit()

func _on_start_button_up():
	fade_out()
	get_tree().change_scene_to_file("res://level1.tscn")


func fade_out():
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate", Color(0,0,0,1), 2)
	tween2.tween_property($BoxContainer, "modulate", Color(0,0,0,1), 2)
	$TextureRect.visible = true
