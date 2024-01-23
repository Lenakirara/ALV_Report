*&---------------------------------------------------------------------*
*& Report ZALV_REPORT604
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZALV_REPORT604.

TYPE-POOLS: slis.

**** Tabelas *****
TABLES:
  mara,
  makt.

**** Botoes de seleção *****
SELECTION-SCREEN:
BEGIN OF LINE,
PUSHBUTTON   (20) button1 USER-COMMAND btn1,
PUSHBUTTON 30(20) button2 USER-COMMAND btn2,
END OF LINE.

**** Tela de seleção *****
SELECTION-SCREEN BEGIN OF BLOCK 01 WITH FRAME.
  SELECT-OPTIONS: s_ersda FOR mara-ersda.
SELECTION-SCREEN END OF BLOCK 01.

***** Tabela interna *****
DATA: t_mara     TYPE TABLE OF mara,
      t_makt     TYPE TABLE OF makt,
      t_saida    TYPE TABLE OF ZSMATER604,
      t_fieldcat TYPE slis_t_fieldcat_alv,
      t_sort     TYPE slis_t_sortinfo_alv.

***** Work Area *****
DATA: w_mara     TYPE mara,
      w_makt     TYPE makt,
      w_saida    TYPE ZSMATER604,
      w_fieldcat TYPE slis_fieldcat_alv,
      w_sort     TYPE slis_sortinfo_alv,
      w_layout   TYPE slis_layout_alv.

*** Definindo os botoes *****
INITIALIZATION.
  button1 = 'Materiais Criados'.
  button2 = 'Materiais Eliminados'.

AT SELECTION-SCREEN.
  IF sy-ucomm = 'BTN1'.
    PERFORM f_btn USING button1.
  ELSEIF sy-ucomm = 'BTN2'.
    PERFORM f_btn USING button2.
  ENDIF.

START-OF-SELECTION.

*&---------------------------------------------------------------------*
*& Form f_btn
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> BUTTON1
*&---------------------------------------------------------------------*
FORM f_btn  USING    p_btn.
  CASE p_btn.
    WHEN button1.
      MESSAGE TEXT-001 TYPE 'S'. "Botão de "Materais Criados" selecionado
      PERFORM f_seleciona_dados_mat_criados.
      PERFORM f_alv_container.
    WHEN button2.
      MESSAGE TEXT-002 TYPE 'S'. "Botão de "Materiais Eliminados" selecionado
      PERFORM f_seleciona_dados_mat_elimin.
      PERFORM f_alv_container.
  ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_seleciona_dados_mat_criados
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_seleciona_dados_mat_criados .
  SELECT *
    FROM mara
    INTO TABLE t_mara
    WHERE ersda IN s_ersda AND lvorm = space.

  IF sy-subrc IS INITIAL.
    SELECT *
      FROM makt
      INTO TABLE t_makt
      FOR ALL ENTRIES IN t_mara
      WHERE matnr = t_mara-matnr AND spras = 'PT'.
  ELSE.
    MESSAGE TEXT-003 TYPE 'E'. "Não existem materiais criados para o período informado
    STOP.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_monta_tabela_saida
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_monta_tabela_saida .
  LOOP AT t_mara INTO w_mara.
    CLEAR w_saida.

    w_saida-matnr = w_mara-matnr.
    w_saida-ersda = w_mara-ersda.
    w_saida-ernam = w_mara-ernam.
    w_saida-lvorm = w_mara-lvorm.
    w_saida-mtart = w_mara-mtart.
    w_saida-matkl = w_mara-matkl.

    READ TABLE t_makt INTO w_makt WITH KEY matnr = w_mara-matnr.
    IF sy-subrc IS INITIAL.
      w_saida-maktx = w_makt-maktx.
    ENDIF.

    APPEND w_saida TO t_saida.

  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_monta_fieldcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_monta_fieldcat .
  CLEAR t_fieldcat.
  PERFORM f_fieldcat USING:
        " campo |  descrição | posição
        'MATNR'   TEXT-010    1,    "Material
        'ERSDA'   TEXT-011    2,    "Data de criação
        'ERNAM'   TEXT-012    3,    "Nome do responsável
        'LVORM'   TEXT-013    4,    "Marcar mat. para eliminação
        'MTART'   TEXT-014    5,    "Tipo de material
        'MATKL'   TEXT-015    6,    "Grupo de mercadorias
        'MAKTX'   TEXT-016    7.    "Descrição do material

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_fieldcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> TEXT_010
*&      --> P_1
*&---------------------------------------------------------------------*
FORM f_fieldcat  USING    p_campo
                          p_descricao
                          p_posicao.

  w_fieldcat-fieldname = p_campo.
  w_fieldcat-seltext_m = p_descricao.
  w_fieldcat-col_pos = p_posicao.

  APPEND w_fieldcat TO t_fieldcat.

  CLEAR w_fieldcat.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_ordena_alv
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_ordena_alv .
  CLEAR w_sort.
  w_sort-fieldname = 'ERSDA'. "Ordenando por data de criação
  w_sort-tabname = 'T_SAIDA'.
  w_sort-up = 'X'.            "Crescente
  APPEND w_sort TO t_sort.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_layout .
  w_layout-zebra = 'X'.
  w_layout-colwidth_optimize = 'X'. "Altera tamanho da coluna conforme a qtde de caracteres

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_imprimi_alv
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_imprimi_alv .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
*     i_bypassing_buffer = 'X'
      is_layout          = w_layout
      it_fieldcat        = t_fieldcat
      it_sort            = t_sort
    TABLES
      t_outtab           = t_saida
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  CLEAR t_saida.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_alv_container
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_alv_container .
  PERFORM f_monta_tabela_saida.
  PERFORM f_monta_fieldcat.
  PERFORM f_ordena_alv.
  PERFORM f_layout.
  PERFORM f_imprimi_alv.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_seleciona_dados_mat_elimin
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_seleciona_dados_mat_elimin .
  SELECT *
      FROM mara
      INTO TABLE t_mara
      WHERE ersda IN s_ersda AND lvorm = 'X'.

  IF sy-subrc IS INITIAL.
    SELECT *
    FROM makt
    INTO TABLE t_makt
    FOR ALL ENTRIES IN t_mara
    WHERE matnr = t_mara-matnr AND spras = 'PT'.
  ELSE.
    MESSAGE TEXT-004 TYPE 'E'. "Não existem materiais eliminados para o período informado
    STOP.
  ENDIF.

ENDFORM.
