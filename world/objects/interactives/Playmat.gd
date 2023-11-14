extends Interactive

@onready var options : Control = $PlaymatOptions as Control;
@onready var save_button : Button = $PlaymatOptions/SaveButton as Button;
@onready var default_save_text := save_button.text;

func _ready() -> void:
	GlobalState.save_complete.connect(_on_save_complete);

func _interaction() -> void:
	options.show();

func _exit_interaction() -> void:
	options.hide();
	save_button.text = default_save_text;
	save_button.disabled = false;

func _on_shuffle_button_pressed() -> void:
	GlobalSignals.reshuffle.emit();

func _on_save_button_pressed() -> void:
	GlobalState.save();
	
func _on_save_complete() -> void:
	save_button.text = "Save Complete!";
	save_button.disabled = true;

func _on_edit_deck_button_pressed() -> void:
	# TODO Transition effect
	get_tree().change_scene_to_file("res://card_game/deck_editor/DeckEditor.tscn");
