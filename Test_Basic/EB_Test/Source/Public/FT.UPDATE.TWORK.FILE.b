* @ValidationCode : Mjo0Nzg4NzkzNDY6Q3AxMjUyOjE3NTI1MjUwMDk2OTQ6RGVsbDotMTotMTowOjA6ZmFsc2U6Ti9BOkRFVl8yMDIxMDYuMTotMTotMQ==
* @ValidationInfo : Timestamp         : 15 Jul 2025 00:30:09
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

SUBROUTINE FT.UPDATE.TWORK.FILE
    $USING EB.API
    $USING EB.SystemTables
    $USING FT.Contract
    $USING EB.DataAccess
    
    $INSERT I_F.FT.TWORK.FILE
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------
 
*-----------------------------------------------------------------------------

    GOSUB INIT
    GOSUB PROCESS

RETURN

INIT:
    etdFn = "F.FT.TWORK.FILE"; etdFr = ''
    recId = EB.SystemTables.getIdNew()
    etdRec = ''
RETURN

PROCESS:
    IF EB.SystemTables.getIdOld() = '' THEN
	    EB.DataAccess.Opf(etdFn, etdFr)
        
	    etdRec<FT.TWO16.STATUS> = 'PENDING'
        etdRec<FT.TWO16.TIMESTAMP> = EB.SystemTables.getTimeStamp()
        EB.DataAccess.FWrite(etdFn, recId, etdRec)
    END ELSE
            
    END

RETURN

END
