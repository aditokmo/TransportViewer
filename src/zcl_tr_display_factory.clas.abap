CLASS zcl_tr_display_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:
        get_display_strategy
            IMPORTING
                iv_strategy_code TYPE zte_disp_strat
            RETURNING
                VALUE(ro_strategy) TYPE REF TO zif_tr_display
            RAISING
                cx_sy_create_object_error.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tr_display_factory IMPLEMENTATION.

    METHOD get_display_strategy.
        CASE iv_strategy_code.
            WHEN 'G'.
                ro_strategy = NEW zcl_tr_display_alv_grid(  ).
            WHEN 'T'.
                ro_strategy = NEW zcl_tr_display_alv_table(  ).
            WHEN OTHERS.
                ro_strategy = NEW zcl_tr_display_alv_grid(  ).
        ENDCASE.
    ENDMETHOD.

ENDCLASS.
