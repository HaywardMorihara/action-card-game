class_name Player extends CharacterBody2D

#signal player_draw_card
#signal player_damage(amount : int)
#signal player_new_card(cardId : ActionCardGameGlobal.CardId)
#signal player_heal(amount : int)

@export var default_speed :float = 100.0

@onready var animation_player : AnimationPlayer = $AnimationPlayer as AnimationPlayer;

var speed : float

func _ready():
	speed = default_speed

func _physics_process(delta):
	velocity = _get_input_direction() * speed
	move_and_slide()
#	_animate()

func _process(delta: float) -> void:
	if velocity.is_zero_approx():
		animation_player.play("idle")
	else:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				animation_player.play("walk_right")
			else:
				animation_player.play("walk_left")
		else:
			if velocity.y > 0:
				animation_player.play("walk_down")
			else:
				animation_player.play("walk_up")	
	
func _get_input_direction() -> Vector2:
	# Auto-normalized
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")			

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
