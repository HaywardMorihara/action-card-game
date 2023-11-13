extends Interactive

# For saving data, expected to be of the format "<AREA>_<CARD_ID>_<INCREMENT>"
# e.g. DEMO_AREA_FIREBALL_0 
@export var id : String;
@export var card_id : String;

const opened_frame : int = 2;

@onready var sprite : Sprite2D = $Sprite2D as Sprite2D;
@onready var animation_player : AnimationPlayer = $AnimationPlayer as AnimationPlayer;
@onready var open_button : Button = $OpenButton as Button;

var has_been_opened : bool = false;

func _ready() -> void:
	assert(id != null, "ID must be provided!");
	has_been_opened = GlobalState.treasure_chest_data.has_been_found(id);
	if has_been_opened:
		sprite.frame = opened_frame;

func _interaction() -> void:
	if not has_been_opened:
		open_button.show();

func _exit_interaction() -> void:
	open_button.hide();

func _on_button_pressed() -> void:
	has_been_opened = true;
	GlobalState.treasure_chest_data.mark_as_found(id);
	open_button.hide();
	animation_player.play("opening");
	await animation_player.animation_finished
	var card : Card = CardDictionary.create_card(card_id);
	GlobalSignals.card_obtained.emit(card);
