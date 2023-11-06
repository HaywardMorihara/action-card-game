class_name AreaTransitionEffects extends CanvasLayer

signal effect_finished

enum Effect { DIM_OUT, DIM_IN }

@onready var animation_player : AnimationPlayer = $AnimationPlayer as AnimationPlayer;

func play(effect : Effect) -> void:
	match (effect):
		Effect.DIM_OUT:
			animation_player.play("dim_out");
		Effect.DIM_IN:
			animation_player.play("dim_in");

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	effect_finished.emit();
