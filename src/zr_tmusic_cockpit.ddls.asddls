@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZMUSIC_COCKPIT'
@ObjectModel.usageType.serviceQuality: #X
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@EndUserText.label: 'Ticket Cockpit For Music Production'

define root view entity ZR_TMUSIC_COCKPIT
  as select from ztmusic_cockpit
  association [1..1] to ziv_t_status as _Status on $projection.StatusID = _Status.status_id
{
  key ticket_id as TicketID,
  artist_name as ArtistName,
  track_name as TrackName,
  bpm as Bpm,
  issue_desc as IssueDesc,
  status_id as StatusID,
  
  
  
 @EndUserText.label: 'Audio File'
      @Semantics.largeObject: { 
          mimeType: 'AudioMimeType', 
          fileName: 'AudioFileName', 
          contentDispositionPreference: #ATTACHMENT 
      }
      audio_content as AudioContent,

      @Semantics.mimeType: true
      audio_mime_type as AudioMimeType,

      audio_filename as AudioFileName,
      
      
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  
  /* Custom Color Logic */
  case status_id
    when 1 then 0  // New / To Do -> Cinzento (Neutral)
    when 2 then 2  // Fixing / Mixing -> Amarelo (Warning)
    when 3 then 2  // Mastering -> Amarelo (Warning)
    when 4 then 3  // Done / Ready -> Verde (Success)
    when 5 then 1  // Cancelled -> Vermelho (Error)
    else 0
  end as StatusCriticality,
  
 _Status.status_desc as StatusDescription,
 _Status
 
}
