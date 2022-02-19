extends Node

onready var enemy_main_scene = preload("res://EnemyMain.tscn")
onready var guard_main_scene = preload("res://GuardMain.tscn")

var guard_main
var enemy_main
var battery_position = Vector2(640,600)
var guard_missile_speed = 280
var enemy_missile_speed = 120
var score

func _ready():
    $HUD.connect("start_game", self, "new_game")
    $HUD.connect("reset_game", self, "reset_game")
    
func new_game():
    #get_tree().call_group("mobs", "queue_free")
    score = 100
    $HUD.update_score(score)
    $HUD.show_message("Get Ready")
    yield(get_tree().create_timer(1), "timeout")
    $HUD.hide_message()
    start_guard_main()
    start_enemy_main()

func game_over():
    $HUD.show_message("Game Over")
    yield(get_tree().create_timer(2), "timeout")
    $HUD.show_reset_button()

func reset_game():
    get_tree().reload_current_scene()

func update_score(point: int):
    score += point
    $HUD.update_score(score)

func start_guard_main():
    guard_main = guard_main_scene.instance()
    add_child(guard_main)
    guard_main.start(guard_missile_speed, battery_position, self)
    guard_main.connect("game_over", self, "game_over")
    
func start_enemy_main():
    enemy_main = enemy_main_scene.instance()
    add_child(enemy_main)
    enemy_main.start(enemy_missile_speed, self)
