class_name Deck extends Node2D

signal shuffle_finished

@export_dir var cards_directory : String = "res://card_game/cards"

@onready var animation_player : AnimationPlayer = $AnimationPlayer

var card_scene_name_to_scene : Dictionary = {}

var contents : Array[Card]

var animation_name_shuffle : String = "shuffle";

func _ready():
	_load_deck_contents();

func draw_card() -> Card:
	return contents.pop_front();

func shuffle():
	randomize();
	contents.shuffle();
	animation_player.play("shuffle");
	# TODO SFX
	await animation_player.animation_finished
	shuffle_finished.emit();

func remove(card : Card) -> Card:
	for i in len(contents):
		if contents[i] == card:
			contents.remove_at(i);
			return card;
	return null

func add_to_top(card : Card):
	# TODO 
	pass

func add_to_bottom(card : Card):
	# TODO
	pass

# TODO
func _load_deck_contents():
	var saved_deck_contents := {
		"fireball/FireballCard.tscn": 10,
	}
	
	for card_scene_name in saved_deck_contents:
		var card_scene : Resource = card_scene_name_to_scene.get(card_scene_name);
		if not card_scene:
			card_scene = load("%s/%s" % [cards_directory, card_scene_name]);
			card_scene_name_to_scene[card_scene_name] = card_scene;
		for i in saved_deck_contents[card_scene_name]:
			contents.append(card_scene.instantiate());
