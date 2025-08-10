* @ValidationCode : MjoxMjY4Nzg4MTc5OkNwMTI1MjoxNzUzNzM2NTk5OTc4OkRlbGw6LTE6LTE6MDowOmZhbHNlOk4vQTpERVZfMjAyMTA2LjE6LTE6LTE=
* @ValidationInfo : Timestamp         : 29 Jul 2025 01:03:19
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
$PACKAGE EB.RecordComparison

SUBROUTINE EB.RECORD.CHANGES.COMMIT
*-----------------------------------------------------------------------------
* Routine created for the purpose of recording the changes between R.OLD and R.NEW
* Changes will be recorded in the template EB.RECORD.CHANGES
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------
    $USING EB.SystemTables
    $USING EB.API

    GOSUB INIT
    GOSUB PROCESS

INIT:
*-----------------------------------------------------------------------------
    DEBUG
    EB.SystemTables.ComparePreviousRecord(NumOldEntries, NumNewEntries, EB.SystemTables.getDynArrayFromROld(), EB.SystemTables.getDynArrayFromRNew(), OverrideDetails)
RETURN

PROCESS:
*-----------------------------------------------------------------------------

RETURN

END
