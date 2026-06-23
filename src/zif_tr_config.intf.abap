interface ZIF_TR_CONFIG
  public .

    METHODS:
        get_user_config
            IMPORTING
                iv_uname    TYPE xubname
            RETURNING
                VALUE(rs_cfg) TYPE ztr_config,

        save_user_config
            IMPORTING
                is_cfg      TYPE ztr_config
            RAISING
                cx_sy_sql_error.

endinterface.
