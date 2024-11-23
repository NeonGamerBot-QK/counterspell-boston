extends Node2D  # This will work for 2D backgrounds

func _input(event):
	# Check if the "M" key is pressed
	if event.is_action_pressed("menu"):
		# Change to the menu scene
		get_tree().change_scene_to_file("res://menu.tscn")
