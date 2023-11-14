class_name CardCollection extends VBoxContainer

@onready var card_option_scene : Resource = preload("res://card_game/deck_editor/CardOption.tscn");

func _ready() -> void:
	_load_contents();

func _load_contents() -> void:
	print("IMPLEMENT ME");

func _can_drop_data(_pos, data):
	return CardDictionary.is_valid(data);

func _drop_data(_pos, data):
	# TODO
	print(data);
