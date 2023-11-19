class_name TrunkData extends Resource

# key: card_id (str), value: Count (int)
@export var _contents := {}

func add(card_id : String) -> void:
	if not CardDictionary.is_valid(card_id):
		return
	if not _contents.has(card_id):
		_contents[card_id] = 1;
	else:
		_contents[card_id] += 1;

func remove(card_id : String) -> void:
	if not CardDictionary.is_valid(card_id):
		return
	var count : int = _contents.get(card_id);
	if count <= 0:
		return
	else:
		_contents[card_id] -= 1;

func get_all_cards_and_counts() -> Dictionary:
	return _contents;

func is_empty() -> bool:
	for card_id in _contents:
		if _contents[card_id] > 0:
			return false
	return true
