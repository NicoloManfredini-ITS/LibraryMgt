/*
table 50100 "BBL Library Books"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Book Id"; Guid)
        {            
            Caption = 'Book Id';
        }
        field(2; Title; Text[100])
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
        field(3; Author; Text[100])
        {            
            Caption = 'Author';
            TableRelation = "BBL Authors"."Full Name";
        }
        field(4; "Publication Year"; Integer)
        {            
            Caption = 'Publication Year';
        }
        field(5; Genre; Text[50])
        {            
            Caption = 'Genre';
        }
        field(6; "Is Available"; Boolean)
        {            
            Caption = 'Is Available';
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Available, Reserved, Lost, Sold;
        }
    }
    
    keys
    {
        key(PK; "Book Id")
        {
            Clustered = true;
        }
        key(Key2; Title) { }
        key(Key3; Author, "Publication Year") { }
    }

    var
        ILE: Record "Item Ledger Entry";
    
    trigger OnInsert()
    var
        BookInsertedMsg: Label 'Book record inserted: %1 published by %2';
    begin
        Message(BookInsertedMsg, Title, Author);
    end;
    
    trigger OnModify()
    var
        BookModifiedMsg: Label 'Book record modified. Author changed from %1 to %2';
        TestCaption2: Label 'Test Caption 2';
    begin
        if Rec.Author <> xRec.Author then
            Message(BookModifiedMsg, xRec.Author, Rec.Author);
    end;
    
    trigger OnDelete()
    begin
        CheckAvailability();
    end;
    
    procedure CheckAvailability(): Boolean
    var
        BookReservedErr: Label '%1 is reserved, cannot delete.';
    begin
        if Rec.Status = Rec.Status::Reserved then
            Error(BookReservedErr, Title);
    end;

    

}
*/