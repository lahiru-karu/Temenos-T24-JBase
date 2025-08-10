* @ValidationCode : MjoxNjc4OTkyMDk3OkNwMTI1MjoxNzU0ODYwMzAyMDQ5OkRlbGw6LTE6LTE6MDowOmZhbHNlOk4vQTpERVZfMjAyMTA2LjE6LTE6LTE=
* @ValidationInfo : Timestamp         : 11 Aug 2025 01:11:42
* @ValidationInfo : Encoding          : Cp1252
* @ValidationInfo : User Name         : Dell
* @ValidationInfo : Nb tests success  : N/A
* @ValidationInfo : Nb tests failure  : N/A
* @ValidationInfo : Rating            : N/A
* @ValidationInfo : Coverage          : N/A
* @ValidationInfo : Strict flag       : N/A
* @ValidationInfo : Bypass GateKeeper : false
* @ValidationInfo : Compiler Version  : DEV_202106.1
* @ValidationInfo : Copyright Temenos Headquarters SA 1993-2021. All rights reserved.
$PACKAGE AA.TestRoutines

SUBROUTINE AA.MORT.DISBURSE.POST.REST
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------
    $USING EB.SystemTables
    $USING EB.API
    $USING AA.Framework
    $USING AA.Account
    $USING AA.ProductFramework
    $USING AA.ProductApi
    
    aaArrangementRec = AA.Framework.getC_aalocarrangementrec()
    EffectiveDate = AA.Framework.getC_aalocactivityeffdate()
    arrActivityStatus = AA.Framework.getC_aalocactivitystatus()
    arrActivityRec = AA.Framework.getC_aalocarractivityrec()
    ArrangementId = AA.Framework.getC_aalocarrid()
    curActivity = AA.Framework.getC_aalocactivityid()
    ArrActivityId = AA.Framework.getC_aalocarractivityid()
    
    ArrFieldNameList = ""
    accProperty = ""
    ArrFieldValueList = ""
    ArrActFieldsRec = ""
    NewActivity = ""
    
*Identify the field name for Posting Restriction to form the OFS
    EB.API.GetStandardSelectionDets("AA.ARR.ACCOUNT", aaArrSs)
    EB.API.FieldNumbersToNames(AA.Account.Account.AcPostingRestrict, aaArrSs, ArrFieldNameList, DataType, ErrMsg)
    
*Identify the Account property to form the OFS
    AA.ProductFramework.GetPropertyName(AA.Framework.getC_aalocproductrecord(), "ACCOUNT", ArrPropertyList)
    
*Form and generate the new activity
    NewActivity =  curActivity<1> : "-UPDATE-" :  ArrPropertyList
    ArrTxnDetails = ""
    ArrFieldNameList = ArrFieldNameList : ":1:1"
    ArrFieldValueList = "1"
    
    AA.Framework.GenArrangementActivityFields(ArrPropertyList, ArrFieldNameList, ArrFieldValueList, ArrActFieldsRec)
    
    AA.Framework.GenNewArrangementActivity(ArrangementId, NewActivity, EffectiveDate, ArrTxnDetails, ArrActivityId, ArrActFieldsRec, ReturnError)
    
    OPENSEQ 'TRACE.BP','AA.MORT.DISBURSE.POST.REST.txt' TO LOGTRACE ELSE NULL
    LOGENTRY = "arrActivityStatus : " : arrActivityStatus : CHAR(10)
    LOGENTRY := "ReturnError : " : ReturnError : CHAR(10) : CHAR(10)
    WRITESEQ LOGENTRY APPEND TO LOGTRACE ELSE NULL
    
RETURN

END
