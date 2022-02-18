extends Node

onready var enemy_main_scene = preload("res://EnemyMain.tscn")
onready var guard_main_scene = preload("res://GuardMain.tscn")

var battery_position = Vector2(640,600)
var guard_missile_speed = 280
var enemy_missile_speed = 160
var score

func _ready():
    $HUD.connect("start_game", self, "new_game")

func new_game():
    #get_tree().call_group("mobs", "queue_free")
    score = 100
    $HUD.update_score(score)
    $HUD.show_message("Get Ready")
    start_guard_main()
    start_enemy_main()
    #$Music.play()

func game_over():
    $HUD.show_message("Game Over", 2)
    yield(get_tree().create_timer(2), "timeout")
    $HUD.show_message("Tiny Missile Command")
    $HUD.show_button()

func update_score(point: int):
    score += point
    $HUD.update_score(score)

func start_guard_main():
    var guard_main = guard_main_scene.instance()
    add_child(guard_main)
    guard_main.start(guard_missile_speed, battery_position, self)
    guard_main.connect("game_over", self, "game_over")
    
func start_enemy_main():
    var new_scene = enemy_main_scene.instance()
    add_child(new_scene)
    new_scene.start(enemy_missile_speed, self)
