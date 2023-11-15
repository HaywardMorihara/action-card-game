class_name CardCollection extends VBoxContainer

@onready var card_option_container : HFlowContainer = $ScrollContainer/HFlowContainer;

@onready var card_option_scene : Resource = preload("res://card_game/deck_editor/CardOption.tscn");

var card_id_to_card_option_node : Dictionary = {}

func _get_all_cards_and_counts() -> Dictionary:
	print("IMPLEMENT ME");
	return {}

func _get_collection_type() -> CardOption.Collection:
	print("IMPLEMENT ME")
	return -1

func _ready() -> void:
	_load_contents();

func _load_contents():
	var all_cards_and_counts : Dictionary = _get_all_cards_and_counts();
	for card_id in all_cards_and_counts:
		var card_option = _init_card_option(card_id, all_cards_and_counts[card_id]);
		card_option_container.add_child(card_option);

func _update_contents_for(card_id : String) -> void:
	var all_cards_and_counts : Dictionary = _get_all_cards_and_counts();
	var card_option_node : CardOption
	if card_id_to_card_option_node.has(card_id):
		card_option_node = card_id_to_card_option_node.get(card_id) as CardOption;
	else:
		card_option_node = _init_card_option(card_id, all_cards_and_counts[card_id]);
		card_option_container.add_child(card_option_node);
	card_option_node.update_count(all_cards_and_counts[card_id]);

func _init_card_option(card_id : String, count : int) -> CardOption:
	var card_option : CardOption = card_option_scene.instantiate() as CardOption;
	card_option.initialize_from(card_id, count, _get_collection_type());
	card_id_to_card_option_node[card_id] = card_option;
	card_option.update.connect(_update_contents_for);
	return card_option;

func _can_drop_data(_pos, data):
	return CardDictionary.is_valid(data);
	
