class_name DrawPickup extends Pickup

func picked_up() -> void:
	GlobalSignals.draw_cards.emit(1);
