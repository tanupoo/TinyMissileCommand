extends Node2D

func start(pos0):
    position = pos0

func _ready():
    $CPUParticles2D.emitting = true
    yield(get_tree().create_timer(2), "timeout")
    queue_free()
