class_name DeckData extends Resource

# key: CardId (str), value: Count (int)
@export var _contents := {}

func add(cardId : String) -> void:
	if not CardDictionary.is_valid(cardId):
		return
	if not _contents.has(cardId):
		_contents[cardId] = 1;
	else:
		_contents[cardId] += 1;

func remove(card_id : String) -> void:
	if not CardDictionary.is_valid(card_id):
		return
	var count : int = _contents.get(card_id);
	if count <= 0:
		return
	else:
		_contents[card_id] -= 1;

func get_all_cards() -> Dictionary:
	return _contents
