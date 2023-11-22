class_name DrawPickup extends Pickup

func can_be_picked_up() -> bool:
	return GlobalAccess.card_game.can_draw();

func picked_up() -> void:
	GlobalSignals.draw_cards.emit(1);
