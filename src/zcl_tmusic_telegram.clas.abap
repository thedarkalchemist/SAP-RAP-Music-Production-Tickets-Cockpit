CLASS zcl_tmusic_telegram DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    CLASS-METHODS send_message IMPORTING iv_text TYPE string.
ENDCLASS.

CLASS zcl_tmusic_telegram IMPLEMENTATION.
  METHOD send_message.
    TRY.
        DATA(lv_token) = '8599572236:AAElHHgLJmJRIMnBw50kFKzl3NozEGZWZN8'.
        DATA(lv_chat_id) = '1316231880'.
        DATA(lv_url) = |https://api.telegram.org/bot{ lv_token }/sendMessage?chat_id={ lv_chat_id }&text={ cl_abap_context_info=>get_user_alias( ) }: { iv_text }&parse_mode=Markdown|.

        DATA(lo_dest) = cl_http_destination_provider=>create_by_url( lv_url ).
        DATA(lo_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

        DATA(lo_response) = lo_client->execute( i_method = if_web_http_client=>get ).
        " Aqui podes verificar o status lo_response->get_status( )
      CATCH cx_root.
        " Tratar erro
    ENDTRY.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    " Teste rápido:
    send_message( 'Olá Isaac! 🚀 As tuas batidas estão no ponto! 🎹🔥' ).
    out->write( 'Mensagem enviada!' ).
  ENDMETHOD.
ENDCLASS.
