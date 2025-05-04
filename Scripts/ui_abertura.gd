extends Control
#
#@onready var animation_intro = $AnimationPlayer
#
#
#func _ready():
#	$CameraAbertura.make_current()
#	animation_intro.play("Black_in")
#	get_tree().create_timer(3).timeout.connect(black_out)
# 
#
#func black_out():
#	animation_intro.play("Black_out")
#	get_tree().create_timer(3).timeout.connect(start_menu_scene)
# 
#
#func start_menu_scene():
#	SignalManeger.cam_tela.emit()
#
