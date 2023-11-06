extends Node2D

@onready var world : Area = $Area as Area;
@onready var card_game : CardGame = %CardGame as CardGame;
@onready var area_transition_effects : AreaTransitionEffects = $AreaTransitionEffects as AreaTransitionEffects;

@export var card_game_transition_speed : float = 0.1;

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
	var tween : Tween = create_tween() as Tween;
	tween.tween_property(card_game, "position", Vector2(card_game.position.x, card_game.position.y + get_viewport_rect().size.y/2), card_game_transition_speed);
	get_tree().paused = true;
	area_transition_effects.play(AreaTransitionEffects.Effect.DIM_OUT);
	
	var next_area : Area = next_area_scene.instantiate();
	next_area.player_starting_area_id = player_starting_area_id;
	
	await area_transition_effects.effect_finished
	
	world.queue_free();
	add_child(next_area);
	world = next_area;
	
	area_transition_effects.play(AreaTransitionEffects.Effect.DIM_IN);
	get_tree().paused = false;
	
	await area_transition_effects.effect_finished;
	
	tween  = create_tween() as Tween;
	tween.tween_property(card_game, "position", Vector2(card_game.position.x, card_game.position.y - get_viewport_rect().size.y/2), card_game_transition_speed);
