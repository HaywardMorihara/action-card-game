class_name Deck extends Node2D

signal shuffle_finished

@export_dir var cards_directory : String = "res://card_game/cards"

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var top_card : Sprite2D = $TopCard
@onready var middle_card : Sprite2D = $MiddleCard
@onready var bottom_card : Sprite2D = $BottomCard

var contents : Array[Card]

# TODO should this be here long term?
var card_scene_name_to_scene : Dictionary = {}

func _ready() -> void:
	_load_deck_contents();
	GlobalGets.func_get_deck_contents = func() : return contents

func _process(delta) -> void:
	match contents.size():
		2:
			bottom_card.visible = true	
			middle_card.visible = true	
			top_card.visible = false
		1:
			bottom_card.visible = true	
			middle_card.visible = false	
			top_card.visible = false
		0:
			bottom_card.visible = false	
			middle_card.visible = false	
			top_card.visible = false
		_:
			bottom_card.visible = true	
			middle_card.visible = true	
			top_card.visible = true	

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
