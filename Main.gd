extends Node

onready var enemy_main_scene = preload("res://EnemyMain.tscn")
onready var guard_main_scene = preload("res://GuardMain.tscn")

var guard_main
var enemy_main
var guard_missile_speed = 340
var enemy_missile_speed = 120
var initial_durability = 100
var elapsed
var durability
var in_game

func _ready():
    $HUD.connect("start_game", self, "new_game")
    $HUD.connect("reset_game", self, "reset_game")

func _process(delta):
    if in_game:
        elapsed += delta
        $HUD.update_elapsed(elapsed)

func new_game():
    #get_tree().call_group("mobs", "queue_free")
    in_game = true
    elapsed = 0.0
    durability = 0
    $HUD.update_elapsed(elapsed)
    update_durability(initial_durability)
    $HUD.show_message("Get Ready")
    yield(get_tree().create_timer(1), "timeout")
    $HUD.hide_message()
    start_guard_main()
    start_enemy_main()

func game_over():
    in_game = false
    guard_main.queue_free()
    $HUD.show_message("Game Over")
    yield(get_tree().create_timer(2), "timeout")
    $HUD.show_reset_button()

func reset_game():
    get_tree().reload_current_scene()

func update_durability(point: int):
    if not in_game:
        return
    durability += point
    $HUD.update_durability(durability)

func start_guard_main():
    guard_main = guard_main_scene.instance()
    add_child(guard_main)
    guard_main.start(guard_missile_speed, self)
    guard_main.connect("game_over", self, "game_over")

func start_enemy_main():
    enemy_main = enemy_main_scene.instance()
    add_child(enemy_main)
    enemy_main.start(enemy_missile_speed, self)
