extends Control

func _ready():
	$HSlider.value = 400

func _process(_delta):
	var valor = $HSlider.value
	var labelrate = $Rate
	labelrate.text = str(valor)
