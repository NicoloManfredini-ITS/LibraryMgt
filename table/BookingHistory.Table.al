//crea una tabella con i seguenti campi: Entry No., Item No., Serial No., Subscription Id, Delivery Date, Due Date, Reservation Status, Status Date
table 50102 "BBL Booking History"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(3; "Serial No."; Code[50])
        {
            Caption = 'Serial No.';
        }
        field(4; "Subscription Id"; Code[20])
        {
            Caption = 'Subscription Id';
            TableRelation = "BBL Subscription"."Subscription Id";
        }
        field(5; "Delivery Date"; Date)
        {
            Caption = 'Delivery Date';
        }
        field(6; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(7; "Reservation Status"; Option)
        {
            Caption = 'Reservation Status';
            OptionMembers = " ",Delivered,Returned,Cancelled,Lost;
            OptionCaption = ' ,Delivered,Returned,Cancelled,Lost';
        }
        field(8; "Reserv. Status Date"; Date)
        {
            Caption = 'Status Date';
            Editable = false;
        }
        field(10; "Line Status"; Option)
        {
            Caption = 'Line Status';
            OptionMembers = Open,Released;
            OptionCaption = 'Open,Released';
            Editable = false;
        }
    }
    
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        CheckFieldsOnInsert();
    end;

    trigger OnModify()
    begin
        Rec.TestField("Line Status", Rec."Line Status"::Open);
    end;

    local procedure CheckFieldsOnInsert()
    begin
        Rec.TestField("Subscription Id");
        Rec.TestField("Item No.");
        Rec.TestField("Serial No.");
        CheckSerialIsAvailable();
    end;

    local procedure CheckSerialIsAvailable()
    var
        BookingHistory: Record "BBL Booking History";
        BookAlreadyDeliveredErr: Label 'The serial number %1 for item %2 has already been delivered.';
    begin
        BookingHistory.Reset();
        BookingHistory.SetRange("Item No.", Rec."Item No.");
        BookingHistory.SetRange("Serial No.", Rec."Serial No.");
        BookingHistory.SetRange("Reservation Status", "Reservation Status"::Delivered);
        if not BookingHistory.IsEmpty then
            Error(BookAlreadyDeliveredErr, Rec."Serial No.", Rec."Item No.");
    end;
}