class_name CardDictionary extends Node

const _card_id_to_card_scene_path := {
	"fireball": "fireball/FireballCard.tscn",
}

const _cards_directory : String = "res://card_game/cards/";

static var _card_id_to_scene_cache : Dictionary = {};
static var _card_id_to_name_cache : Dictionary = {};
static var _card_id_to_image_path_cache : Dictionary = {};
static var _card_id_to_description_cache : Dictionary = {};

static func is_valid(card_id : String) -> bool:
	return _card_id_to_card_scene_path.has(card_id);

static func create_card(card_id : String) -> Card:
	var card_scene : Resource = _card_id_to_scene_cache.get(card_id);
	if not card_scene:
		var card_local_scene_path = _card_id_to_card_scene_path[card_id];
		if not card_local_scene_path:
			return null 
		card_scene = load("%s%s" % [_cards_directory, card_local_scene_path]);
		_card_id_to_scene_cache[card_id] = card_scene;
	var card_instance : Card = card_scene.instantiate();
	if not _card_id_to_name_cache.has(card_id):
		_card_id_to_name_cache[card_id] = card_instance.card_name;
	if not _card_id_to_image_path_cache.has(card_id):
		_card_id_to_image_path_cache[card_id] = card_instance.get_image_path();
	return card_instance;

static func get_card_id(card : Card) -> String:
	var scene_path := card.scene_file_path.replace(_cards_directory, "");
	for card_id in _card_id_to_card_scene_path:
		if _card_id_to_card_scene_path[card_id] == scene_path:
			return card_id
	return ""

static func get_card_name(card_id : String) -> String:
	var card_name = _card_id_to_name_cache.get(card_id);
	if not card_name:
		# is there a better way to get the name?
		var card_instance : Card = create_card(card_id) as Card;
		card_instance.queue_free();
		_card_id_to_name_cache[card_id] = card_instance.card_name;
		card_name = _card_id_to_name_cache[card_id];
	return card_name;

static func get_image_path_for_card(card_id : String) -> String:
	var card_image_path = _card_id_to_image_path_cache.get(card_id);
	if not card_image_path:
		# is there a better way to get the image path?
		var card_instance : Card = create_card(card_id) as Card;
		card_instance.queue_free();
		_card_id_to_image_path_cache[card_id] = card_instance.get_image_path(); 
		card_image_path = _card_id_to_image_path_cache[card_id];
	return card_image_path;

static func get_card_description(card_id : String) -> String:
	var card_description = _card_id_to_description_cache.get(card_id);
	if not card_description:
		# is there a better way to get the name?
		var card_instance : Card = create_card(card_id) as Card;
		card_instance.queue_free();
		_card_id_to_description_cache[card_id] = card_instance.card_description;
		card_description = _card_id_to_description_cache[card_id];
	return card_description;
