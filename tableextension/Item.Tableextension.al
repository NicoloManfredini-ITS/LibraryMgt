tableextension 50100 BBLT50100 extends Item
{
    fields
    {
        field(50100; "BBL Author"; Text[100])
        {
            Caption = 'Author';
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
        field(50103; Title; Text[100])
        {            
            Caption = 'Title';
            trigger OnValidate()
            var
                TitleValidationErr: Label 'Title cannot be empty.';
            begin
                if (Rec.Title = '') and (xRec.Title <> '') then
                    Error(TitleValidationErr);
            end;
        }
        field(50104; "BBL Publication Year"; Integer)
        {            
            Caption = 'Publication Year';
        }
        field(50105; "BBL Genre"; Text[50])
        {            
            Caption = 'Genre';
        }
    }

    keys
    {
        key(BBLKey1; "BBL Publication Year") { }
    }
}