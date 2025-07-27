* @ValidationCode : MjotMTAyMjIwNjIyODpDcDEyNTI6MTc1MzU5MDI1OTU0MzpEZWxsOi0xOi0xOjA6MDpmYWxzZTpOL0E6REVWXzIwMjEwNi4xOi0xOi0x
* @ValidationInfo : Timestamp         : 27 Jul 2025 08:24:19
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

SUBROUTINE FT.REVERSE.TWORK.SERVICE
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------
    $USING EB.API
    $USING EB.SystemTables
    $USING EB.Service
    $USING FT.Contract
    $USING EB.DataAccess
    $USING EB.Foundation
    $USING EB.Interface
    
    $INSERT I_F.FT.TWORK.FILE
    
    GOSUB INIT
    GOSUB PROCESS

RETURN
    
INIT:
    DEBUG
    FN.FT.TWORK.FILE = "F.FT.TWORK.FILE"; FP.FT.TWORK.FILE = ""
    EB.DataAccess.Opf(FN.FT.TWORK.FILE, FP.FT.TWORK.FILE)
    SEL.CMD = "SELECT " : FP.FT.TWORK.FILE : " WITH STATUS='PENDING'"
    KEY.LIST = ""
RETURN

PROCESS.OFS:
    DEBUG
    AppName = "FUNDS.TRANSFER"
    Ofsfunct = "R"
    Process = "PROCESS"
    Ofsversion = "FUNDS.TRANSFER,"
    Gtsmode = ""
    NoOfAuth = 0
    TransactionId = KEY.TXN
    Record = ""
    Ofsrecord = ""
    OfssourceId = "GENERIC.OFS.PROCESS"
    
    EB.Foundation.OfsBuildRecord(AppName, Ofsfunct, Process, Ofsversion, Gtsmode, NoOfAuth, TransactionId, Record, Ofsrecord)
    
    CRT "OFS Message : " : Ofsrecord
    
    EB.Interface.setOfsSourceRec(EB.Interface.OfsSource.CacheRead(OfssourceId, OfssourceError))
    EB.Interface.setOfsSourceId(OfssourceId)
    !EB.Interface.OfsPostMessage(Ofsrecord, OfsMsgId, OfsSourceId, Options)
    EB.Interface.OfsBulkManager(Ofsrecord, Ofsresponse, Requestcommitted)
    
    CRT "Reversal requested initiated for " : KEY.TXN : " " : Ofsresponse
    
RETURN

UPDATE.TWORK.FILE:
    EB.DataAccess.CacheRead(FP.FT.TWORK.FILE, KEY.TXN, TworkRecord, Er)
    IF TworkRecord THEN
        TworkRecord<FT.TWO16.STATUS> = "PROCESSED"
        EB.DataAccess.FWrite(FP.FT.TWORK.FILE, KEY.TXN, TworkRecord)
        CRT "Twork table updated for " KEY.TXN
    END
RETURN

PROCESS:
    EB.DataAccess.Readlist(SEL.CMD, KEY.LIST, "", "", SEL.CMD.ERR)
    
    IF NOT(KEY.LIST) THEN
        RETURN
    END
    
    LOOP
        REMOVE KEY.TXN FROM KEY.LIST SETTING KEY.POS
    WHILE KEY.TXN:KEY.POS
        GOSUB PROCESS.OFS
        GOSUB UPDATE.TWORK.FILE
    REPEAT
RETURN
END
