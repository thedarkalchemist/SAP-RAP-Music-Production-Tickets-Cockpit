CLASS zcl_tmusic_telegram_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS send_telegram_direct.
ENDCLASS.

CLASS zcl_tmusic_telegram_test IMPLEMENTATION.

  METHOD send_telegram_direct.

    DATA(lv_token)   = '8599572236:AAElHHgLJmJRIMnBw50kFKzl3NozEGZWZN8'.
    DATA(lv_chat_id) = '1316231880'.
    DATA lv_text     TYPE string.

    " 1. Buscar os dados das tuas produções
    SELECT FROM ztmusic_cockpit
      FIELDS track_name, artist_name, status_id
      INTO TABLE @DATA(lt_tracks).

    SORT lt_tracks BY status_id ASCENDING.

    " 2. Cabeçalho com estilo Dark Alchemy
    lv_text = |*OFFICIAL MUSIC COCKPIT REPORT* 🎵\n| &&
              |────────────────────\n| &&
              |*Producer:* Dark Alchemy 🎧\n| &&
              |*Date:* { cl_abap_context_info=>get_system_date( ) DATE = USER }\n\n|.

    " 3. Listagem das músicas com formatação Markdown
    LOOP AT lt_tracks INTO DATA(ls_track).
      DATA(lv_emoji) = SWITCH string( ls_track-status_id
        WHEN '1' THEN '🆕 *NEW / TO DO*'
        WHEN '2' THEN '🛠️ *FIXING / MIXING*'
        WHEN '3' THEN '🎚️ *MASTERING*'
        WHEN '4' THEN '✅ *DONE / READY*'
        WHEN '5' THEN '❌ *CANCELLED*'
        ELSE '🔘 *UNKNOWN*' ).

      lv_text &&= |{ lv_emoji } | &&
                  |`{ ls_track-track_name }` \n| &&
                  |└─ by _{ ls_track-artist_name }_\n\n|.
    ENDLOOP.

    " 4. Barra de progresso visual (Javardice de mestre)
    DATA(lv_total) = lines( lt_tracks ).
    " Cria uma barra tipo [▰▰▰▱▱] baseada no total (exemplo simples de repetição)
    DATA(lv_progress) = repeat( val = '▰' occ = lv_total ).

    lv_text &&= |────────────────────\n| &&
                |📊 *Production Flow:* { lv_progress }\n| &&
                |🔥 *Total Assets:* { lv_total } tracks in the lab.|.

    " 5. Enviar para a API do Telegram
    TRY.
        DATA(lv_url) = |https://api.telegram.org/bot{ lv_token }/sendMessage|.
        DATA(lo_dest) = cl_http_destination_provider=>create_by_url( lv_url ).
        DATA(lo_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).
        DATA(lo_request) = lo_client->get_http_request( ).

        lo_request->set_form_field( i_name = 'chat_id'    i_value = |{ lv_chat_id }| ).
        lo_request->set_form_field( i_name = 'text'       i_value = lv_text ).
        lo_request->set_form_field( i_name = 'parse_mode' i_value = 'Markdown' ).

        DATA(lo_response) = lo_client->execute( i_method = if_web_http_client=>post ).

      CATCH cx_root INTO DATA(lx_err).

    ENDTRY.

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    me->send_telegram_direct( ). " O main agora só chama o novo método
    out->write( 'Enviado com sucesso!' ).

  ENDMETHOD.
ENDCLASS.
