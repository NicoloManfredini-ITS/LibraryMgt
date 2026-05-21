codeunit 50101 "BBL Custom Mgt."
{

    #region [Booking History]
    procedure OpenTrackingFromBookingHistory(var BookingHistory: Record "BBL Booking History")
    var
        TrackingSpecification: Record "Tracking Specification";
        ItemTrackingLines: Page "Item Tracking Lines";
        ItemTrackingDataCollection: Codeunit "Item Tracking Data Collection";
    begin
        InitFromBookingHistory(BookingHistory, TrackingSpecification);

        ItemTrackingDataCollection.AssistEditTrackingNo(TrackingSpecification, true, -1, "Item Tracking Type"::"Serial No.", 1);
        BookingHistory."Serial No." := TrackingSpecification."Serial No.";
        BookingHistory.Modify();
    end;

    procedure InitFromBookingHistory(BookingHistory: Record "BBL Booking History"; var TrackingSpecification: Record "Tracking Specification")
    var
        Item: Record Item;
    begin
        Item.Get(BookingHistory."Item No.");
        TrackingSpecification.Init();
        TrackingSpecification.SetItemData(BookingHistory."Item No.", Item.Description, '', '', '', 1, 1);
        TrackingSpecification.SetSource(Database::"BBL Booking History", 0, '', BookingHistory."Entry No.", '', 0);
        TrackingSpecification.SetQuantities(1, 1, 1, 1, 1, 0, 0);
    end;

    procedure ReleaseBookingHistoryLine(var BookingHistory: Record "BBL Booking History")
    var
        LineReleasedMsg: Label 'The booking line has been released.';
    begin
        BookingHistory.TestField("Line Status", BookingHistory."Line Status"::Open);
        BookingHistory.TestField("Subscription Id");
        BookingHistory.TestField("Item No.");
        BookingHistory.TestField("Serial No.");
        BookingHistory.TestField("Reservation Status", BookingHistory."Reservation Status"::" ");
        BookingHistory.Validate("Reservation Status", BookingHistory."Reservation Status"::Delivered);
        BookingHistory."Line Status" := BookingHistory."Line Status"::Released;
        BookingHistory.Modify();
        Message(LineReleasedMsg);
    end;

    procedure CheckSerialIsAvailable(BookingHistory: Record "BBL Booking History")
    var
        BookingHistory2: Record "BBL Booking History";
        BookAlreadyDeliveredErr: Label 'The serial number %1 for item %2 has already been delivered.';
    begin
        if BookingHistory."Serial No." = '' then
            exit;

        BookingHistory2.Reset();
        BookingHistory2.SetRange("Item No.", BookingHistory."Item No.");
        BookingHistory2.SetRange("Serial No.", BookingHistory."Serial No.");
        BookingHistory2.SetRange("Reservation Status", BookingHistory2."Reservation Status"::Delivered);
        if not BookingHistory2.IsEmpty then
            Error(BookAlreadyDeliveredErr, BookingHistory."Serial No.", BookingHistory."Item No.");
    end;

    procedure SetDueDateFromDeliveryDate(var BookingHistory: Record "BBL Booking History")
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        if BookingHistory."Delivery Date" = 0D then begin
            BookingHistory."Due Date" := 0D;
            exit;
        end;

        SalesSetup.Get();
        SalesSetup.TestField("BBL Reservation Period");
        BookingHistory."Due Date" := CalcDate(SalesSetup."BBL Reservation Period", BookingHistory."Delivery Date");
    end;
    #endregion


    #region [Authors]

    #endregion
}