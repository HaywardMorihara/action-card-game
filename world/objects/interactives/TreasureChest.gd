extends Interactive

@export var card_id : String;

@onready var animation_player : AnimationPlayer = $AnimationPlayer as AnimationPlayer;
@onready var open_button : Button = $OpenButton as Button;

func _interaction() -> void:
	open_button.show();

func _exit_interaction() -> void:
	open_button.hide();

func _on_button_pressed() -> void:
	open_button.hide();
	animation_player.play("opening");
	await animation_player.animation_finished
	var card : Card = CardDictionary.create_card(card_id);
	GlobalSignals.card_obtained.emit(card);
