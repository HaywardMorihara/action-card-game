extends Node2D

@onready var world : Area = $Area as Area;

func _ready() -> void:
	# Card Effect Signals
	GlobalSignals.execute.connect(_on_execute_call_card_effect);
	
	# CardGame Signals
	GlobalSignals.hand_hovered_change.connect(_on_hand_hovered_change);
	
	# World Signals
	GlobalSignals.transition_to.connect(_on_area_transition);

# Card Effect Signals
# TODO Should this be refactored to use https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#awaiting-for-signals-or-coroutines
func _on_execute_call_card_effect(card_effect : Callable) -> void:
	card_effect.call(world);

# CardGame Signals
func _on_hand_hovered_change(is_hovered : bool) -> void:
	# NOTE: Right now, you can NOT pause subtrees. So CardGame is set to PROCESS_MODE.ALWAYS
	get_tree().paused = is_hovered;

# World Signals
func _on_area_transition(next_area_scene : Resource, player_starting_area_id : String) -> void:
	var next_area : Area = next_area_scene.instantiate();
	next_area.player_starting_area_id = player_starting_area_id;
	world.queue_free();
	add_child(next_area);
	world = next_area;
