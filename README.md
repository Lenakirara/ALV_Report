# Boas vindas ao repositório ALV Report!

Projeto de atividade final do nível intermediário [ABAP 4 Girls](https://abapforgirls.tech/) 

## Habilidades desenvolvidas:
- Criação de estrutura
- Desenvolvimento de relatórios em ALV
- Utilização de performs na organização do código

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


