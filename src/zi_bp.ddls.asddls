@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business Partner Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
  serviceQuality: #X,
  sizeCategory:   #S,
  dataClass:      #MIXED
}
define view entity ZI_BP
  as select from zxy_bp as BP
  association to parent ZI_VENDOR as _Vendor
    on $projection.VendorNo = _Vendor.VendorNo
{
  key BP.bp_no                    as BpNo,
      BP.uuid                     as BpUuid,
      BP.vendor_no                as VendorNo,
      BP.bp_type                  as BpType,
      BP.created_by               as BpCreatedBy,
      BP.created_at               as BpCreatedAt,
      BP.last_changed_by          as BpLastChangedBy,
      BP.last_changed_at          as BpLastChangedAt,
      BP.local_last_changed_at    as BpLocalLastChangedAt,

      /* Association back to parent Vendor */
      _Vendor
}
