extends Node2D

var im1
var im2
var im3
var im4

func _ready():
	im1 = get_node("Panel1")
	im2 = get_node("Panel2")
	im3 = get_node("Panel3")
	im4 = get_node("Panel4")
	invisible_panel(im1)
	invisible_panel(im2)
	invisible_panel(im3)
	invisible_panel(im4)

#func _process(delta):
	#if Gamestatus.panels_list[0]:
		#visible_panel(im1)
	#if Gamestatus.panels_list[1]:
		#visible_panel(im2)
	#if Gamestatus.panels_list[2]:
		#visible_panel(im3)
	#if Gamestatus.panels_list[3]:
		#visible_panel(im4)

func visible_panel(image):
	var tween = get_tree().create_tween()
	tween.tween_property(image, "modulate", Color(1,1,1,1), 0.2)

func invisible_panel(image):
	var tween = get_tree().create_tween()
	tween.tween_property(image, "modulate", Color(1,1,1,0), 0.2)


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		if Gamestatus.panels_list[0]:
			print("wou")
			visible_panel(im1)
		if Gamestatus.panels_list[1]:
			visible_panel(im2)
		if Gamestatus.panels_list[2]:
			visible_panel(im3)
		if Gamestatus.panels_list[3]:
			visible_panel(im4)
