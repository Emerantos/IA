
# Algoritmo A* para Busca de Caminho

Este projeto implementa o algoritmo A* para encontrar o caminho mais curto entre dois pontos em uma matriz 2D, levando em consideração obstáculos. O algoritmo utiliza uma heurística de distância de Manhattan e suporta movimentos ortogonais e diagonais, com regras específicas para lidar com bloqueios (representados pelas células azuis).

## 🧠 Algoritmo Utilizado

O algoritmo utilizado para encontrar o caminho mais curto entre dois pontos em uma matriz, considerando obstáculos (representados pelas células azuis), é o **Algoritmo A* (A Star)**. Esse algoritmo é amplamente utilizado em problemas de busca de caminhos e grafos, pois é eficiente e considera tanto o custo acumulado até o ponto atual (`G`) quanto a estimativa de custo até o objetivo (`H`), utilizando a fórmula `F = G + H`. 

### 1. **Cálculo da Heurística (H)**
A heurística usada no A* é a **distância de Manhattan**, que calcula o custo estimado de se mover de um ponto até o destino. Como o algoritmo suporta movimentação diagonal, a heurística é ajustada com base nessa possibilidade.

```python
def h_score(a, b):
    dx = abs(a[0] - b[0])
    dy = abs(a[1] - b[1])
    return (dx + dy) + (1.4 - 2) * min(dx, dy)
```

- **Distância de Manhattan**: A soma das diferenças absolutas nas coordenadas `x` e `y` dos dois pontos.
- **Ajuste para diagonais**: Quando a movimentação é diagonal, o custo é levemente aumentado (`1.4 - 2`) para refletir a distância maior da diagonal.

### 2. **Algoritmo A* com Bloqueios**
A função principal que implementa o algoritmo A* é chamada de `aestrela()`. Ela começa com a configuração inicial e tenta expandir os pontos, procurando o caminho até o destino, enquanto evita obstáculos (células azuis).

```python
def aestrela(celulas_bloqueadas, inicial, destino):
    bloqueadas = {numero_para_coordenada(n) for n in celulas_bloqueadas}
    f_score = {}
    g_score = {}
    caminho = {}

    f_score[inicial] = h_score(inicial, destino)
    g_score[inicial] = 0

    fila = PriorityQueue()
    fila.put((f_score[inicial], inicial))
```

- **Células bloqueadas**: São representadas por um conjunto de coordenadas que não podem ser atravessadas. Essas células são fornecidas como entrada no código (as células azuis).
- **Fila de prioridade**: O algoritmo utiliza uma fila de prioridade para explorar os pontos de menor custo primeiro, garantindo que o caminho encontrado seja o mais curto possível.

### 3. **Expansão de Nós**
Para cada célula em que o algoritmo está, ele verifica todos os seus vizinhos (movimentos ortogonais e diagonais) e calcula o custo de cada um. O algoritmo garante que apenas células que não estão bloqueadas ou que não se movem por uma diagonal inválida (quando há um obstáculo) sejam exploradas.

```python
movimentos = [
    (-1, 0), (1, 0), (0, -1), (0, 1),      
    (-1, -1), (-1, 1), (1, -1), (1, 1)      
]

if abs(mov[0]) == 1 and abs(mov[1]) == 1:
    ort1 = (atual[0] + mov[0], atual[1])
    ort2 = (atual[0], atual[1] + mov[1])
    if ort1 in bloqueadas or ort2 in bloqueadas:
        continue
```

- **Movimentos ortogonais**: Movimentos para cima, baixo, esquerda e direita.
- **Movimentos diagonais**: Movimentos para as quatro direções diagonais, onde o algoritmo verifica se ambos os vizinhos ortogonais não estão bloqueados antes de permitir o movimento diagonal.

### 4. **Cálculo do Custo (G)**
Para cada vizinho válido, o algoritmo calcula o custo acumulado (`G`) e o custo total estimado (`F = G + H`). O custo `G` é incrementado dependendo se o movimento é ortogonal (custo de 1) ou diagonal (custo de 1.4).

```python
custo = 1.4 if abs(mov[0]) == 1 and abs(mov[1]) == 1 else 1
temp_g = g_score[atual] + custo
```

### 5. **Reconstrução do Caminho**
Uma vez que o destino é alcançado, o algoritmo reconstrói o caminho percorrido a partir do destino até o ponto inicial, indo de trás para frente, utilizando o dicionário `caminho`.

```python

atual = destino
caminho_final = []
while atual != inicial:
    caminho_final.append(atual)
    atual = caminho.get(atual)
```

Caso o algoritmo encontre um bloqueio sem possibilidade de caminho, ele informa ao usuário que não é possível encontrar o caminho e exibe as células exploradas até o ponto de bloqueio.

### 6. **Considerações Finais**
O algoritmo A* utilizado neste projeto é eficiente para encontrar o caminho mais curto em uma matriz com obstáculos e suporta movimentação ortogonal e diagonal. O uso da heurística ajustada e da fila de prioridade garante que o caminho encontrado seja o mais otimizado possível. Em casos onde o destino não é alcançável devido aos bloqueios, o algoritmo informa ao usuário, ajudando a evitar confusão.
