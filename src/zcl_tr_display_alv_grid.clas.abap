CLASS zcl_tr_display_alv_grid DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_tr_display .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tr_display_alv_grid IMPLEMENTATION.

    METHOD zif_tr_display~display_results.
        DATA: lo_alv TYPE REF TO cl_salv_table.

        DATA: lt_display_data TYPE zts_transports.
        lt_display_data = it_transports.

        cl_salv_table=>factory(
            IMPORTING
                r_salv_table = lo_alv
            CHANGING
                t_table = lt_display_data
        ).

        lo_alv->get_columns(  )->set_optimize( abap_true ).
        lo_alv->get_functions(  )->set_all( abap_true ).
        lo_alv->get_display_settings(  )->set_striped_pattern( abap_true ).
        lo_alv->get_display_settings(  )->set_list_header( 'Released Transports - ALV Grid View' ).
        lo_alv->display(  ).

    ENDMETHOD.

    METHOD zif_tr_display~get_strategy_name.
        rv_name = 'ALV Grid'.
    ENDMETHOD.

ENDCLASS.
