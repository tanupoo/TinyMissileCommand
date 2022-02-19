extends Node2D

func start(pos0):
    position = pos0

func _ready():
    $ExplosionFire.emitting = true
    $ExplosionSmoke.emitting = true

