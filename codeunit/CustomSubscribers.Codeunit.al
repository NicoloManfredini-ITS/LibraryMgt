codeunit 50100 "BBL Custom Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnAfterCreateEntrySummary, '', false, false)]
    local procedure ChangeDataOnTracking(var TempGlobalEntrySummary: Record "Entry Summary" temporary)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnTransferItemLedgToTempRecOnBeforeInsert, '', false, false)]
    local procedure TestIsHandled(var TempGlobalReservEntry: Record "Reservation Entry" temporary; ItemLedgerEntry: Record "Item Ledger Entry"; TrackingSpecification: Record "Tracking Specification"; var IsHandled: Boolean)
    begin
        OnTestIsHandled(IsHandled);
    end;


    [IntegrationEvent(false, false)]
    local procedure OnTestIsHandled(var IsHandled: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterValidateEvent, "Sell-to Customer No.", false, false)]
    local procedure MyProcedure()
    begin
        
    end;
    
    
}