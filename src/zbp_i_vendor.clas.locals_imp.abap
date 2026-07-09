*"* Local class implementations for behavior pool ZBP_I_VENDOR

"====================================================================
" ROOT ENTITY HANDLER: Vendor
"====================================================================
CLASS lcl_vendor IMPLEMENTATION.

  METHOD setVendorUuid.
    " Read current UUID values for all keys
    READ ENTITIES OF zi_vendor IN LOCAL MODE
      ENTITY Vendor
        FIELDS ( Uuid )
        WITH CORRESPONDING #( keys )
      RESULT DATA(vendors)
      FAILED DATA(read_failed).

    " Build update table only for records where UUID is still initial
    DATA updates TYPE TABLE FOR UPDATE zi_vendor\\Vendor.
    LOOP AT vendors INTO DATA(vendor).
      IF vendor-Uuid IS INITIAL.
        APPEND VALUE #(
          %tky = vendor-%tky
          Uuid = cl_system_uuid=>create_uuid_x16_static( )
        ) TO updates.
      ENDIF.
    ENDLOOP.

    IF updates IS NOT INITIAL.
      MODIFY ENTITIES OF zi_vendor IN LOCAL MODE
        ENTITY Vendor
          UPDATE FIELDS ( Uuid ) WITH updates
        REPORTED DATA(mod_reported).
      reported = CORRESPONDING #( DEEP mod_reported ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.

"====================================================================
" CHILD ENTITY HANDLER: BP
"====================================================================
CLASS lcl_bp IMPLEMENTATION.

  METHOD setBpUuid.
    " Generate UUID for newly created BP records
    READ ENTITIES OF zi_vendor IN LOCAL MODE
      ENTITY BP
        FIELDS ( BpUuid )
        WITH CORRESPONDING #( keys )
      RESULT DATA(bps)
      FAILED DATA(read_failed).

    DATA updates TYPE TABLE FOR UPDATE zi_vendor\\BP.
    LOOP AT bps INTO DATA(bp).
      IF bp-BpUuid IS INITIAL.
        APPEND VALUE #(
          %tky    = bp-%tky
          BpUuid  = cl_system_uuid=>create_uuid_x16_static( )
        ) TO updates.
      ENDIF.
    ENDLOOP.

    IF updates IS NOT INITIAL.
      MODIFY ENTITIES OF zi_vendor IN LOCAL MODE
        ENTITY BP
          UPDATE FIELDS ( BpUuid ) WITH updates
        REPORTED DATA(mod_reported).
      reported = CORRESPONDING #( DEEP mod_reported ).
    ENDIF.
  ENDMETHOD.


  METHOD setBpType.
    " Auto-determine BP type from VendorNo pattern:
    "   VendorNo starts with XYZ + digits  →  BpType = 'SUPP'
    "   VendorNo starts with ABC + digits  →  BpType = 'PART'
    READ ENTITIES OF zi_vendor IN LOCAL MODE
      ENTITY BP
        FIELDS ( VendorNo BpType )
        WITH CORRESPONDING #( keys )
      RESULT DATA(bps)
      FAILED DATA(read_failed).

    DATA updates TYPE TABLE FOR UPDATE zi_vendor\\BP.

    LOOP AT bps INTO DATA(bp).
      DATA(vendor_no)  = bp-VendorNo.
      DATA(new_bp_type) = bp-BpType.

      IF strlen( vendor_no ) > 3.
        DATA(prefix)   = vendor_no(3).
        DATA(remainder) = vendor_no+3.

        " Trim trailing spaces from remainder for digit-only check
        remainder = condense( val = remainder to = `` ).

        IF prefix = 'XYZ' AND remainder CO '0123456789'.
          new_bp_type = 'SUPP'.
        ELSEIF prefix = 'ABC' AND remainder CO '0123456789'.
          new_bp_type = 'PART'.
        ENDIF.
      ENDIF.

      IF new_bp_type <> bp-BpType.
        APPEND VALUE #(
          %tky   = bp-%tky
          BpType = new_bp_type
        ) TO updates.
      ENDIF.
    ENDLOOP.

    IF updates IS NOT INITIAL.
      MODIFY ENTITIES OF zi_vendor IN LOCAL MODE
        ENTITY BP
          UPDATE FIELDS ( BpType ) WITH updates
        REPORTED DATA(mod_reported).
      reported = CORRESPONDING #( DEEP mod_reported ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
