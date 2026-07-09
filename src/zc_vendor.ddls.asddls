@EndUserText.label: 'Vendor Consumption View - Fiori List Report'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@UI.headerInfo: {
  typeName:       'Vendor',
  typeNamePlural: 'Vendors',
  title:       { type: #STANDARD, value: 'VendorNo',   label: 'Vendor No.' },
  description: { type: #STANDARD, value: 'VendorName', label: 'Vendor Name' }
}

@UI.presentationVariant: [{
  sortOrder: [{ by: 'VendorNo', direction: #ASC }],
  visualizations: [{ type: #AS_LINEITEM }]
}]

define root view entity ZC_VENDOR
  provider contract transactional_query
  as projection on ZI_VENDOR
{
  @UI.facet: [
    {
      id:       'VendorInfo',
      type:     #IDENTIFICATION_REFERENCE,
      label:    'General Information',
      position: 10
    },
    {
      id:            'ValidityInfo',
      type:          #FIELDGROUP_REFERENCE,
      label:         'Validity Period',
      targetQualifier: 'ValidityGrp',
      position:      20
    },
    {
      id:            'AdminInfo',
      type:          #FIELDGROUP_REFERENCE,
      label:         'Administrative Data',
      targetQualifier: 'AdminGrp',
      position:      30
    },
    {
      id:            'BPSection',
      type:          #LINEITEM_REFERENCE,
      label:         'Business Partners',
      position:      40,
      targetElement: '_BP'
    }
  ]

  @UI.lineItem:      [{ position: 10, label: 'Vendor Number', importance: #HIGH }]
  @UI.identification:[{ position: 10, label: 'Vendor Number' }]
  @UI.selectionField:[{ position: 10 }]
  key VendorNo,

  @UI.lineItem:      [{ position: 20, label: 'Vendor Name', importance: #HIGH }]
  @UI.identification:[{ position: 20, label: 'Vendor Name' }]
  @UI.selectionField:[{ position: 20 }]
  VendorName,

  @UI.lineItem:       [{ position: 30, label: 'Active', importance: #MEDIUM }]
  @UI.identification: [{ position: 30, label: 'Active' }]
  @UI.selectionField: [{ position: 30 }]
  Active,

  @UI.lineItem:       [{ position: 40, label: 'Valid From', importance: #MEDIUM }]
  @UI.identification: [{ position: 40, label: 'Valid From' }]
  @UI.fieldGroup:     [{ qualifier: 'ValidityGrp', position: 10, label: 'Valid From' }]
  ValidStartDat,

  @UI.lineItem:       [{ position: 50, label: 'Valid To', importance: #MEDIUM }]
  @UI.identification: [{ position: 50, label: 'Valid To' }]
  @UI.fieldGroup:     [{ qualifier: 'ValidityGrp', position: 20, label: 'Valid To' }]
  ValidEndDat,

  @UI.hidden: true
  Uuid,

  @UI.fieldGroup: [{ qualifier: 'AdminGrp', position: 10, label: 'Created By' }]
  CreatedBy,

  @UI.fieldGroup: [{ qualifier: 'AdminGrp', position: 20, label: 'Created At' }]
  CreatedAt,

  @UI.fieldGroup: [{ qualifier: 'AdminGrp', position: 30, label: 'Changed By' }]
  LastChangedBy,

  @UI.fieldGroup: [{ qualifier: 'AdminGrp', position: 40, label: 'Changed At' }]
  LastChangedAt,

  @UI.hidden: true
  LocalLastChangedAt,

  /* Redirect composition child to its consumption counterpart */
  _BP: redirected to composition child ZC_BP
}
