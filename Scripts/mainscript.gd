extends Control

# Troca de câmera
func _ready():
	# Quando o sinal for recebido vai rodar uma função, que é para trocar a câmera
	SignalManeger.cam_tela.connect(func(): $"UI-Tela/CameraTela".make_current()) # Tela
	SignalManeger.cam_info.connect(func(): $"UI-Informacoes/CameraInfo".make_current()) # Informações
	SignalManeger.cam_arq.connect(func(): $"UI-Arquivos/CameraArquivos".make_current()) # Arquivos
	

	
	
