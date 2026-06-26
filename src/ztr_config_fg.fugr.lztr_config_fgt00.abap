*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTR_CONFIG......................................*
DATA:  BEGIN OF STATUS_ZTR_CONFIG                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTR_CONFIG                    .
CONTROLS: TCTRL_ZTR_CONFIG
            TYPE TABLEVIEW USING SCREEN '9000'.
*.........table declarations:.................................*
TABLES: *ZTR_CONFIG                    .
TABLES: ZTR_CONFIG                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
