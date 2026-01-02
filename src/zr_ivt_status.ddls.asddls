@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZIVT_STATUS'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_IVT_STATUS
  as select from ziv_t_status
{
  key status_id as StatusID,
//  @Search.defaultSearchElement: true
//  @Search.fuzzinessThreshold: 0.8
  status_desc as StatusDesc,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
}
