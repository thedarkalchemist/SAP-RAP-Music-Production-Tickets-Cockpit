CLASS zcl_tmusic_cleanup DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun. " Para poderes correr isto com F9
ENDCLASS.

CLASS zcl_tmusic_cleanup IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Apagar drafts que não têm nome de música (lixo de ter clicado em Create e voltado atrás)
    DELETE FROM ztmusic_cckpit_d WHERE trackname IS INITIAL.

    IF sy-subrc = 0.
      out->write( 'A javardice foi limpa com sucesso! 🧹' ).
    ELSE.
      out->write( 'Não havia lixo para limpar.' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
