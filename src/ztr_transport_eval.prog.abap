*&---------------------------------------------------------------------*
*& Report ztr_transport_eval
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztr_transport_eval.

DATA: gv_owner TYPE xubname,
      gv_type  TYPE zte_tr_type,
      gv_tasks TYPE int4.

SELECTION-SCREEN BEGIN OF BLOCK b_owner WITH FRAME TITLE text-001.
  SELECT-OPTIONS: so_owner FOR gv_owner NO INTERVALS.
SELECTION-SCREEN END OF BLOCK b_owner.

SELECTION-SCREEN BEGIN OF BLOCK b_type WITH FRAME TITLE text-002.
  SELECT-OPTIONS: so_type FOR gv_type.
SELECTION-SCREEN END OF BLOCK b_type.

SELECTION-SCREEN BEGIN OF BLOCK b_filter WITH FRAME TITLE text-003.
  PARAMETERS: p_maxcnt TYPE zte_max_tr DEFAULT 100,
              p_date   TYPE dats,
              p_time   TYPE tims.
  SELECT-OPTIONS: so_tasks FOR gv_tasks DEFAULT 0 TO 999.
SELECTION-SCREEN END OF BLOCK b_filter.

SELECTION-SCREEN BEGIN OF BLOCK b_disp WITH FRAME TITLE text-004.
  PARAMETERS: p_strat TYPE zte_disp_strat DEFAULT 'G'.
SELECTION-SCREEN END OF BLOCK b_disp.



INITIALIZATION.
  DATA: lo_cfg_mgr  TYPE REF TO zif_tr_config,
        ls_user_cfg TYPE ztr_config.

  lo_cfg_mgr = NEW zcl_tr_config_manager( ).
  ls_user_cfg = lo_cfg_mgr->get_user_config( sy-uname ).

  IF ls_user_cfg-max_transports IS NOT INITIAL.
    p_maxcnt = ls_user_cfg-max_transports.
  ENDIF.

  IF ls_user_cfg-disp_strategy IS NOT INITIAL.
    p_strat = ls_user_cfg-disp_strategy.
  ENDIF.

  IF ls_user_cfg-task_count_low IS NOT INITIAL OR ls_user_cfg-task_count_high IS NOT INITIAL.
    CLEAR so_tasks[].
    so_tasks-sign   = 'I'.
    so_tasks-option = 'BT'.
    so_tasks-low    = ls_user_cfg-task_count_low.
    so_tasks-high   = ls_user_cfg-task_count_high.
    APPEND so_tasks.
  ENDIF.

START-OF-SELECTION.
  DATA: ls_sel_params TYPE zts_sel_params,
        lo_controller TYPE REF TO zcl_tr_controller.

  IF so_owner IS NOT INITIAL.
    ls_sel_params-owner_low  = so_owner-low.
    ls_sel_params-owner_high = so_owner-high.
  ENDIF.

  IF so_type IS NOT INITIAL.
    ls_sel_params-type_low  = so_type-low.
    ls_sel_params-type_high = so_type-high.
  ENDIF.

  ls_sel_params-max_count = p_maxcnt.

  IF so_tasks IS NOT INITIAL.
    ls_sel_params-tasks_low  = so_tasks-low.
    ls_sel_params-tasks_high = so_tasks-high.
  ENDIF.

  lo_controller = NEW zcl_tr_controller( ).

  IF ls_sel_params-owner_low IS NOT INITIAL AND ls_sel_params-owner_high IS INITIAL.
      ls_sel_params-owner_high = ls_sel_params-owner_low.
  ENDIF.

  IF ls_sel_params-type_low IS NOT INITIAL AND ls_sel_params-type_high IS INITIAL.
    ls_sel_params-type_high = ls_sel_params-type_low.
  ENDIF.

  lo_controller->run(
    is_sel_params    = ls_sel_params
    iv_disp_strategy = p_strat
  ).
