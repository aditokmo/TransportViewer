CLASS zcl_tr_config_manager DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_tr_config .

  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS c_generic_user TYPE xubname VALUE '*'.

ENDCLASS.



CLASS zcl_tr_config_manager IMPLEMENTATION.

    METHOD zif_tr_config~get_user_config.
    SELECT SINGLE *
      FROM ztr_config
      WHERE uname = @iv_uname
      INTO CORRESPONDING FIELDS OF @rs_cfg.

    IF sy-subrc <> 0.
      SELECT SINGLE *
        FROM ztr_config
        WHERE uname = @c_generic_user
        INTO CORRESPONDING FIELDS OF @rs_cfg.

      IF sy-subrc <> 0.
        rs_cfg-uname           = iv_uname.
        rs_cfg-max_transports  = 100.
        rs_cfg-task_count_low  = 1.
        rs_cfg-task_count_high = 99.
        rs_cfg-disp_strategy   = 'G'.
      ENDIF.
    ENDIF.
  ENDMETHOD.

    METHOD zif_tr_config~save_user_config.
        DATA: ls_db_record TYPE ztr_config.
        ls_db_record = is_cfg.

        ls_db_record-mandt = sy-mandt.
        IF ls_db_record-uname IS INITIAL.
            ls_db_record-uname = sy-uname.
        ENDIF.

        MODIFY ztr_config FROM @ls_db_record.

        IF sy-subrc = 0.
            COMMIT WORK.
        ELSE.
            ROLLBACK WORK.
            RAISE EXCEPTION TYPE cx_sy_sql_error.
        ENDIF.
    ENDMETHOD.

ENDCLASS.
