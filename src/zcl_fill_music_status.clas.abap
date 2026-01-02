CLASS zcl_fill_music_status DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_fill_music_status IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA lt_status TYPE TABLE OF ziv_t_status.

    " 1. Clear existing data to avoid duplicates during re-runs
    DELETE FROM ziv_t_status.

    " 2. Define the Status entries for the Music Cockpit
    lt_status = VALUE #(
      ( status_id = 1 status_desc = 'New / To Do' )
      ( status_id = 2 status_desc = 'Fixing / Mixing' )
      ( status_id = 3 status_desc = 'Mastering' )
      ( status_id = 4 status_desc = 'Done / Ready' )
      ( status_id = 5 status_desc = 'Cancelled' )
    ).

    " 3. Insert data into the database table
    INSERT ziv_t_status FROM TABLE @lt_status.

    " Output result to the ABAP Console
    out->write( 'Status table populated successfully, Isaac!' ).
  ENDMETHOD.
ENDCLASS.
