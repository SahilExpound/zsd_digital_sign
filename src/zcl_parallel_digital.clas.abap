CLASS zcl_parallel_digital DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_serializable_object.
    INTERFACES if_abap_parallel.

    TYPES : tt_dgsign TYPE TABLE OF  zdb_digital_sign   WITH EMPTY KEY .
    DATA : it_design TYPE tt_dgsign    .
    METHODS constructor
      IMPORTING
        gt_dgsign TYPE tt_dgsign OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_parallel_digital IMPLEMENTATION.

  METHOD constructor.
    it_design = gt_dgsign .
  ENDMETHOD.


  METHOD if_abap_parallel~do.
    IF it_design[] IS NOT INITIAL.
      MODIFY zdb_digital_sign FROM TABLE @it_design .
      COMMIT WORK .
    ENDIF.

  ENDMETHOD.

ENDCLASS.
