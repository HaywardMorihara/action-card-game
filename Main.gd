extends Node2D

@onready var world : Area = $Area as Area;
@onready var card_game : CardGame = %CardGame as CardGame;
@onready var area_transition_effects : AreaTransitionEffects = $AreaTransitionEffects as AreaTransitionEffects;
@onready var pause_menu : Control = %PauseMenu as Control;

@export var card_game_transition_speed : float = 0.1;

# You can either
# 1. Pause the World (e.g. the Player's hand is up)
# 2. Disable the CardGame (e.g. when the Player is aiming)
# and you can do both (e.g. when the game is paused)
# Having to do a "stack" because different sources might pause the World / disable the hand 
# (e.g. the Player looking at their hand will pause the World, and so will the menu, but the World
# shouldn't resume until both have returned)
var world_pause_count := 0;

func _ready() -> void:
	# Card Effect Signals
	GlobalSignals.execute.connect(_on_execute_call_card_effect);
	
	# CardGame Signals
	GlobalSignals.hand_hovered_change.connect(_on_hand_hovered_change);
	
	# World Signals
	GlobalSignals.transition_to.connect(_on_area_transition);

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel"):
		if world_pause_count <= 0:
			pause_game();
		else:
			resume_game();

func _on_pause_menu_resume() -> void:
	resume_game();

func pause_game():
	GlobalSignals.disable_hand.emit();
	pause_world();
	pause_menu.show();

func resume_game():
	GlobalSignals.enable_hand.emit();
	resume_world();
	pause_menu.hide();

func pause_world():
	world_pause_count += 1;
	get_tree().paused = true;
	
func resume_world():
	world_pause_count -= 1;
	if world_pause_count == 0:
		get_tree().paused = false;

# Card Effect Signals
# TODO Should this be refactored to use https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#awaiting-for-signals-or-coroutines
func _on_execute_call_card_effect(card_effect : Callable) -> void:
	card_effect.call(world);

# CardGame Signals
func _on_hand_hovered_change(is_hovered : bool) -> void:
	# NOTE: Right now, you can NOT pause subtrees. So CardGame is set to PROCESS_MODE.ALWAYS
	if is_hovered:
		pause_world();
	if not is_hovered:
		resume_world();

# World Signals
func _on_area_transition(next_area_scene : Resource, player_starting_area_id : String) -> void:
	GlobalSignals.disable_hand.emit();
	pause_world();
	
	var tween : Tween = create_tween() as Tween;
	tween.tween_property(card_game, "position", Vector2(card_game.position.x, card_game.position.y + get_viewport_rect().size.y/2), card_game_transition_speed);
	
	area_transition_effects.visible = true;
	area_transition_effects.play(AreaTransitionEffects.Effect.DIM_OUT);
	
	var next_area : Area = next_area_scene.instantiate();
	next_area.player_starting_area_id = player_starting_area_id;
	
	await area_transition_effects.effect_finished
	
	world.queue_free();
	add_child(next_area);
	world = next_area;
	
	area_transition_effects.play(AreaTransitionEffects.Effect.DIM_IN);
	
	GlobalSignals.enable_hand.emit();
	resume_world();
	
	await area_transition_effects.effect_finished;
	area_transition_effects.visible = false;
	
	tween  = create_tween() as Tween;
	tween.tween_property(card_game, "position", Vector2(card_game.position.x, card_game.position.y - get_viewport_rect().size.y/2), card_game_transition_speed);
