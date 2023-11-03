extends Node

var func_get_deck_contents : Callable
func get_deck_conents() -> Array[Card]:
	if not func_get_deck_contents:
		return []
	return func_get_deck_contents.call()
