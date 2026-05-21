//crea una tabella con i seguenti campi: Entry No., Item No., Serial No., Subscription Id, Delivery Date, Due Date, Reservation Status, Status Date
table 50102 "BBL Booking History"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;

            trigger OnValidate()
            begin
                if Rec."Item No." <> xRec."Item No." then
                    Rec.Validate("Serial No.", '');
            end;
        }
        field(3; "Serial No."; Code[50])
        {
            Caption = 'Serial No.';

            trigger OnValidate()
            begin
                CheckSerialIsAvailable();
            end;
        }
        field(4; "Subscription Id"; Code[20])
        {
            Caption = 'Subscription Id';
            TableRelation = "BBL Subscription"."Subscription Id";
        }
        field(5; "Delivery Date"; Date)
        {
            Caption = 'Delivery Date';
            Editable = false;

            trigger OnValidate()
            begin
                SetDueDateFromDeliveryDate();
            end;
        }
        field(6; "Due Date"; Date)
        {
            Caption = 'Due Date';
            Editable = false;
        }
        field(7; "Reservation Status"; Option)
        {
            Caption = 'Reservation Status';
            OptionMembers = " ",Delivered,Returned,Cancelled,Lost;
            OptionCaption = ' ,Delivered,Returned,Cancelled,Lost';

            trigger OnValidate()
            begin
                if Rec."Reservation Status" = Rec."Reservation Status"::Delivered then
                    Rec.Validate("Delivery Date", Today());
                Rec.Validate("Reserv. Status Date", Today());
                Rec.Validate("Reserv. Status User Id", UserId());
            end;
        }
        field(8; "Reserv. Status Date"; Date)
        {
            Caption = 'Reservation Status Date';
            Editable = false;
        }
        field(9; "Reserv. Status User Id"; Code[30])
        {
            Caption = 'Reservation Status User Id';
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

    trigger OnModify()
    begin
        //if CurrFieldNo <> Rec.FieldNo("Reservation Status") then
        //Rec.TestField("Line Status", Rec."Line Status"::Open);
    end;

    local procedure CheckSerialIsAvailable()
    var
        BookingHistory: Record "BBL Booking History";
        BookAlreadyDeliveredErr: Label 'The serial number %1 for item %2 has already been delivered.';
    begin
        if Rec."Serial No." = '' then
            exit;

        BookingHistory.Reset();
        BookingHistory.SetRange("Item No.", Rec."Item No.");
        BookingHistory.SetRange("Serial No.", Rec."Serial No.");
        BookingHistory.SetRange("Reservation Status", "Reservation Status"::Delivered);
        if not BookingHistory.IsEmpty then
            Error(BookAlreadyDeliveredErr, Rec."Serial No.", Rec."Item No.");
    end;

    local procedure SetDueDateFromDeliveryDate()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        if Rec."Delivery Date" = 0D then begin
            Rec."Due Date" := 0D;
            exit;
        end;

        SalesSetup.Get();
        SalesSetup.TestField("BBL Reservation Period");
        Rec."Due Date" := CalcDate(SalesSetup."BBL Reservation Period", Rec."Delivery Date");
    end;

    procedure ReleaseLine()
    var
        LineReleasedMsg: Label 'The booking line has been released.';
    begin
        Rec.TestField("Line Status", "Line Status"::Open);
        Rec.TestField("Subscription Id");
        Rec.TestField("Item No.");
        Rec.TestField("Serial No.");
        Rec.TestField("Reservation Status", "Reservation Status"::" ");
        Rec.Validate("Reservation Status", "Reservation Status"::Delivered);
        Rec."Line Status" := Rec."Line Status"::Released;
        Rec.Modify();
        Message(LineReleasedMsg);
    end;
}

/*
Value: Date;
Value := CalcDate('1M', 20240101D) // Returns 20240201D
Value := CalcDate('1M+CM', 20240101D) // Returns 20240228D
*/