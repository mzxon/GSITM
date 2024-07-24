@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '채권연령분석 View'

@AbapCatalog.viewEnhancementCategory: [#NONE]
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.modelingPattern: #ANALYTICAL_DIMENSION
@ObjectModel.supportedCapabilities: [#ANALYTICAL_DIMENSION,
                                     #CDS_MODELING_ASSOCIATION_TARGET,
                                     #CDS_MODELING_DATA_SOURCE,
                                     #SQL_DATA_SOURCE]

define root view entity ZR_ACCOUNTDOC_DEV as select from I_OperationalAcctgDocItem
    left outer join I_Customer on I_Customer.Customer = I_OperationalAcctgDocItem.Customer 
    left outer join I_GLAccountText on I_GLAccountText.GLAccount = I_OperationalAcctgDocItem.GLAccount and I_GLAccountText.Language = '3'
{
    key I_OperationalAcctgDocItem.CompanyCode,
    key I_OperationalAcctgDocItem.AccountingDocument,
    key I_OperationalAcctgDocItem.FiscalYear,
    key I_OperationalAcctgDocItem.AccountingDocumentItem,
        I_OperationalAcctgDocItem.FiscalPeriod,
        I_OperationalAcctgDocItem.PostingDate,
        I_OperationalAcctgDocItem.ClearingDate,
        I_OperationalAcctgDocItem.DocumentDate,
        I_OperationalAcctgDocItem.NetDueDate,
        I_OperationalAcctgDocItem.Customer,
        I_Customer.CustomerName,
        I_OperationalAcctgDocItem.GLAccount,
        I_GLAccountText.GLAccountName,
        
        @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
        I_OperationalAcctgDocItem.AmountInCompanyCodeCurrency,
        I_OperationalAcctgDocItem.CompanyCodeCurrency
}
