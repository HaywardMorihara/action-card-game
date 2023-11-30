class_name Deck extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var top_card : Sprite2D = $TopCard
@onready var middle_card : Sprite2D = $MiddleCard
@onready var bottom_card : Sprite2D = $BottomCard

var contents : Array[Card];

func _ready() -> void:
	_load_deck_contents();
	shuffle();

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

func remove(card : Card) -> Card:
	for i in len(contents):
		if contents[i] == card:
			contents.remove_at(i);
			return card;
	return null

func add_to_top(card : Card):
	contents.push_front(card);

func add_to_bottom(card : Card):
	contents.append(card);

func _load_deck_contents():
	var all_cards_in_deck_with_counts = GlobalState.deck_data.get_all_cards();
	for card_id in all_cards_in_deck_with_counts:
		var card_count = all_cards_in_deck_with_counts[card_id];
		for i in card_count:
			contents.append(CardDictionary.create_card(card_id));
