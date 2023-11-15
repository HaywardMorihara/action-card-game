extends Control

@onready var transition_effects : TransitionEffects = $TransitionEffects as TransitionEffects;

func  _ready() -> void:
	transition_effects.visible = true;
	transition_effects.play(TransitionEffects.Effect.DIM_IN);
	await transition_effects.effect_finished;
	transition_effects.visible = false;
	
func _on_done_button_pressed() -> void:
	# TODO Determine which Area to return to
	transition_effects.visible = true;
	transition_effects.play(TransitionEffects.Effect.DIM_OUT);
	await transition_effects.effect_finished;
	get_tree().change_scene_to_file("res://Main.tscn");
