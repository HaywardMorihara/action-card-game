class_name CardOption extends PanelContainer

var card_id : String;
var card_name : String;
var count : int;
var card_image_path : String; 

const card_count_label_format : String = "(%s)"

@onready var card_image : TextureRect = $CardImage as TextureRect;
@onready var card_name_label : Label = $CardName as Label;
@onready var card_count_label : Label = $CardCount as Label;

func _ready() -> void:
	card_image.texture = load(card_image_path);
	card_name_label.text = card_name;
	card_count_label.text = card_count_label_format % count;

func initialize_from(card_id : String, count : int) -> void:
	self.card_id = card_id;
	self.count = count;
	self.card_image_path = CardDictionary.get_image_path_for_card(card_id);
	self.card_name = CardDictionary.get_card_name(card_id);

func _get_drag_data(_pos):
	var texture_rect = TextureRect.new();
	texture_rect.texture = card_image.texture;
	set_drag_preview(texture_rect);
	return card_id;

func _can_drop_data(_pos, data):
	return CardDictionary.is_valid(data);

func _drop_data(_pos, data):
	# TODO Visible counts in deck and trunk should change too
	# TODO Is there a better way to do this?
	# Here so that the card can appear droppable anywhere, pass it up the the parent
	print(data);
