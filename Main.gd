extends Node

onready var enemy_missile_scene = preload("res://EnemyMissile.tscn")
onready var guard_missile_scene = preload("res://GuardMissile.tscn")
#var nb_enemy_missile = 6
#var enemy_first_pos = 40
#var enemy_dist = 40
var tab = [[6, 60, 60], [6, 60, 180], [6, 600, 60]]
var idx = 0
var enemy_missile_speed = 160
var battery_position = Vector2(640,660)
var guard_missile_speed = 240

func _ready() -> void:
    $EnemyMissileTimer.set_wait_time(1)
    $EnemyMissileTimer.start()

func _process(delta: float) -> void:
    var mouse_position = get_viewport().get_mouse_position()
    if Input.is_action_just_pressed("ui_point"):
        spwan_guard_missile(mouse_position)

func spwan_guard_missile(mouse_position):
    var new_scene = guard_missile_scene.instance()
    var screen_size = get_viewport().get_visible_rect().size
    new_scene.start(battery_position, mouse_position, guard_missile_speed)
    add_child(new_scene)
    
func spawn_enemy_missile(nb_enemy_missile, enemy_first_pos, enemy_dist):
    for i in range(nb_enemy_missile):
        var new_scene = enemy_missile_scene.instance()
        var screen_size = get_viewport().get_visible_rect().size
        new_scene.start(Vector2(enemy_first_pos + enemy_dist*i, 0), battery_position, enemy_missile_speed)
        add_child(new_scene)


func _on_EnemyMissileTimer_timeout() -> void:
    spawn_enemy_missile(tab[idx][0], tab[idx][1], tab[idx][2])
    idx += 1
    if tab.size() == idx:
        idx = 0
    $EnemyMissileTimer.set_wait_time(6)
    $EnemyMissileTimer.start()
