* @ValidationCode : MjotMTY0Mzk5Njc1MjpDcDEyNTI6MTc1MTk3NzQ0MDg2NzpEZWxsOi0xOi0xOjA6MDpmYWxzZTpOL0E6REVWXzIwMjEwNi4xOi0xOi0x
* @ValidationInfo : Timestamp         : 08 Jul 2025 16:24:00
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

SUBROUTINE EB.TEST.VALIDATION
    $USING EB.API
    $USING EB.SystemTables
    $USING FT.Contract
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

    GOSUB INIT ; *Initialise variables
    GOSUB PROCESS ; *Process

*-----------------------------------------------------------------------------

*** <region name= INIT>
INIT:
*** <desc>Initialise variables </desc>
    debitAcctNo = ''
RETURN
*** </region>


*-----------------------------------------------------------------------------

*** <region name= PROCESS>
PROCESS:
*** <desc>Process </desc>
    debitAcctNo = EB.SystemTables.getRNew(FT.Contract.FundsTransfer.DebitAcctNo)
    IF debitAcctNo = '' THEN
        debitAcctNo = '1001'
        EB.SystemTables.setRNew(FT.Contract.FundsTransfer.DebitAcctNo, debitAcctNo)
    END ELSE
        EB.SystemTables.setE('You are not allowed to set the Debit Account!')
    END

RETURN
*** </region>

END



