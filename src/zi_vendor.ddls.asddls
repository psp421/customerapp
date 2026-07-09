@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vendor Interface View - Base CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
  serviceQuality: #X,
  sizeCategory:   #S,
  dataClass:      #MIXED
}
define root view entity ZI_VENDOR
  as select from zxy_vendor as Vendor
  composition [1..1] of ZI_BP as _BP
{
  key Vendor.vendor_no              as VendorNo,
      Vendor.uuid                   as Uuid,
      Vendor.vendor_name            as VendorName,
      Vendor.active                 as Active,
      Vendor.valid_start_dat        as ValidStartDat,
      Vendor.valid_end_dat          as ValidEndDat,
      Vendor.created_by             as CreatedBy,
      Vendor.created_at             as CreatedAt,
      Vendor.last_changed_by        as LastChangedBy,
      Vendor.last_changed_at        as LastChangedAt,
      Vendor.local_last_changed_at  as LocalLastChangedAt,

      /* Association to Business Partner (1:1 cardinality) */
      _BP
}
