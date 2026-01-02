@Metadata.allowExtensions: true
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZIVT_STATUS'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_IVT_STATUS
  provider contract transactional_query
  as projection on ZR_IVT_STATUS
  association [1..1] to ZR_IVT_STATUS as _BaseEntity on $projection.StatusID = _BaseEntity.StatusID
{
  @Search.defaultSearchElement: true
  key StatusID,
  @Search.defaultSearchElement: true
  StatusDesc,
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
