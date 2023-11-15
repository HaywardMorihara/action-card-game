class_name CardOption extends PanelContainer

signal update(card_id : String)

enum Collection {
	TRUNK,
	DECK
}

var card_id : String;
var card_name : String;
var count : int;
var card_image_path : String; 
var collection : Collection;

const card_count_label_format : String = "(%s)"

@onready var card_image : TextureRect = $CardImage as TextureRect;
@onready var card_name_label : Label = $CardName as Label;
@onready var card_count_label : Label = $CardCount as Label;

func _ready() -> void:
	card_image.texture = load(card_image_path);
	card_name_label.text = card_name;
	card_count_label.text = card_count_label_format % count;

func initialize_from(card_id : String, count : int, collection : Collection) -> void:
	self.card_id = card_id;
	self.count = count;
	self.card_image_path = CardDictionary.get_image_path_for_card(card_id);
	self.card_name = CardDictionary.get_card_name(card_id);
	self.collection = collection;

func update_count(new_count : int) -> void:
	count = new_count;
	card_count_label.text = card_count_label_format % count;

func _get_drag_data(_pos):
	match collection:
		Collection.TRUNK:
			GlobalState.trunk_data.remove(card_id);
		Collection.DECK:
			GlobalState.deck_data.remove(card_id);
	var texture_rect = TextureRect.new();
	texture_rect.texture = card_image.texture;
	set_drag_preview(texture_rect);
	# TODO If the count is now down to zero...
#	queue_free();
	update.emit(card_id);
	return card_id;

func _can_drop_data(_pos, data):
	return CardDictionary.is_valid(data);

func _drop_data(_pos, data):
	# TODO Is there a better way to do this?
	# Here so that the card can appear droppable anywhere, pass it up the the parent
	match collection:
		Collection.TRUNK:
			GlobalState.trunk_data.add(card_id);
		Collection.DECK:
			GlobalState.deck_data.add(card_id);
	update.emit(card_id);
