extends Node2D

func start(pos0):
    position = pos0
    print("ready ", pos0)

func _ready():
    # _ready()になっていない可能性がある？
    $ExplosionFire.emitting = true
    $ExplosionSmoke.emitting = true
    #yield(get_tree().create_timer(2), "timeout")
    #print("finished")
    #queue_free()

