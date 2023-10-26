class_name Deck extends Node2D

@export_dir var cards_directory : String = "res://card_game/cards"

var card_scene_name_to_scene : Dictionary = {}

var _deck_contents : Array[Card]

func _ready():
	_load_deck_contents();
	shuffle();

func draw_card() -> Card:
	return _deck_contents.pop_front();

func shuffle():
	randomize();
	_deck_contents.shuffle();

# TODO
func _load_deck_contents():
	var saved_deck_contents := {
		"FireballCard.tscn": 10,
	}
	
	for card_scene_name in saved_deck_contents:
		var card_scene : Resource = card_scene_name_to_scene.get(card_scene_name);
		if not card_scene:
			card_scene = load("%s/%s" % [cards_directory, card_scene_name]);
			card_scene_name_to_scene[card_scene_name] = card_scene;
		for i in saved_deck_contents[card_scene_name]:
			_deck_contents.append(card_scene.instantiate())
