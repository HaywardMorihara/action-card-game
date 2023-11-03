class_name DrawPickup extends Pickup

func can_be_picked_up() -> bool:
	return len(GlobalGets.get_deck_conents()) > 0

func picked_up() -> void:
	GlobalSignals.draw_cards.emit(1);
