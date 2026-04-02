@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for digital signature'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_DIGITAL_SIGN
  as select from    zi_tax_invoice        as a
    left outer join zdb_digital_sign      as b on a.BillingDocument = b.billingdocument
    left outer join ZI_BILLINGINV         as c on a.BillingDocument = c.BillingDocument
    left outer join I_BillingDocumentItem as d on a.BillingDocument = d.BillingDocument
    left outer join I_Customer            as e on e.Customer = d.SoldToParty
{
  key a.BillingDocument,
      a.base64,
      b.currdate,
      b.m_ind,
      b.lv_send_mail,
      c.Irn,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      d.NetAmount,
      d.TransactionCurrency,
      e.Customer,
      e.CustomerName,
      b.zsigninv1,
      b.cust_mail,
      b.cust_mailcc,
      b.send_mail,
      b.sign_page,
      b.sign_cord

}
where
  c.Irn <> ''
