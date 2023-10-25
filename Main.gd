extends Node2D

@onready var world : World = $World

func _ready():
	GlobalSignals.execute.connect(_on_execute_call_card_effect)
	
func _on_execute_call_card_effect(card_effect : Callable):
	card_effect.call(world)
