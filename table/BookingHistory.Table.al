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
            var
                CustomMgt: Codeunit "BBL Custom Mgt.";
            begin
                CustomMgt.CheckSerialIsAvailable(Rec);
            end;
        }
        field(4; "Subscription Id"; Guid)
        {
            Caption = 'Subscription Id';
            TableRelation = "BBL Subscription"."Subscription Id";
        }
        field(5; "Delivery Date"; Date)
        {
            Caption = 'Delivery Date';
            Editable = false;

            trigger OnValidate()
            var
                CustomMgt: Codeunit "BBL Custom Mgt.";
            begin
                CustomMgt.SetDueDateFromDeliveryDate(Rec);
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

}

/*
Value: Date;
Value := CalcDate('1M', 20240101D) // Returns 20240201D
Value := CalcDate('1M+CM', 20240101D) // Returns 20240228D
*/