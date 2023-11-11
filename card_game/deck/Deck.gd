class_name Deck extends Node2D

signal shuffle_finished

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var top_card : Sprite2D = $TopCard
@onready var middle_card : Sprite2D = $MiddleCard
@onready var bottom_card : Sprite2D = $BottomCard

var contents : Array[Card];

func _ready() -> void:
	_load_deck_contents();
	shuffle();
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

func _load_deck_contents():
	for card_id in GlobalState.deck:
		var card_count = GlobalState.deck[card_id];
		for i in card_count:
			contents.append(CardDictionary.create_card(card_id));
