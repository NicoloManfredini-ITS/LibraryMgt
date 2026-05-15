tableextension 50100 BBLT50100 extends Item
{
    fields
    {
        field(50100; "BBL Author"; Text[100])
        {
            Caption = 'Author';
            // TableRelation = "Sales Header"."No." where("Document Type" = filter(order|quote));
            // TableRelation = "Sales Header"."Sell-to Customer No." where("Document Type" = filter(order|quote));
            TableRelation = "BBL Authors"."Full Name";
        }
        field(50101; "BBL Publisher"; Text[100])
        {
            Caption = 'Publisher';
            TableRelation = "BBL Publishers".Name;
        }
        field(50102; "BBL No. of Pages"; Integer)
        {
            Caption = 'No. of Pages';
        }
    }
}