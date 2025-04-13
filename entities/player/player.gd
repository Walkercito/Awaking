extends CharacterBody2D

@export var speed: float = 190.0
@export var acceleration: float = 8.0
@onready var _animated_sprite: AnimatedSprite2D = $Texture

var _move_direction := Vector2.ZERO
var _target_velocity := Vector2.ZERO


func _process(_delta: float) -> void:
	_move_direction = Vector2.ZERO

	if Input.is_action_pressed("right-D"):
		_move_direction.x += 1
	if Input.is_action_pressed("left-A"):
		_move_direction.x -= 1
	if Input.is_action_pressed("down-S"):
		_move_direction.y += 1
	if Input.is_action_pressed("up-W"):
		_move_direction.y -= 1

	_move_direction = _move_direction.normalized()

	var desired_velocity = _move_direction * speed

	if _move_direction != Vector2.ZERO:
		_target_velocity = _target_velocity.lerp(desired_velocity, acceleration * _delta)
	else:
		_target_velocity = Vector2.ZERO

	velocity = _target_velocity
	move_and_slide()
	_update_animation()


func _update_animation() -> void:
	if _move_direction != Vector2.ZERO:
		_animated_sprite.play("walking")
		_animated_sprite.flip_h = _move_direction.x < -0.1
	else:
		_animated_sprite.play("idle")
