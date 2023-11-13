class_name CardDictionary extends Node

const card_id_to_card_scene_path := {
	"fireball": "fireball/FireballCard.tscn",
}

const cards_directory : String = "res://card_game/cards/";

static var card_scene_path_to_scene_cache : Dictionary = {}

static func is_valid(card_id : String) -> bool:
	return card_id_to_card_scene_path.has(card_id);

static func create_card(card_id : String) -> Card:
	var card_scene_path : String = card_id_to_card_scene_path[card_id];
	var card_scene : Resource = card_scene_path_to_scene_cache.get(card_scene_path);
	if not card_scene:
		card_scene = load("%s%s" % [cards_directory, card_scene_path]);
		card_scene_path_to_scene_cache[card_scene_path] = card_scene;
	return card_scene.instantiate();

static func get_card_id(card : Card) -> String:
	var scene_path := card.scene_file_path.replace(cards_directory, "");
	for card_id in card_id_to_card_scene_path:
		if card_id_to_card_scene_path[card_id] == scene_path:
			return card_id
	return ""
