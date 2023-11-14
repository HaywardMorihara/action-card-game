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

func get_all_cards() -> Dictionary:
	return _contents
