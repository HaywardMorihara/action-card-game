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
