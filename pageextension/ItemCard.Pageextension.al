pageextension 50101 NVSP50101 extends "Item Card"
{
    layout
    {
        addafter(Item)
        {
            part(BBLBookingHistoryItemSub; "BBL Booking History Item Sub.")
            {
                Caption = 'Booking History';
                ApplicationArea = All;
                SubPageLink = "Item No." = field("No.");
                Editable = false;
            }
        }
    }
}