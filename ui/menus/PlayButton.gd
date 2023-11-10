extends Button

const main_scene_path : String = "res://Main.tscn";

func _on_pressed() -> void:
	get_tree().change_scene_to_file(main_scene_path);
