CLASS zcl_tr_controller DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
        constructor,
        run
            IMPORTING
                is_sel_params    TYPE zts_sel_params
                iv_disp_strategy TYPE zte_disp_strat.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mo_data_provider  TYPE REF TO zif_tr_data,
          mo_config_mgr     TYPE REF TO zif_tr_config.

    METHODS:
        validate_params
            IMPORTING
                is_sel_params   TYPE zts_sel_params
            RETURNING
                VALUE(rv_ok)    TYPE abap_bool.
ENDCLASS.



CLASS zcl_tr_controller IMPLEMENTATION.

    METHOD constructor.
        mo_data_provider = NEW zcl_tr_data_provider(  ).
        mo_config_mgr    = NEW zcl_tr_config_manager(  ).
    ENDMETHOD.

    METHOD run.
        DATA: lt_transports TYPE zts_transports,
              lo_display    TYPE REF TO zif_tr_display.

        IF validate_params( is_sel_params ) = abap_false.
            MESSAGE 'Wrong selection params.' TYPE 'E'.
            RETURN.
        ENDIF.

        TRY.
            lt_transports = mo_data_provider->get_transports( is_sel_params ).
        CATCH cx_sy_sql_error INTO DATA(lx_sql).
            MESSAGE lx_sql->get_text(  ) TYPE 'E'.
            RETURN.
        ENDTRY.

        IF lt_transports IS INITIAL.
            MESSAGE 'No released transport orders were found.' TYPE 'I'.
            RETURN.
        ENDIF.

        TRY.
            lo_display = zcl_tr_display_factory=>get_display_strategy(
                iv_strategy_code = iv_disp_strategy
            ).
            CATCH cx_sy_create_object_error.
                MESSAGE 'Unable to create display strategy.' TYPE 'E'.
                RETURN.
        ENDTRY.

        TRY.
            lo_display->display_results( lt_transports ).
          CATCH cx_salv_error INTO DATA(lx_alv).
            MESSAGE lx_alv->get_text( ) TYPE 'E'.
        ENDTRY.
    ENDMETHOD.

    METHOD validate_params.
        rv_ok = abap_true.

        IF is_sel_params-max_count < 0.
            rv_ok = abap_false.
        ENDIF.
    ENDMETHOD.

ENDCLASS.
