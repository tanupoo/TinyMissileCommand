extends Node

onready var enemy_missile_scene = preload("res://EnemyMissile.tscn")
var enemy_table = [
    [
    {"nb": 2, "x0":  60, "dist":  60, "tgt": 192},
    {"nb": 2, "x0": 360, "dist":  60, "tgt": 640},
    {"nb": 2, "x0": 660, "dist":  60, "tgt": 1088},
    ],
    [
    {"nb": 3, "x0":  60, "dist":  60, "tgt": 192},
    {"nb": 3, "x0": 360, "dist":  60, "tgt": 640},
    {"nb": 3, "x0": 660, "dist":  60, "tgt": 1088},
    ],
    [
    {"nb": 4, "x0":  60, "dist":  60, "tgt": 192},
    {"nb": 4, "x0":  60, "dist": 180, "tgt": 640},
    {"nb": 4, "x0": 600, "dist":  60, "tgt": 1088},
    ],
    [
    {"nb": 5, "x0":  60, "dist":  60, "tgt": 192},
    {"nb": 5, "x0":  60, "dist": 180, "tgt": 640},
    {"nb": 5, "x0": 600, "dist":  60, "tgt": 1088},
    ],
]
var enemy_idx
var enemy_missile_speed
var main

func start(speed: float, cb):
    enemy_missile_speed = speed
    enemy_idx = 0
    main = cb

func _ready():
    yield(get_tree().create_timer(1), "timeout")
    spawn_enemy_missile(enemy_table[enemy_idx])
    var enemy_timer = Timer.new()
    add_child(enemy_timer)
    enemy_timer.set_wait_time(4)
    enemy_timer.connect("timeout", self, "spawning")
    enemy_timer.start()
    
    
func spawn_enemy_missile(tab):
    for v in tab:
        for i in range(v["nb"]):
            var new_scene = enemy_missile_scene.instance()
            new_scene.start(Vector2(v["x0"] + v["dist"]*i, 0), Vector2(v["tgt"], 600), enemy_missile_speed, main)
            add_child(new_scene)
            yield(get_tree().create_timer(0.5), "timeout")


func spawning():
    enemy_idx += 1
    if enemy_table.size() == enemy_idx:
        enemy_idx = 0
    enemy_missile_speed += 20
    spawn_enemy_missile(enemy_table[enemy_idx])

