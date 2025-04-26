import tkinter as tk
from queue import PriorityQueue

# Parâmetros da matriz
linhas, colunas = 21, 21
cell_size = 30

inicial_num = 181
destino_num = 141

celulas_azuis_numeros = [13, 16, 17, 18, 22, 23, 25, 26, 28, 30, 31, 32, 34, 41, 43, 47, 49, 53, 55, 56, 57, 58, 60, 62,
                         64, 66, 67, 68, 72, 73, 74, 76, 81, 83, 85, 89, 91, 102, 104, 106, 107, 108, 112, 114, 116, 118, 119,
                         120, 121, 123, 139, 148, 150, 152, 153, 154, 156, 157, 158, 162, 163, 165, 166, 167, 169, 170, 171, 173,
                         174, 175, 177, 178, 179, 183, 184, 186, 187, 188, 204, 205, 211, 213, 215, 217, 218, 219, 220, 221, 224,
                         227, 229, 230, 231, 232, 234, 236, 238, 239, 240, 242, 245, 248, 252, 253, 255, 256, 257, 259, 260, 261,
                         263, 266, 269, 271, 273, 281, 284, 287, 290, 292, 294, 296, 302, 305, 308, 311, 313, 315, 338, 340, 341,
                         342, 344, 345, 346, 347, 348, 349, 350, 351, 352, 354, 355, 356, 357, 362, 380, 381, 382, 383, 386, 387,
                         389, 390, 391, 394, 395, 397, 398, 407, 410, 412, 415, 416, 418, 419, 423, 424, 425, 426, 428, 433, 317,
                         323, 326, 329, 336]

# Converte número para coordenada
def numero_para_coordenada(n):
    n -= 1
    return n // colunas, n % colunas

# Converte coordenada para número
def coordenada_para_numero(linha, coluna):
    return linha * colunas + coluna + 1

# Heurística com suporte a diagonais
def h_score(a, b):
    dx = abs(a[0] - b[0])
    dy = abs(a[1] - b[1])
    return (dx + dy) + (1.4 - 2) * min(dx, dy)

# Algoritmo A* com diagonais e bloqueios
def aestrela(celulas_bloqueadas, inicial, destino):
    bloqueadas = {numero_para_coordenada(n) for n in celulas_bloqueadas}

    f_score = {}
    g_score = {}
    caminho = {}

    f_score[inicial] = h_score(inicial, destino)
    g_score[inicial] = 0

    fila = PriorityQueue()
    fila.put((f_score[inicial], inicial))

    explorados = []

    movimentos = [
        (-1, 0), (1, 0), (0, -1), (0, 1),       # ortogonais
        (-1, -1), (-1, 1), (1, -1), (1, 1)      # diagonais
    ]

    while not fila.empty():
        atual = fila.get()[1]
        explorados.append(atual)

        if atual == destino:
            break

        for mov in movimentos:
            vizinho = (atual[0] + mov[0], atual[1] + mov[1])
            if (0 <= vizinho[0] < linhas and 0 <= vizinho[1] < colunas and
                vizinho not in bloqueadas):

                # Se for diagonal, verifica os dois vizinhos ortogonais
                if abs(mov[0]) == 1 and abs(mov[1]) == 1:
                    ort1 = (atual[0] + mov[0], atual[1])
                    ort2 = (atual[0], atual[1] + mov[1])
                    if ort1 in bloqueadas or ort2 in bloqueadas:
                        continue

                custo = 1.4 if abs(mov[0]) == 1 and abs(mov[1]) == 1 else 1
                temp_g = g_score[atual] + custo

                if vizinho not in g_score or temp_g < g_score[vizinho]:
                    g_score[vizinho] = temp_g
                    f_score[vizinho] = temp_g + h_score(vizinho, destino)
                    fila.put((f_score[vizinho], vizinho))
                    caminho[vizinho] = atual

    # Reconstrução do caminho
    atual = destino
    caminho_final = []
    while atual != inicial:
        caminho_final.append(atual)
        atual = caminho.get(atual)
        if atual is None:
            print("\nCaminho bloqueado! Esbarrou em uma parede.\n")
            print("Caminho até o bloqueio:")
            for passo in explorados:
                print(f"→ {coordenada_para_numero(passo[0], passo[1])}", end=" ")
            print()
            return []

    caminho_final.append(inicial)
    caminho_final.reverse()
    return caminho_final

# Função com animação para desenhar o caminho
def animar_caminho(canvas, caminho, delay=50):
    if not caminho:
        return
    coord = caminho.pop(0)
    i, j = coord
    canvas.create_rectangle(j * cell_size, i * cell_size,
                            (j + 1) * cell_size, (i + 1) * cell_size,
                            outline="black", fill="green")
    canvas.create_text(j * cell_size + cell_size // 2,
                       i * cell_size + cell_size // 2,
                       text=str(coordenada_para_numero(i, j)), font=("Arial", 10))
    canvas.after(delay, lambda: animar_caminho(canvas, caminho, delay))

# Exibe a matriz e depois anima o caminho
def exibir_matriz_com_animacao(linhas, colunas, celulas_azuis_numeros, caminho, inicial, destino):
    janela = tk.Tk()
    janela.title("Matriz com Animação do Caminho")

    canvas = tk.Canvas(janela, width=colunas * cell_size, height=linhas * cell_size)
    canvas.pack()

    for i in range(linhas):
        for j in range(colunas):
            numero_celula = coordenada_para_numero(i, j)
            coord = (i, j)

            if numero_celula in celulas_azuis_numeros:
                cor = "blue"
            elif coord == inicial:
                cor = "red"
            elif coord == destino:
                cor = "orange"
            else:
                cor = "yellow"

            canvas.create_rectangle(j * cell_size, i * cell_size,
                                    (j + 1) * cell_size, (i + 1) * cell_size,
                                    outline="black", fill=cor)
            canvas.create_text(j * cell_size + cell_size // 2,
                               i * cell_size + cell_size // 2,
                               text=str(numero_celula), font=("Arial", 10))

    caminho_intermediario = [coord for coord in caminho if coord not in [inicial, destino]]
    janela.after(500, lambda: animar_caminho(canvas, caminho_intermediario))
    janela.mainloop()

# Conversões
inicial_coord = numero_para_coordenada(inicial_num)
destino_coord = numero_para_coordenada(destino_num)

# Executa o A*
caminho = aestrela(celulas_azuis_numeros, inicial_coord, destino_coord)

# Exibe matriz com animação do caminho
exibir_matriz_com_animacao(linhas, colunas, celulas_azuis_numeros, caminho, inicial_coord, destino_coord)
