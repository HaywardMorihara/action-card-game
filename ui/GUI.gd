extends CanvasLayer

# Placeholder, until I have a UI for this
const trunk_location : Vector2 = Vector2.ZERO;
const start_card_scale : float = 0.1;
const final_card_scale : float = 2.0;

func _ready() -> void:
	GlobalSignals.card_obtained.connect(_on_card_obtained);

func _on_card_obtained(card : Card) -> void:
	add_child(card);
	card.position = get_viewport().get_visible_rect().size / 2;
	card.disable_hover();
	card.scale = Vector2.ONE * start_card_scale;
	card.scale_to(final_card_scale);
	await get_tree().create_timer(2.0).timeout;
	card.scale_to(start_card_scale);
	card.move_to_global_pos(Vector2.ZERO);
	GlobalState.trunk_data.add(CardDictionary.get_card_id(card));
	card.queue_free();
