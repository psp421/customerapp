*"* Local class definitions for behavior pool ZBP_I_VENDOR

"--------------------------------------------------------------------
" Handler for root entity: Vendor
"--------------------------------------------------------------------
CLASS lcl_vendor DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS setVendorUuid FOR DETERMINE ON SAVE
      IMPORTING keys FOR Vendor~setVendorUuid.
ENDCLASS.

"--------------------------------------------------------------------
" Handler for child entity: BP
"--------------------------------------------------------------------
CLASS lcl_bp DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS setBpUuid FOR DETERMINE ON SAVE
      IMPORTING keys FOR BP~setBpUuid.

    METHODS setBpType FOR DETERMINE ON SAVE
      IMPORTING keys FOR BP~setBpType.
ENDCLASS.
