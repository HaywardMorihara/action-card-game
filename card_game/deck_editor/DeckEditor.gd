extends Control

func _on_done_button_pressed() -> void:
	# TODO Determine which Area to return to
	get_tree().change_scene_to_file("res://Main.tscn");
