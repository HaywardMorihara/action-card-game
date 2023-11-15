class_name DeckCollection extends CardCollection

func _get_all_cards_and_counts() -> Dictionary:
	return GlobalState.deck_data.get_all_cards();

func _get_collection_type() -> CardOption.Collection:
	return CardOption.Collection.DECK;

func _drop_data(_pos, data):
	GlobalState.deck_data.add(data);
	_update_contents_for(data);
