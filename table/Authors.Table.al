table 50101 "BBL Authors"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Id"; Integer)
        {
            Caption = 'Id';
        }
        field(2; "Full Name"; Text[100])
        {
            Caption = 'Full Name';
        }
    }
    
    keys
    {
        key(Key1; "Id")
        {
            Clustered = true;
        }
    }
    
    fieldgroups
    {
        fieldgroup(Dropdown; "Full Name") { }
    }

    trigger OnDelete()
    var
        Item: Record Item;
        BooksExistsErr: Label 'Cannot delete author %1 because there are %2 books associated with this author.';
        TestCaption: Label 'Test Caption';
    begin
        Item.Reset();
        Item.SetFilter("BBL Author", '%1', Rec."Full Name");
        if not Item.IsEmpty() then
            Error(BooksExistsErr, Rec."Full Name", Item.Count());

        /*
        Item.FindFirst();
        Item.FindLast();
        Item.FindSet();
        Item.FindSet(true);
        if Item.IsEmpty() then;
        */
    end;
}