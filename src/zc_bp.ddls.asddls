@EndUserText.label: 'Business Partner Consumption View'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@UI.headerInfo: {
  typeName:       'Business Partner',
  typeNamePlural: 'Business Partners',
  title:       { type: #STANDARD, value: 'BpNo',   label: 'BP Number' },
  description: { type: #STANDARD, value: 'BpType', label: 'BP Type'   }
}

define view entity ZC_BP
  as projection on ZI_BP
{
  @UI.facet: [
    {
      id:       'BPDetails',
      type:     #IDENTIFICATION_REFERENCE,
      label:    'BP Details',
      position: 10
    },
    {
      id:            'BPAdminInfo',
      type:          #FIELDGROUP_REFERENCE,
      label:         'Administrative Data',
      targetQualifier: 'BPAdminGrp',
      position:      20
    }
  ]

  @UI.lineItem:      [{ position: 10, label: 'BP Number', importance: #HIGH }]
  @UI.identification:[{ position: 10, label: 'BP Number' }]
  @UI.selectionField:[{ position: 10 }]
  key BpNo,

  @UI.lineItem:      [{ position: 20, label: 'Vendor Number', importance: #HIGH }]
  @UI.identification:[{ position: 20, label: 'Vendor Number' }]
  VendorNo,

  @UI.lineItem:      [{ position: 30, label: 'BP Type', importance: #HIGH }]
  @UI.identification:[{ position: 30, label: 'BP Type' }]
  @UI.selectionField:[{ position: 20 }]
  BpType,

  @UI.hidden: true
  BpUuid,

  @UI.fieldGroup: [{ qualifier: 'BPAdminGrp', position: 10, label: 'Created By' }]
  BpCreatedBy,

  @UI.fieldGroup: [{ qualifier: 'BPAdminGrp', position: 20, label: 'Created At' }]
  BpCreatedAt,

  @UI.fieldGroup: [{ qualifier: 'BPAdminGrp', position: 30, label: 'Changed By' }]
  BpLastChangedBy,

  @UI.fieldGroup: [{ qualifier: 'BPAdminGrp', position: 40, label: 'Changed At' }]
  BpLastChangedAt,

  @UI.hidden: true
  BpLocalLastChangedAt,

  /* Redirect parent association to its consumption counterpart */
  _Vendor: redirected to parent ZC_VENDOR
}
