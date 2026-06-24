interface ZIF_TR_DATA
  public .

  METHODS:
    get_transports
        IMPORTING
            is_sel_params TYPE zts_sel_params
        RETURNING
            VALUE(rt_transports) TYPE zts_transports
        RAISING
            cx_sy_sql_error.

endinterface.
