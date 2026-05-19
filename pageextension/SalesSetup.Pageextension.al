pageextension 50100 BBLP50100 extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field("BBL Subscription Duration"; Rec."BBL Subscription Duration")
            {
                ApplicationArea = All;
            }
        }
    }
}