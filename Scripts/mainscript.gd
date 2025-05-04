extends Control
# Troca de câmera
func _ready():

	# Quando o sinal for recebido vai rodar uma função, que é para trocar a câmera
	SignalManeger.cam_tela.connect(func(): $"UI-Tela/CameraTela".make_current()) # Tela
	SignalManeger.cam_info.connect(func(): $"UI-Informacoes/CameraInfo".make_current()) # Informações
	SignalManeger.cam_arq.connect(func(): $"UI-Arquivos/CameraArquivos".make_current()) # Arquivos
	var icon = preload("res://icon_100.png").get_image()
	if icon:
		DisplayServer.set_icon(icon)
	
#region Declaraçoes
# Tipo de câmera abilitada
var curscene = "tela"
# Fullscreen Frame
var change = false

# Fullscreens
@onready var fulinfo = get_node("UI-Informacoes/cabeca/Panel/HBoxContainer/HBoxContainer3/FullscreenSetting")
@onready var fultela = get_node("UI-Tela/cabeca/Panel/HBoxContainer/HBoxContainer3/FullscreenSetting")
@onready var fularq = get_node("UI-Arquivos/cabeca/Panel/HBoxContainer/HBoxContainer3/FullscreenSetting")
# Exits
@onready var xtela = $"UI-Tela/cabeca/Panel/HBoxContainer/HBoxContainer3/X"
@onready var xinfo = $"UI-Informacoes/cabeca/Panel/HBoxContainer/HBoxContainer3/X"
@onready var xarq = $"UI-Arquivos/cabeca/Panel/HBoxContainer/HBoxContainer3/X"
# Botões de troca de câmera
@onready var Barqtel = $"UI-Tela/cabeca/Panel/HBoxContainer/HBoxContainer3/tela-arquivos"
@onready var Barqinfo = $"UI-Informacoes/cabeca/Panel/HBoxContainer/HBoxContainer3/informacoes-arquivos"
@onready var Binfotel = $"UI-Tela/cabeca/Panel/HBoxContainer/HBoxContainer3/tela-informacoes"
@onready var Binfoarq = $"UI-Arquivos/cabeca/Panel/HBoxContainer/HBoxContainer3/arquivos-informacao"
@onready var Btelinfo = $"UI-Informacoes/cabeca/Panel/HBoxContainer/HBoxContainer3/informacao-tela"
@onready var Btelarq = $"UI-Arquivos/cabeca/Panel/HBoxContainer/HBoxContainer3/arquivo-tela"
# Botões WASD
@onready var bW = $"UI-Tela/ControlW"
@onready var bA = $"UI-Tela/ControlA"
@onready var bS = $"UI-Tela/ControlS"
@onready var bD = $"UI-Tela/ControlD"

#endregion

#region Process
func _process(_delta):
	# Tela - Rate
	var valor = $"UI-Tela/RateSlider".value
	var labelrate = $"UI-Tela/Rate"
	labelrate.text = "Rate : " + str(valor)
	
	# Botões
	# X (fechar)
	if xtela.button_pressed or xinfo.button_pressed or xarq.button_pressed:
		get_tree().quit()
	
	# Tecla W
	if Input.is_key_pressed(KEY_W): set_panel_style_box(bW,3,"99999933")
	else: set_panel_style_box(bW,3,"1a1a1a99")
	# Tecla A
	if Input.is_key_pressed(KEY_A): set_panel_style_box(bA,3,"99999933")
	else: set_panel_style_box(bA,3,"1a1a1a99")
	# Tecla S
	if Input.is_key_pressed(KEY_S): set_panel_style_box(bS,3,"99999933")
	else: set_panel_style_box(bS,3,"1a1a1a99")
	# Tecla D
	if Input.is_key_pressed(KEY_D): set_panel_style_box(bD,3,"99999933")
	else: set_panel_style_box(bD,3,"1a1a1a99")
	
	
	# Arquivos
	if Barqtel.button_pressed or Barqinfo.button_pressed: SignalManeger.cam_arq.emit()
	# Informaçoes
	if Binfotel.button_pressed or Binfoarq.button_pressed: SignalManeger.cam_info.emit()
	# Tela
	if Btelinfo.button_pressed or Btelarq.button_pressed: SignalManeger.cam_tela.emit()
	
	# Fullscreen
	SignalManeger.cam_tela.connect(func(): curscene = "tela") # Tela
	SignalManeger.cam_info.connect(func(): curscene = "info") # Informações
	SignalManeger.cam_arq.connect(func(): curscene = "arq") # Arquivos
	
	# Fullscreen da tela
	if $"UI-Tela/cabeca/Panel/HBoxContainer/HBoxContainer3/FullscreenSetting".button_pressed:
		if change == true:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			change = false
		if curscene == "tela":
			fulinfo.button_pressed = true
			fularq.button_pressed = true
	else:
		if change == false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			change = true
		if curscene == "tela":
			fulinfo.button_pressed = false
			fularq.button_pressed = false

	# Fullscreen da Informações
	if $"UI-Informacoes/cabeca/Panel/HBoxContainer/HBoxContainer3/FullscreenSetting".button_pressed:
		if curscene == "info":
			fultela.button_pressed = true
			fularq.button_pressed = true
	else:
		if curscene == "info":
			fultela.button_pressed = false
			fularq.button_pressed = false
	
	# Fullscreen dos Arquivos
	if $"UI-Arquivos/cabeca/Panel/HBoxContainer/HBoxContainer3/FullscreenSetting".button_pressed:
		if curscene == "arq":
			fultela.button_pressed = true
			fulinfo.button_pressed = true
	else:
		if curscene == "arq":
			fultela.button_pressed = false
			fulinfo.button_pressed = false
#endregion

#region Funções Próprias
func set_panel_style_box(panel, corner_radius : int, color : String):
	# Criar um stylebox
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = Color(color)  # Cor de fundo
	stylebox.set_corner_radius_all(corner_radius)    # Cantos arredondados (3px)
	
	# Criando o tema e aplicando o stylebox
	var t = Theme.new()
	t.set_stylebox("panel", "Panel", stylebox)
	panel.theme = t

#endregion
