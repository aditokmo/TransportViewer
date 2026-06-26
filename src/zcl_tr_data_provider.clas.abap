CLASS zcl_tr_data_provider DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_tr_data .

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
        count_tasks
            IMPORTING iv_trkorr     TYPE e070-trkorr
            RETURNING VALUE(rv_count) TYPE i.

ENDCLASS.



CLASS zcl_tr_data_provider IMPLEMENTATION.

    METHOD zif_tr_data~get_transports.
        DATA: lt_e070       TYPE TABLE OF e070,
              ls_e070       TYPE e070,
              ls_transport  TYPE zts_transport,
              lv_count      TYPE i.

        SELECT trkorr, as4user, as4date, as4time, korrdev
          FROM e070
          WHERE trstatus = 'R'
            AND ( @is_sel_params-owner_low = @space OR ( as4user >= @is_sel_params-owner_low AND as4user <= @is_sel_params-owner_high ) )
            AND ( @is_sel_params-type_low  = @space OR ( korrdev >= @is_sel_params-type_low  AND korrdev <= @is_sel_params-type_high ) )
          INTO CORRESPONDING FIELDS OF TABLE @lt_e070.

        SORT lt_e070 BY as4date DESCENDING as4time DESCENDING.

        LOOP AT lt_e070 INTO ls_e070.

            IF is_sel_params-max_count > 0 AND lines( rt_transports ) >= is_sel_params-max_count.
                EXIT.
            ENDIF.

            lv_count = me->count_tasks( iv_trkorr = ls_e070-trkorr ).

            CLEAR ls_transport.
            ls_transport-trkorr     = ls_e070-trkorr.
            ls_transport-task_count = lv_count.
            ls_transport-as4user    = ls_e070-as4user.
            ls_transport-as4date    = ls_e070-as4date.
            ls_transport-as4time    = ls_e070-as4time.
            ls_transport-korrdev    = ls_e070-korrdev.

            APPEND ls_transport TO rt_transports.
        ENDLOOP.

    ENDMETHOD.

    METHOD count_tasks.
        SELECT COUNT( * )
            FROM e070
            WHERE strkorr = @iv_trkorr
            INTO @rv_count.
    ENDMETHOD.



ENDCLASS.
