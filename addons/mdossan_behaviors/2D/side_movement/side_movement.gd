class_name SideMovement extends Node2D

@export var target_body: CharacterBody2D
@export var speed: float = 30_000;

func apply_movement(delta: float) -> void:
	var input_direction: float = Input.get_axis("left", "right")
	target_body.velocity.x = input_direction * speed * delta
