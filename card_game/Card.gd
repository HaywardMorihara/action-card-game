class_name Card extends Node2D

signal animation_finished

@export var animation_move_speed : float = 1.0
@export_file("*.gd") var effect_filepath : String

@onready var effect : CardEffect = load(effect_filepath).new();

func play():
	GlobalSignals.execute.emit(effect.execute)

func get_effect_description() -> String:
	return effect.get_description();

func move_to(pos : Vector2) -> Signal:
	var tween : Tween = create_tween();
	tween.tween_property(self, "position", pos, animation_move_speed);
	tween.tween_callback(_finished_animation);
	return animation_finished;

func _finished_animation():
	animation_finished.emit();
