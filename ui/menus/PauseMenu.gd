extends Control

signal resume

const main_menu_scene_path : String = "res://ui/menus/MainMenu.tscn" as String;

func _on_resume_button_pressed() -> void:
	resume.emit();

func _on_button_pressed() -> void:
	resume.emit();
	get_tree().change_scene_to_file(main_menu_scene_path);
