class_name CardDictionary extends Node

const card_id_to_card_scene_path := {
	"fireball": "fireball/FireballCard.tscn",
}

const cards_directory : String = "res://card_game/cards";

static var card_scene_path_to_scene_cache : Dictionary = {}

static func create_card(card_id : String) -> Card:
	var card_scene_path : String = card_id_to_card_scene_path[card_id];
	var card_scene : Resource = card_scene_path_to_scene_cache.get(card_scene_path);
	if not card_scene:
		card_scene = load("%s/%s" % [cards_directory, card_scene_path]);
		card_scene_path_to_scene_cache[card_scene_path] = card_scene;
	return card_scene.instantiate();
