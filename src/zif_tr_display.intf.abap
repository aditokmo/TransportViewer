interface ZIF_TR_DISPLAY
  public .

  METHODS:
    display_results
        IMPORTING
            it_transports TYPE zts_transports
        RAISING
            cx_salv_error,

    get_strategy_name
        RETURNING
            VALUE(rv_name) TYPE string.

endinterface.
