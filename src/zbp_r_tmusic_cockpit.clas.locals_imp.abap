CLASS lhc_zr_tmusic_cockpit DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PUBLIC SECTION.

  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING
      REQUEST requested_authorizations FOR ZrTmusicCockpit
      RESULT result.

    METHODS sendToTelegram FOR MODIFY
      IMPORTING keys FOR ACTION ZrTmusicCockpit~sendToTelegram.
    METHODS setStatusText FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZrTmusicCockpit~setStatusText.

ENDCLASS.



CLASS lhc_zr_tmusic_cockpit IMPLEMENTATION.

  METHOD get_global_authorizations.

    "Empty

  ENDMETHOD.

  METHOD sendToTelegram.

    " 1. Instanciar e disparar o Telegram (A tua lógica de negócio)
    DATA(lo_telegram) = NEW zcl_tmusic_telegram_test( ).

    lo_telegram->send_telegram_direct( ).

    "2. Como é STATIC e o resultado é '$self', devolvemos uma tabela vazia
    " ou apenas confirmamos o sucesso.
    APPEND VALUE #( %msg = new_message_with_text(
                             severity = if_abap_behv_message=>severity-success
                             text     = 'Report Sent To Telegram! 🚀' )
                  ) TO reported-zrtmusiccockpit.
  ENDMETHOD.


  METHOD setStatusText.

    " Lê os IDs que mudaram
    READ ENTITIES OF zr_tmusic_cockpit IN LOCAL MODE
      ENTITY ZrTmusicCockpit
        FIELDS ( StatusID ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_tracks).

    " Atualiza a descrição baseada no ID
    MODIFY ENTITIES OF zr_tmusic_cockpit IN LOCAL MODE
      ENTITY ZrTmusicCockpit
        UPDATE FIELDS ( StatusDescription )
        WITH VALUE #( FOR track IN lt_tracks (
          %tky              = track-%tky
          StatusDescription = SWITCH #( track-StatusID
                                WHEN '1' THEN 'New / To Do'
                                WHEN '2' THEN 'Fixing / Mixing'
                                WHEN '3' THEN 'Mastering'
                                WHEN '4' THEN 'Done / Ready'
                                WHEN '5' THEN 'Cancelled'
                                ELSE 'Unknown' )
        ) )
    REPORTED DATA(lt_reported).

  ENDMETHOD.

ENDCLASS.
