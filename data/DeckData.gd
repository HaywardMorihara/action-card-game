class_name DeckData extends Resource

# key: CardId (str), value: Count (int)
@export var _contents := {}
@export var _total_count := -1

func add(cardId : String) -> void:
	if not CardDictionary.is_valid(cardId):
		return
	if not _contents.has(cardId):
		_contents[cardId] = 1;
	else:
		_contents[cardId] += 1;
	_total_count += 1;

func remove(card_id : String) -> void:
	if not CardDictionary.is_valid(card_id):
		return
	var count : int = _contents.get(card_id);
	if count <= 0:
		return
	else:
		_contents[card_id] -= 1;
	_total_count -= 1;

func get_all_cards() -> Dictionary:
	return _contents

func is_empty() -> bool:
	for card_id in _contents:
		if _contents[card_id] > 0:
			return false
	return true

func get_total_count() -> int:
	if _total_count == -1:
		_init_total_count()
	return _total_count

func _init_total_count() -> void:
	_total_count = 0
	for card_id in _contents:
		_total_count += _contents[card_id]
