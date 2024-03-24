extends Control

const main_scene_path : String = "res://Main.tscn"

@onready var new_game_button : Button = $NewGameButton as Button;
@onready var continue_button : Button = $ContinueButton as Button;

func _ready() -> void:
	GlobalState.reset();
	if GlobalState.save_data_exists():
		continue_button.disabled = false;
		continue_button.grab_focus();
	else:
		continue_button.disabled = true;
		new_game_button.grab_focus();

func _on_new_game_button_pressed() -> void:
	GlobalState.reset();
	get_tree().change_scene_to_file(main_scene_path);

func _on_continue_button_pressed() -> void:
	GlobalState.load();
	get_tree().change_scene_to_file(main_scene_path);

func _on_exit_button_pressed() -> void:
	get_tree().quit();
