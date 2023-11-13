class_name TreasureChestData extends Resource

@export var id_to_has_been_found := {}

func has_been_found(treasure_chest_id : String) -> bool:
	return id_to_has_been_found[treasure_chest_id];
	
func mark_as_found(treasure_chest_id : String) -> void:
	id_to_has_been_found[treasure_chest_id] = true
