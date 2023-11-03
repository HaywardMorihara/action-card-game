class_name World extends Node2D

@onready var player : Player = $Player

func _ready() -> void:
	GlobalSignals.hand_hovered_change.connect(_on_hand_hovered_change);

func _on_hand_hovered_change(is_hovered : bool) -> void:
	# NOTE: Right now, you can NOT pause subtrees. So CardGame is set to PROCESS_MODE.ALWAYS
	get_tree().paused = is_hovered;
