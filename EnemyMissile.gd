extends Area2D

onready var base_explosion_scene = preload("res://BaseExplosion.tscn")
onready var enemy_explosion_scene = preload("res://EnemyExplosion.tscn")

var velocity = Vector2.ZERO
var missile_sprite_dir = Vector2(0,-1)
var main

func start(pos0, pos1, speed, cb):
    main = cb
    var dir = pos0.direction_to(pos1)
    gravity *= 0
    position = pos0
    rotation = missile_sprite_dir.angle_to(dir)
    velocity = dir*speed
    #$SoundFire.play()

func _physics_process(delta: float) -> void:
    velocity.y += gravity * delta * delta / 2

func _process(delta: float) -> void:
    position += velocity * delta

func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
    queue_free()

func _on_EnemyMissle_area_entered(area: Area2D) -> void:
    velocity = Vector2.ZERO
    var new_scene
    if area.name in ["BaseStationL", "BaseStationR", "Battery"]:
        main.update_durability(-250)
        new_scene = base_explosion_scene.instance()
    #elif area.name == "GuardExplosion":
    elif area.is_in_group("guard_explosion"):
        main.update_durability(100)
        new_scene = enemy_explosion_scene.instance()
    else:
        assert(1 == 0, "area.name: %s"%area.name)
    #
    get_parent().add_child(new_scene)
    new_scene.start(position)
    queue_free()
