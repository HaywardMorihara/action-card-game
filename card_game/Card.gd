class_name Card extends Node2D

@export_file("*.gd") var effect_filepath : String

var animation_move_speed : float = 0.1

@onready var effect : CardEffect = load(effect_filepath).new();

func play():
	GlobalSignals.execute.emit(effect.execute)

func get_effect_description() -> String:
	return effect.get_description();

func move_to(target : Vector2, callback : Callable):
	var tween : Tween = create_tween();
	tween.tween_property(self, "global_position", target, animation_move_speed);
	tween.tween_callback(callback);
