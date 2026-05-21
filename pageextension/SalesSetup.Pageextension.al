pageextension 50100 BBLP50100 extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field("BBL Subscription Period"; Rec."BBL Subscription Period")
            {
                ApplicationArea = All;
            }
            field("BBL Reservation Period"; Rec."BBL Reservation Period")
            {
                ApplicationArea = All;
            }
        }
    }
}