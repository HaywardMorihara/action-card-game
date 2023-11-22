class_name Playmat extends Interactive

# Of the format <AREA_ID>_playmat_<INCREMENT>
@export var playmat_id : String;

@onready var options : Control = $PlaymatOptions as Control;
@onready var save_button : Button = $PlaymatOptions/SaveButton as Button;
@onready var default_save_text := save_button.text;
@onready var default_save_button_pos := save_button.position as Vector2;

var save_button_complete_pos_offset : Vector2 = Vector2(8, 0);

func _ready() -> void:
	assert(playmat_id, "playmat_id must be set");
	GlobalState.save_complete.connect(_on_save_complete);

func _interaction() -> void:
	options.show();

func _exit_interaction() -> void:
	options.hide();
	save_button.text = default_save_text;
	save_button.disabled = false;
	save_button.position = default_save_button_pos;

func _on_shuffle_button_pressed() -> void:
	GlobalSignals.reshuffle.emit();

func _on_save_button_pressed() -> void:
	GlobalState.last_playmat_data.playmat_id = playmat_id;
	GlobalState.save();
	
func _on_save_complete() -> void:
	save_button.text = "Saved!";
	save_button.disabled = true;
	save_button.position += save_button_complete_pos_offset;

func _on_edit_deck_button_pressed() -> void:
	GlobalState.last_playmat_data.playmat_id = playmat_id;
	GlobalSignals.scene_transition_to.emit("res://card_game/deck_editor/DeckEditor.tscn");
