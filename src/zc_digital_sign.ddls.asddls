@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption for digital signature'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo:{
    typeName: 'Tax Invoice',
    typeNamePlural: 'Tax Invoice',
    title:{ type: #STANDARD, value: 'billingdocument' } }
define root view entity ZC_DIGITAL_SIGN as projection on ZI_DIGITAL_SIGN
{
   
    @UI.facet: [{ id : 'billingdocument',
  purpose: #STANDARD,
  type: #IDENTIFICATION_REFERENCE,
  label: 'Tax Invoice',
   position: 10 }]
       @UI.lineItem:       [{ position: 10, label: 'Billingdocument' },{ type: #FOR_ACTION , dataAction: 'ZSIGN', label: 'Digital Signature'}]
  @UI.identification: [{ position: 10, label: 'billingdocument' }]
  @UI.selectionField: [{ position: 10 }]
  
    key BillingDocument,
//     @UI.lineItem:       [{ position: 20, label: 'base64' }]
//  @UI.identification: [{ position: 20, label: 'base64' }]
    base64,
    
    
  @UI.lineItem:       [{ position: 30, label: 'Date' }]
  @UI.identification: [{ position: 30, label: 'Date' }]
    currdate,
    
    @UI.lineItem:       [{ position: 40, label: 'Sign' }]
  @UI.identification: [{ position: 40, label: 'Sign' }]
    m_ind,
    
     
    @UI.lineItem:       [{ position: 50, label: 'lv_send_mail' }]
  @UI.identification: [{ position: 50, label: 'lv_send_mail' }]
    lv_send_mail,
    
     @UI.lineItem:       [{ position: 60, label: 'Irn' }]
  @UI.identification: [{ position: 60, label: 'Irn' }]
    Irn,
    
     @UI.lineItem:       [{ position: 70, label: 'NetAmount' }]
  @UI.identification: [{ position: 70, label: 'NetAmount' }]
      @Semantics.amount.currencyCode: 'TransactionCurrency'
  NetAmount,
  TransactionCurrency,
  
   @UI.lineItem:       [{ position: 80, label: 'Customer' }]
  @UI.identification: [{ position: 80, label: 'Customer' }]
  Customer,
  
   @UI.lineItem:       [{ position: 90, label: 'CustomerName' }]
  @UI.identification: [{ position: 90, label: 'CustomerName' }]
  CustomerName,
  
   @UI.lineItem:       [{ position: 100, label: 'URL' }]
  @UI.identification: [{ position: 100, label: 'URL' }]
  zsigninv1,
  
  @UI.lineItem:       [{ position: 110, label: 'URL' }]
  @UI.identification: [{ position: 110, label: 'URL' }]
  @UI.hidden: true
  cust_mail,
  
  @UI.lineItem:       [{ position: 120, label: 'URL' }]
  @UI.identification: [{ position: 120, label: 'URL' }]
  @UI.hidden: true
  cust_mailcc,
  
  @UI.lineItem:       [{ position: 130, label: 'URL' }]
  @UI.identification: [{ position: 130, label: 'URL' }]
  @UI.hidden: true
  send_mail,
  
  @UI.lineItem:       [{ position: 140, label: 'URL' }]
  @UI.identification: [{ position: 140, label: 'URL' }]
  @UI.hidden: true
  sign_page
  ,
  @UI.lineItem:       [{ position: 150, label: 'URL' }]
  @UI.identification: [{ position: 150, label: 'URL' }]
  @UI.hidden: true
  sign_cord
 
}
