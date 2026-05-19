tableextension 50101 BBLT50101 extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "BBL Subscription Duration"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Subscription Duration';
        }
    }
}