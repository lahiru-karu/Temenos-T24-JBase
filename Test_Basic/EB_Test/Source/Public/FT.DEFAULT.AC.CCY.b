* @ValidationCode : MjoyMTQ0NDgwNjQ5OkNwMTI1MjoxNzUyMTc5MDQ4NTkyOkRlbGw6LTE6LTE6MDowOmZhbHNlOk4vQTpERVZfMjAyMTA2LjE6LTE6LTE=
* @ValidationInfo : Timestamp         : 11 Jul 2025 00:24:08
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
$PACKAGE EB.Test

SUBROUTINE FT.DEFAULT.AC.CCY

    $USING EB.API
    $USING EB.SystemTables
    $USING FT.Contract
    $USING AC.AccountOpening

*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------

    GOSUB INIT ; *
    GOSUB PROCESS

*-----------------------------------------------------------------------------

INIT:
    drAcNo = EB.SystemTables.getRNew(FT.Contract.FundsTransfer.DebitAcctNo)
    crAcNo = EB.SystemTables.getRNew(FT.Contract.FundsTransfer.CreditAcctNo)
RETURN
*-----------------------------------------------------------------------------

PROCESS:
    IF NOT(drAcNo = '') THEN
        drAcRec = AC.AccountOpening.Account.CacheRead(drAcNo, drAcErr)
        IF drAcErr = '' THEN
            EB.SystemTables.setRNew(FT.Contract.FundsTransfer.DebitCurrency, drAcRec<AC.AccountOpening.Account.Currency>)
        END ELSE
        
        END
    END
    IF NOT(crAcNo = '') THEN
        crAcRec = AC.AccountOpening.Account.CacheRead(crAcNo, crAcErr)
        IF crAcErr = '' THEN
            EB.SystemTables.setRNew(FT.Contract.FundsTransfer.CreditCurrency, crAcRec<AC.AccountOpening.Account.Currency>)
        END ELSE
        
        END
    END
    
RETURN

END

