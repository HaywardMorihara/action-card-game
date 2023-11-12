class_name Player extends CharacterBody2D

#signal player_draw_card
#signal player_damage(amount : int)
#signal player_new_card(cardId : ActionCardGameGlobal.CardId)
#signal player_heal(amount : int)

@export var default_speed :float = 100.0

@onready var animation_player : AnimationPlayer = $AnimationPlayer as AnimationPlayer;
@onready var interactor : Area2D = $Interactor as Area2D;

var speed : float

func _ready():
	speed = default_speed;

func _physics_process(delta):	
	var direction : Vector2 = _get_input_direction();
	_point_interactor(direction);
	velocity = direction * speed;
	move_and_slide();
#	_animate()

func _process(delta: float) -> void:
	if velocity.is_zero_approx():
		if interactor.rotation_degrees == 0:
				animation_player.play("idle_down");
		if interactor.rotation_degrees == 90:
				animation_player.play("idle_left");
		if interactor.rotation_degrees == 180:
				animation_player.play("idle_up");
		if interactor.rotation_degrees == 270:
				animation_player.play("idle_right");
	else:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				animation_player.play("walk_right");
			else:
				animation_player.play("walk_left");
		else:
			if velocity.y > 0:
				animation_player.play("walk_down");
			else:
				animation_player.play("walk_up");

func _get_input_direction() -> Vector2:
	# Auto-normalized
	return Input.get_vector("move_left", "move_right", "move_up", "move_down");

func _point_interactor(direction : Vector2) -> void:
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			interactor.rotation_degrees = 270;
		else:
			interactor.rotation_degrees = 90;
	elif abs(direction.x) < abs(direction.y):
		if direction.y > 0:
			interactor.rotation_degrees = 0;
		else:
			interactor.rotation_degrees = 180;

#func _process(delta):
#	if $Label.visible:
#		$Label.text = str(round($SpeedBostTimer.time_left))

#func _on_speed_bost_timer_timeout():
#	speed = default_speed
#	$Label.visible = false

#func pickup(pickup):
#	if pickup.is_in_group("DrawPickup"):
#		player_draw_card.emit()
#	elif pickup.is_in_group("NewCardPickup"):
#		player_new_card.emit(pickup.cardId)
#	elif pickup.is_in_group("HealPickup"):
#		player_heal.emit(1)

#func damage(amount : int):
#	$EnemyContactSFX.play()
#	player_damage.emit(amount)
#	get_tree().paused = true
#	$HitFrameTimer.start()

#func change_speed(amount : float, time_limit = null):
#	speed += amount
#	if time_limit:
#		$Label.visible = true
#		$SpeedBostTimer.start(time_limit)
#	$SpeedBoostSFX.play()
#	if velocity != Vector2.ZERO:
#		$SpeedBoostParticles.direction = -velocity
#	else:
#		$SpeedBoostParticles.direction = Vector2(0,-1)
#	$SpeedBoostParticles.emitting = true
