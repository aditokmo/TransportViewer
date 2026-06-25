CLASS zcl_tr_display_alv_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_tr_display .

  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS c_program TYPE sy-repid VALUE 'ZTR_TRANSPORT_EVAL'.

ENDCLASS.



CLASS zcl_tr_display_alv_table IMPLEMENTATION.

    METHOD zif_tr_display~display_results.
        DATA: ls_layout TYPE slis_layout_alv,
              lt_fcat   TYPE slis_t_fieldcat_alv,
              ls_fcat   TYPE slis_fieldcat_alv.

        DATA: lt_transports TYPE zts_transports.
        lt_transports = it_transports.

        CLEAR ls_fcat.
        ls_fcat-fieldname = 'TRKORR'.
        ls_fcat-seltext_m = 'Transport ID'.
        ls_fcat-outputlen = 20.
        APPEND ls_fcat TO lt_fcat.

        CLEAR ls_fcat.
        ls_fcat-fieldname = 'TASK_COUNT'.
        ls_fcat-seltext_m = 'Tasks'.
        ls_fcat-outputlen = 6.
        APPEND ls_fcat TO lt_fcat.

        CLEAR ls_fcat.
        ls_fcat-fieldname = 'AS4USER'.
        ls_fcat-seltext_m = 'Owner'.
        ls_fcat-outputlen = 12.
        APPEND ls_fcat TO lt_fcat.

        CLEAR ls_fcat.
        ls_fcat-fieldname = 'AS4DATE'.
        ls_fcat-seltext_m = 'Release Date'.
        ls_fcat-outputlen = 10.
        APPEND ls_fcat TO lt_fcat.

        CLEAR ls_fcat.
        ls_fcat-fieldname = 'AS4TIME'.
        ls_fcat-seltext_m = 'Release Time'.
        ls_fcat-outputlen = 8.
        APPEND ls_fcat TO lt_fcat.

        CLEAR ls_fcat.
        ls_fcat-fieldname = 'KORRDEV'.
        ls_fcat-seltext_m = 'Type'.
        ls_fcat-outputlen = 8.
        APPEND ls_fcat TO lt_fcat.

        ls_layout-colwidth_optimize = abap_true.
        ls_layout-zebra             = abap_true.

        CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
          EXPORTING
            i_callback_program = c_program
            is_layout          = ls_layout
            it_fieldcat        = lt_fcat
          TABLES
            t_outtab           = lt_transports
          EXCEPTIONS
            program_error      = 1
            OTHERS             = 2.

        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE cx_salv_error.
        ENDIF.

    ENDMETHOD.

    METHOD zif_tr_display~get_strategy_name.
        rv_name = 'ALV Classic Table'.
    ENDMETHOD.

ENDCLASS.
