class_name DeckCollection extends CardCollection

@onready var card_option_container : HFlowContainer = $ScrollContainer/HFlowContainer;

func _load_contents():
	var all_cards_in_deck_and_counts : Dictionary = GlobalState.deck_data.get_all_cards(); 
	for card_id in all_cards_in_deck_and_counts:
		var card_option : CardOption = card_option_scene.instantiate() as CardOption;
		card_option.initialize_from(card_id, all_cards_in_deck_and_counts[card_id]);
		card_option_container.add_child(card_option);
