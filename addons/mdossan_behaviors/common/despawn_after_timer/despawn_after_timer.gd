class_name DespawnAfterTimer extends Node

@export var target: Node
@export var despawn_delay: float = 1.0

func _ready() -> void:
	%Timer.wait_time = despawn_delay

func despawn():
	%Timer.start()

func _on_timer_timeout() -> void:
	if target:
		target.call_deferred("queue_free")
