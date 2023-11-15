class_name TrunkCollection extends CardCollection

func _get_all_cards_and_counts() -> Dictionary:
	return GlobalState.trunk_data.get_all_cards_and_counts();

func _get_collection_type() -> CardOption.Collection:
	return CardOption.Collection.TRUNK;

func _drop_data(_pos, data):
	GlobalState.trunk_data.add(data);
	_update_contents_for(data);
