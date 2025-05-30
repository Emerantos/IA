# 🚗 Sistema de Inferência Fuzzy para Controle de Velocidade de Veículo

## 📌 Objetivo

Desenvolver um **Sistema de Inferência Fuzzy** para controlar a velocidade de um veículo, visando manter a **distância de segurança** entre dois veículos (A e B), onde apenas o veículo B sofre alterações em sua velocidade.

---

## 📁 Arquivos Disponibilizados

- `controlveiculo.fis`  
  Arquivo com o Sistema de Inferência Fuzzy, contendo:
  - Variáveis de entrada e saída
  - Conjuntos fuzzy (funções de pertinência)

- `controlveiculo.m`  
  Script em MATLAB utilizado para simulação do sistema fuzzy.

- `Exemplo Planilha Fuzzy.xlsx`  
  Planilha modelo para auxiliar na definição das regras fuzzy.

---

## 🛠️ Etapas do Desenvolvimento

1. **Definir as regras fuzzy**  
   Basear-se no comportamento esperado do sistema (descrições abaixo e exemplos na planilha/MATLAB).

2. **Simular o Sistema**  
   Utilizar o script `controlveiculo.m` para rodar as simulações.

3. **Gerar Gráficos do Comportamento do Sistema**
   - Tempo de simulação vs. Distância entre os veículos
   - Tempo de simulação vs. Velocidade dos veículos
   - Tempo de simulação vs. Diferença de velocidade
   - Tempo de simulação vs. Aceleração aplicada no veículo B

---

## 🤖 Comportamento Esperado

- O veículo **A** mantém **velocidade constante** durante toda a simulação.
- O controle é aplicado **somente ao veículo B**, ajustando sua aceleração para:
  - Manter ou recuperar a **distância de segurança**
  - **Não ultrapassar** a velocidade máxima permitida na via
  - **Atingir a velocidade máxima permitida** sempre que possível, respeitando as regras acima

### ⚠️ Regras Adicionais

- O veículo B **não pode ultrapassar o veículo A**
- O sistema deve **reagir** caso a simulação comece com violação da distância de segurança
- Em casos onde a distância de segurança já é mantida e o veículo A está mais lento que o limite da via, o veículo B **deve acompanhar** a velocidade de A

---

## 🧪 Próximas Versões

Futuramente, o controle fuzzy poderá ser **aplicado aos dois veículos (A e B)**, reutilizando as mesmas regras desenvolvidas nesta primeira versão.

---

## 📷 Exemplos de Resultados (a serem gerados)

> Insira aqui imagens dos gráficos gerados durante a simulação.

---

## 🧑‍💻 Requisitos

- MATLAB (versão compatível com arquivos `.fis` e `.m`)
- Fuzzy Logic Toolbox

---

## 📄 Licença

Este projeto é apenas para fins educacionais e está sob a licença [MIT](LICENSE).