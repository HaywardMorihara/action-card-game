extends Control

const main_scene_path : String = "res://Main.tscn"

func _on_resume_button_pressed() -> void:
	GlobalState.load();
	get_tree().change_scene_to_file(main_scene_path);

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/menus/MainMenu.tscn");
