* @ValidationCode : Mjo5MDMyODQ5ODY6Q3AxMjUyOjE3NTUzNjIyNzQ3Mjg6RGVsbDotMTotMTowOjA6ZmFsc2U6Ti9BOkRFVl8yMDIxMDYuMTotMTotMQ==
* @ValidationInfo : Timestamp         : 16 Aug 2025 20:37:54
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

SUBROUTINE AA.AC.LEGACY.NO.VALIDATION
*-----------------------------------------------------------------------------
* Validation routine created to populate the Legacy Account Number in the
* following format
* Format : 3 Digit Branch Code + Product Category + Customer No + 3 digit serial
* Example: 001-1001-10000083-001
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------
    $USING EB.API
    $USING EB.SystemTables
    $USING AA.Framework
    $USING AA.Account
    $USING AC.AccountOpening
    $USING AC.AccountClosure
    $USING EB.DataAccess

    GOSUB INITIALISE
    GOSUB PROCESS

RETURN

*-----------------------------------------------------------------------------
INITIALISE:
    
    AaArrangementRec = AA.Framework.getC_aalocarrangementrec()
    AaProductCategory = ""
    AcCustomerAccounts = AC.AccountOpening.CustomerAccount.CacheRead(AaArrangementRec<AA.Framework.Arrangement.ArrCustomer,1,1>, Error)
    FnAccountClosed = "F.ACCOUNT.CLOSED"; FpAccountClosed = ""
    AcClosedAccounts = ""
    NewLegacyAcNo = ""
    BranchCode = ""
    CustomerId = ""
    SerialNo = ""
RETURN

*-----------------------------------------------------------------------------
PROCESS:
    
    EB.DataAccess.Opf(FnAccountClosed, FpAccountClosed)
    
    AaProductCategory = EB.SystemTables.getRNew(AA.Account.Account.AcCategory)
    BranchCode = AaArrangementRec<AA.Framework.Arrangement.ArrCoCode>[-3,3]
    CustomerId = AaArrangementRec<AA.Framework.Arrangement.ArrCustomer,1,1>
    CustomerId = FMT(CustomerId, "R%8")
    
    SerialNo = DCOUNT(AcCustomerAccounts, @FM)
    
    EB.DataAccess.Readlist("SELECT " : FnAccountClosed : " WITH CUSTOMER.ID EQ " : CustomerId, AcClosedAccounts, ListName, Selected, SystemReturnCode)
    
    SerialNo += DCOUNT(AcClosedAccounts, @FM)
    SerialNo ++
    SerialNo = FMT(SerialNo, "R%3")
    
    NewLegacyAcNo = BranchCode : AaProductCategory : CustomerId : SerialNo
    
    IF NewLegacyAcNo THEN
        GOSUB SET.LEGACY.AC
    END
        
RETURN

*-----------------------------------------------------------------------------
SET.LEGACY.AC:
    
    leagcyAcPos = ""
    altIdTypes = ""
    altIdValues = ""
    
    altIdType = EB.SystemTables.getRNew(AA.Account.Account.AcAltIdType)
    altIdValues = EB.SystemTables.getRNew(AA.Account.Account.AcAltId)
    
    LOCATE "LEGACY" IN altIdType<1,1> SETTING legacyAcPos THEN
        altIdValues<1,legacyAcPos> = NewLegacyAcNo
        EB.SystemTables.setRNew(AA.Account.Account.AcAltId, altIdValues)
    END ELSE
    
    END
    
RETURN

END
