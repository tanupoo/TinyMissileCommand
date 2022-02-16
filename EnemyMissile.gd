extends Area2D

onready var explosion_scene = preload("res://Explosion.tscn")

var velocity = Vector2.ZERO
var missile_sprite_dir = Vector2(0,-1)

func start(pos0, pos1, speed):
    var dir = pos0.direction_to(pos1)
    gravity *= 0
    position = pos0
    rotation = missile_sprite_dir.angle_to(dir)
    velocity = dir*speed

func _physics_process(delta: float) -> void:
    velocity.y += gravity * delta * delta / 2

func _process(delta: float) -> void:
    position += velocity * delta

func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
    queue_free()

func _on_EnemyMissle_area_entered(area: Area2D) -> void:
    velocity = Vector2.ZERO
    var new_scene = explosion_scene.instance()
    new_scene.start(position, 1.5)
    get_parent().add_child(new_scene)
    queue_free()
