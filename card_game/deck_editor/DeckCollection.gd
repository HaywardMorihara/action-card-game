class_name DeckCollection extends CardCollection

const count_lebel_format : String = "(%s)";

@onready var count_label : Label = %CountLabel as Label;

func _process(delta: float) -> void:
	var deck_total_count := GlobalState.deck_data.get_total_count()
	count_label.text = count_lebel_format % deck_total_count;

func _get_all_cards_and_counts() -> Dictionary:
	return GlobalState.deck_data.get_all_cards();

func _get_collection_type() -> CardOption.Collection:
	return CardOption.Collection.DECK;

func _drop_data(_pos, data):
	GlobalState.deck_data.add(data);
	_update_contents_for(data);
