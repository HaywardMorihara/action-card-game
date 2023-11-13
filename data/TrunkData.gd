class_name TrunkData extends Resource

# key: CardId (str), value: Count (int)
@export var contents := {}

func add(cardId : String) -> void:
	if not CardDictionary.is_valid(cardId):
		return
	if not contents.has(cardId):
		contents[cardId] = 1;
	else:
		contents[cardId] += 1;
