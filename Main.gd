extends Node2D

@onready var world : World = $World

func _ready():
	GlobalSignals.execute.connect(_on_execute_call_card_effect);

# TODO Should this be refactored to use https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#awaiting-for-signals-or-coroutines
func _on_execute_call_card_effect(card_effect : Callable):
	card_effect.call(world);
