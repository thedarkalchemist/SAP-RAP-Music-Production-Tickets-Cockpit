@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Ticket Details'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZMUSIC_COCKPIT'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_TMUSIC_COCKPIT
  provider contract transactional_query
  as projection on ZR_TMUSIC_COCKPIT
  association [1..1] to ZR_TMUSIC_COCKPIT as _BaseEntity on $projection.TicketID = _BaseEntity.TicketID
{
  key TicketID,
  ArtistName,
  TrackName,
  Bpm,
  IssueDesc,
  
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_IVT_STATUS', element: 'StatusID' } }]
  StatusID,
  
  StatusCriticality, 
  

  @UI.lineItem: [ { position: 50, criticality: 'StatusCriticality', criticalityRepresentation: #WITH_ICON } ]
  @EndUserText.label: 'Status'
  StatusDescription,
  
//  @EndUserText.label: 'Audio Track'
//  @UI.lineItem: [ { position: 60, importance: #HIGH } ]
//  @UI.identification: [ { position: 60 } ]
//  @Consumption.filter.hidden: true
//  AudioContent,

  @UI.hidden: true
  AudioMimeType,
  
  @Semantics: {
    user.createdBy: true
  }
  CreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  CreatedAt,
  @Semantics: {
    user.lastChangedBy: true
  }
  LastChangedBy,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  _BaseEntity
}
