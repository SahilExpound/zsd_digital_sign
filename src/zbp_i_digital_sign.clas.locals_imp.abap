CLASS lhc_zi_digital_doc DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_digital_doc RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_digital_doc RESULT result.

    METHODS zsign FOR MODIFY
      IMPORTING keys FOR ACTION zi_digital_doc~zsign RESULT result.

ENDCLASS.

CLASS lhc_zi_digital_doc IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD zsign.
    DATA : json TYPE string.
    DATA : gv_pwd                  TYPE string,
           gv_contenttype          TYPE string VALUE 'application/json',
           gv_username             TYPE string,
           lv_content_length_value TYPE i,
           lv_xml_result_str       TYPE string,
           lv_response             TYPE string,
           lv_uri_post             TYPE string,
           lv_response_txt         TYPE string,
           gv_token                TYPE string.

    DATA: update_lines TYPE TABLE FOR UPDATE zi_digital_sign,
          update_line  TYPE STRUCTURE FOR UPDATE zi_digital_sign.


    DATA : it_hdr1 TYPE TABLE OF zsd_dsign.
    READ ENTITIES OF zi_digital_sign IN LOCAL MODE
    ENTITY zi_digital_doc
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(header).

    READ TABLE header INTO DATA(wa_hdr) INDEX 1.

    LOOP AT header ASSIGNING FIELD-SYMBOL(<fs_hdr>).
      <fs_hdr>-sign_cord = '[408,141,630, -51]'.
      <fs_hdr>-sign_page = 0.
      <fs_hdr>-send_mail = 0.
      <fs_hdr>-currdate = sy-datum.
    ENDLOOP.

    MOVE-CORRESPONDING header TO it_hdr1.
*    loop AT it_hdr1 aSSIGNING fIELD-SYMBOL(<fs_h1>).
*       <fs_h1>
*    endLOOP.


    DATA : lt_mapping  TYPE /ui2/cl_json=>name_mappings.

*    lt_mapping = VALUE #(
*  ( abap = 'BillingDocument'   json = 'invoice_number' )
*  ( abap = 'Irn'   json = 'irn' )
*  ( abap = 'currdate'  json = 'date' )
*  ( abap = 'NetAmount'    json = 'total_invoice_value' )
*  ( abap = 'Customer'  json = 'customer' )
*  ( abap = 'CustomerName' json = 'customer_name' )
*  ( abap = 'cust_mail' json = 'customer_mail' )
*  ( abap = 'cust_mailcc'      json = 'cc_email' )
*  ( abap = 'send_mail'    json = 'send_mail' )
*   ( abap = 'sign_cord'    json = 'sign_coords' )
*
*
*  ).
*
*    DATA(lv_json) = /ui2/cl_json=>serialize( data          = it_hdr1
*                                               compress      = abap_false
*                                               pretty_name   = /ui2/cl_json=>pretty_mode-camel_case
*                                               name_mappings = lt_mapping ).
*
*    json = lv_json.
*    gv_username = 'sb-23d735ea-f43e-4e3a-b412-6ab59f359f1f!b623946|it-rt-mpm-dev-sub-5c8lxci5!b410603'.
*    gv_pwd = '6655195f-1a43-4cf6-81fe-9819161e021f$RluJxVpjSUfKEErOow-oHsO2Ag_7fpGppRqTCQ6n_3I='.
*
*
*    TRY.
*        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
*                                 comm_scenario      = 'ZCS_DIGITAL_SIGN'
*                                     service_id     = 'ZEXP_DIGITAL_SIGN_REST'
*                               ).
*
*        DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = lo_destination ).
*        DATA(lo_request) = lo_http_client->get_http_request( ).
*
*
*        lo_request->set_header_field( i_name  = 'Content-Type'
*                                      i_value = gv_contenttype ).
*
**        lo_request->set_header_field( i_name  = 'Authorization'
**                                      i_value = gv_token ).
*
*        lo_request->set_header_field( i_name  = 'username'
*                                      i_value = gv_username ).
*
*        lo_request->set_header_field( i_name  = 'Password'
*                                      i_value = gv_pwd ).
*
*        lv_content_length_value = strlen( json ).
*
*        lo_request->set_text( i_text = json
*                              i_length = lv_content_length_value ).
*
*        DATA : str TYPE string.
*        DATA : lv_doc_status TYPE string.
*        DATA(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).
*        lv_xml_result_str = lo_response->get_text( ).
*        lv_response = lv_xml_result_str.
*
*        SPLIT lv_xml_result_str AT '"url":"'   INTO str lv_doc_status.
*
*
*        IF lv_doc_status IS NOT INITIAL.
*          LOOP AT keys INTO DATA(key).
*            IF line_exists( header[ billingdocument = key-billingdocument ] ).
*              update_line-%tky   = key-%tky.
*              update_line-zsigninv1  = lv_doc_status.
*              APPEND update_line TO update_lines.
*            ENDIF.
*          ENDLOOP.
*
*          IF update_lines IS NOT INITIAL.
*            MODIFY ENTITIES OF zi_digital_sign IN LOCAL MODE
*              ENTITY zi_digital_doc
*                UPDATE
*                  FIELDS ( zsigninv1  )
*                  WITH update_lines
*                  REPORTED DATA(reported1)
*                  FAILED DATA(failed1)
*                  MAPPED DATA(mapped1).
*
*            READ ENTITIES OF zi_digital_sign IN LOCAL MODE
*            ENTITY zi_digital_doc
*            ALL FIELDS WITH CORRESPONDING #( keys )
*            RESULT DATA(lt_result_hdr).
*            result = VALUE #( FOR result_hdr IN lt_result_hdr
*                   ( %tky   = result_hdr-%tky
*                     %param = result_hdr ) ).
*          ENDIF.
*
*        ENDIF.
*
*
*
*
*
*    ENDTRY.

****    DATA(lo_dest_local) = cl_http_destination_provider=>create_by_url(
****          i_url = 'https://mpm-dev-sub-5c8lxci5.it-cpi026-rt.cfapps.eu10-002.hana.ondemand.com/http/digital_signature' ).
****
****    DATA(lo_http) = cl_web_http_client_manager=>create_by_http_destination(
****          i_destination = lo_dest_local ).
****
****    wa_hdr-sign_cord = '[408,141,630, -51]'.
****    wa_hdr-sign_page = 0.
****    wa_hdr-send_mail = 0.
****    wa_hdr-currdate = sy-datum.
****
****    lv_uri_post = |https://mpm-dev-sub-5c8lxci5.it-cpi026-rt.cfapps.eu10-002.hana.ondemand.com/http/digital_signature/| &&
*****                  |CreateBatchSplitItem| &&
****                  |"invoice_number" :"{ wa_hdr-BillingDocument }",| &&
****                  |"irn" :"{ wa_hdr-Irn }",| &&
****                  |"date" : { wa_hdr-currdate } ,| &&
****                  |"total_invoice_value" :{ wa_hdr-NetAmount } ,| &&
****                  |"customer" : "{ wa_hdr-Customer }" ,| &&
****                  |"customer_name" : "{ wa_hdr-CustomerName }" ,| &&
****                  |"customer_mail" : "{ wa_hdr-cust_mail }" ,| &&
****                  |"cc_email" : "{ wa_hdr-cust_mailcc }" ,| &&
****                  |"send_mail" : { wa_hdr-send_mail } ,| &&
****                  |"sign_page" : { wa_hdr-sign_page } ,| &&
****                  |"sign_coords" : { wa_hdr-sign_cord } |  .
****    CONDENSE lv_uri_post .
****
****
****    TRY.
****        DATA(lo_post_req) = lo_http->get_http_request( ).
****        lo_post_req->set_uri_path( i_uri_path = lv_uri_post ).
****        lo_post_req->set_header_field( i_name = 'Username' i_value = 'sb-23d735ea-f43e-4e3a-b412-6ab59f359f1f!b623946|it-rt-mpm-dev-sub-5c8lxci5!b410603' ).
****        lo_post_req->set_header_field( i_name = 'Password'  i_value = '6655195f-1a43-4cf6-81fe-9819161e021f$RluJxVpjSUfKEErOow-oHsO2Ag_7fpGppRqTCQ6n_3I=' ).
****
****        DATA(lo_post_resp) = lo_http->execute( i_method = if_web_http_client=>post ).
****        lv_response_txt = lo_post_resp->get_text( ).
****        DATA(ls_post_status) = lo_post_resp->get_status( ).
****     endTRY.
****
****    IF sy-subrc = 0.
****
****    ENDIF.

    DATA: lo_dest        TYPE REF TO if_http_destination,
          lo_http_client TYPE REF TO if_web_http_client,
          lo_request     TYPE REF TO if_web_http_request,
          lo_response    TYPE REF TO if_web_http_response,
*          lv_response1    TYPE string,
          lv_json        TYPE string.
    DATA: lv_plain   TYPE string,
          lv_encoded TYPE string,
          lv_auth    TYPE string.

    DATA : it_dgsign TYPE TABLE OF zdb_digital_sign,
           wa_dgsign TYPE zdb_digital_sign.

    TYPES: BEGIN OF ty_resp,
             message TYPE string,
             url     TYPE string,
           END OF ty_resp.


    DATA : wa_resp TYPE ty_resp,
           lv_url2 TYPE string.


    CONCATENATE 'sb-23d735ea-f43e-4e3a-b412-6ab59f359f1f!b623946|it-rt-mpm-dev-sub-5c8lxci5!b410603:' '6655195f-1a43-4cf6-81fe-9819161e021f$RluJxVpjSUfKEErOow-oHsO2Ag_7fpGppRqTCQ6n_3I='
    INTO lv_plain .
*    lv_plain   = |BAS_USER:FyfGjZXxZwtPu(uVR5XBqobbgDLVsahveXMQlmAe|.
    lv_encoded = cl_web_http_utility=>encode_base64( lv_plain ).
    lv_auth    = |Basic { lv_encoded }|.
    " 1️⃣ Create destination (use your full base URL ONLY)
    lo_dest = cl_http_destination_provider=>create_by_url(
      i_url = 'https://mpm-dev-sub-5c8lxci5.it-cpi026-rt.cfapps.eu10-002.hana.ondemand.com:443' ).

    " 2️⃣ Create HTTP client
    lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
      i_destination = lo_dest ).

    wa_hdr-send_mail = 0.
    wa_hdr-sign_page = 0.
    wa_hdr-sign_cord = '[590,500,830, -201]' . "'[408,141,630, -51]'.
    wa_hdr-currdate = sy-datum.

    " 3️⃣ Prepare JSON payload (IMPORTANT)
    lv_json = |\{| &&
      |"invoice_number":"{ wa_hdr-billingdocument }",|
      && |"irn":"{ wa_hdr-irn }",|
      && |"date":"{ wa_hdr-currdate DATE = ISO }",|
      && |"total_invoice_value":{ wa_hdr-netamount },|
      && |"customer":"{ wa_hdr-customer }",|
      && |"customer_name":"{ wa_hdr-customername }",|
      && |"customer_mail":"{ wa_hdr-cust_mail }",|
      && |"cc_email":"{ wa_hdr-cust_mailcc }",|
      && |"send_mail":{ wa_hdr-send_mail },|
      && |"sign_page":{ wa_hdr-sign_page },|
      && |"sign_coords":{ wa_hdr-sign_cord }|
    && |\}|.
    " 4️⃣ Get request object
    lo_request = lo_http_client->get_http_request( ).

    " 5️⃣ Set API path ONLY (not full URL)
    lo_request->set_uri_path( i_uri_path = '/http/digital_signature/' ).

    " 6️⃣ Set headers
    lo_request->set_header_field( i_name = 'Content-Type' i_value = 'application/json' ).
    lo_request->set_header_field( i_name = 'Authorization' i_value = lv_auth ).
***    lo_request->set_header_field( i_name = 'Username'
***      i_value = 'sb-xxxx|it-rt-mpm-dev-sub-xxxxx' ).
***    lo_request->set_header_field( i_name = 'Password'
***      i_value = 'xxxxxx' ).

    " 7️⃣ Attach JSON body
    lo_request->set_text( lv_json ).

    TRY.
        " 8️⃣ Execute POST
        lo_response = lo_http_client->execute(
          i_method = if_web_http_client=>post ).

        lv_response = lo_response->get_text( ).

        DATA(ls_status) = lo_response->get_status( ).

        IF ls_status-code = 200 OR ls_status-code = 201.
          lv_xml_result_str = lv_response.

          DATA : str TYPE string.
          DATA : lv_doc_status TYPE string.

          SPLIT lv_xml_result_str AT '"url":"'   INTO str lv_doc_status.

*          DATA: lv_response TYPE string,
*                lv_url      TYPE string.



*          DATA(ls_resp) TYPE ty_resp.

          " your response
          lv_response = lo_response->get_text( ).

          " Deserialize JSON
          /ui2/cl_json=>deserialize(
            EXPORTING json = lv_response
            CHANGING  data = wa_resp ).

          " Get URL
          lv_url2 = wa_resp-url.

          IF lv_doc_status IS NOT INITIAL.

            DATA(lo_proc1) = NEW cl_abap_parallel( p_percentage = 30 ).
            DATA lt_poparallel1 TYPE cl_abap_parallel=>t_in_inst_tab.

*            wa_dgsign-billingdocument = wa_hdr-billingdocument.
            wa_dgsign-billingdocument = wa_hdr-billingdocument.
            wa_dgsign-base64          = wa_hdr-base64.
            wa_dgsign-currdate        = wa_hdr-currdate.
            wa_dgsign-m_ind           = 'X' ."wa_hdr-m_ind.
            wa_dgsign-lv_send_mail    = wa_hdr-lv_send_mail.

            wa_dgsign-zsigninv1       = lv_url2 .
*            wa_dgsign-zsigninv2       = wa_hdr-zsigninv2.
*            wa_dgsign-zsigninv3       = wa_hdr-zsigninv3.

            wa_dgsign-cust_mail       = wa_hdr-cust_mail.
            wa_dgsign-cust_mailcc     = wa_hdr-cust_mailcc.

            wa_dgsign-send_mail       = wa_hdr-send_mail.
            wa_dgsign-sign_page       = wa_hdr-sign_page.
            wa_dgsign-sign_cord       = wa_hdr-sign_cord.

            wa_dgsign-irn             = wa_hdr-irn.
            wa_dgsign-customer        = wa_hdr-customer.
            wa_dgsign-customername    = wa_hdr-customername.
            APPEND wa_dgsign TO  it_dgsign .

            INSERT NEW zcl_parallel_digital( gt_dgsign = CORRESPONDING #( it_dgsign ) )
            INTO TABLE lt_poparallel1.

            IF lt_poparallel1 IS NOT INITIAL.
              lo_proc1->run_inst(
                EXPORTING
                  p_in_tab  = lt_poparallel1
                  p_debug   = abap_false
                IMPORTING
                  p_out_tab = DATA(lt_finished)
              ).
            ENDIF.

            " Success
          ELSE.
            " Handle error
          ENDIF.
        ENDIF.
      CATCH cx_root INTO DATA(lx_error).
        lv_response = lx_error->get_text( ).
    ENDTRY.


  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_digital_sign DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

*    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zi_digital_sign IMPLEMENTATION.

*  METHOD save_modified.
*  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
