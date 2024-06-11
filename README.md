# Boas vindas ao repositório ALV Report!

Projeto de atividade final do nível intermediário do curso [ABAP 4 Girls](https://abapforgirls.tech/)

<div align="center">
     
![image](https://github.com/Lenakirara/ALV_Report/assets/45247383/b8ee5a76-9b07-4669-9ec6-d1743c03c64b)

</div>

## Habilidades desenvolvidas:
1. Desenvolvimento de Relatórios ALV
     - Criação de relatórios personalizados utilizando ABAP List Viewer (ALV) para exibição de dados.
2. Implementação de Botões de Seleção
     - Criação de botões interativos no report para exibir diferentes conjuntos de dados conforme a seleção do usuário.
3. Manipulação de Dados em Tabelas Internas
     - Utilização de tabelas internas para armazenar e manipular dados de forma eficiente.
4. Uso de Funções Perform
     - Organização e modularização do código com o uso de funções perform para melhorar a legibilidade e manutenção.
5. Interação com Banco de Dados
     - Realização de consultas SQL para selecionar dados específicos de tabelas do SAP.
6. Mensagens de Feedback para Usuário
     - Implementação de mensagens de feedback (sucesso e erro) para informar o status das operações ao usuário.
7. Configuração de Layout ALV
     - Configuração e personalização do layout do ALV, incluindo ordenação e otimização de colunas.
8. Desenvolvimento de Telas de Seleção
     - Criação de telas de seleção para filtragem de dados conforme critérios definidos pelo usuário.

## Objetivo do projeto
Desenvolver um Report com botões que apresente 2 relatórios distintos. O primeiro será feito a exibição de materiais criados em um determinado período que não estejam 
marcados para eliminação. O segundo será para exibição de materiais criados em um determinado período que estejam marcados para eliminação.

## Especificações do projeto
1. Botão 1: `Materiais Criados` <br>     
2. Botão 2: `Materiais Eliminados` 
3. Campo (de-até): `Criado em` (mara-ersda)

![image](https://github.com/Lenakirara/ALV_Report/assets/45247383/3e07f046-0da6-46e6-80e5-cb922d3a4b15)


## Observações:
- Ao clicar no botão 1 ou 2, deverá ser selecionado na tabela MARA os seguintes campos
     |       |          |
     |-------|----------|
     | MATNR | Material |
     | ERSDA | Data de criação |
     | ERNAM | Nome do responsável que adicionou o objeto |
     | LVORM | Marcar mat.para eliminação a nível de mandante |
     | MTART | Tipo de material |
     | MATKL | Grupo de mercadorias |

- Buscar descrição dos materiais - Com os materiais selecionados, ir na tabela MAKT, buscar os campos:
     |       |          |
     |-------|----------|
     | MATNR | Material |
     | MAKTX | Descrição do material |
     | SPRAS | Idioma |

 - Caso não seja encontrado registros para a seleção, exibir a mensagem:
   1. Para materiais criados:  `Não existem materiais criados para o período informado`
   2. para materiais eliminados: `Não existem materiais eliminados para o período informado`
  
- Caso encontre os registros: Exibir relatório ALV
     |       |          |
     |-------|----------|
     | MATNR | Material |
     | ERSDA | Data de criação |
     | ERNAM | Nome do responsável que adicionou o objeto |
     | LVORM | Marcar mat.para eliminação a nível de mandante |
     | MTART | Tipo de material |
     | MATKL | Grupo de mercadorias |
     | MAKTX | Descrição do material |


