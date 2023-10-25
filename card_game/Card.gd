class_name Card extends Node2D

signal animation_finished

@export var animation_move_speed : float = 1.0

@onready var effect : CardEffect = $CardEffect

func play():
	GlobalSignals.execute.emit(effect.execute)

func move_to(pos : Vector2) -> Signal:
	var tween : Tween = create_tween();
	tween.tween_property(self, "position", pos, animation_move_speed);
	tween.tween_callback(_finished_animation);
	return animation_finished;

func _finished_animation():
	animation_finished.emit();
