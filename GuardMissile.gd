extends Area2D

onready var explosion_scene = preload("res://GuardExplosion.tscn")

var velocity = Vector2.ZERO
var missile_sprite_dir = Vector2(0,-1)
var target = Vector2()

func start(pos0, pos1, speed):
    var dir = pos0.direction_to(pos1)
    gravity *= 0
    position = pos0
    rotation = missile_sprite_dir.angle_to(dir)
    velocity = dir*speed
    target = pos1
    $AnimatedSprite.play("fire")
    
func _physics_process(delta: float) -> void:
    velocity.y += gravity * delta * delta / 2

func _process(delta: float) -> void:
    if position.distance_to(target) < 10:
        velocity = Vector2.ZERO
        var new_scene = explosion_scene.instance()
        get_parent().add_child(new_scene)
        new_scene.start(position, 1.8)
        queue_free()
    else:
        position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
    print("screen exited G")
    queue_free()

func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
    print("viewport exited G")
    queue_free()
