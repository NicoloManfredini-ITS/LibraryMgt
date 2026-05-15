//crea una tabella con i seguenti campi: Entry No., Item No., Serial No., Subscription Id, Posting Date, Due Date, Deliver Status, Return Status
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
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(6; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(7; "Deliver Status"; Option)
        {
            Caption = 'Deliver Status';
            OptionMembers = Pending, Delivered, Cancelled;
        }
        field(8; "Return Status"; Option)
        {
            Caption = 'Return Status';
            OptionMembers = NotReturned, Returned, Late;
        }
        
    }
    
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}