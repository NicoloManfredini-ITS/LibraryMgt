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
        LibraryBooks: Record "BBL Library Books";
        BooksExistsErr: Label 'Cannot delete author %1 because there are %2 books associated with this author.';
        TestCaption: Label 'Test Caption';
    begin
        LibraryBooks.Reset();
        LibraryBooks.SetFilter(Author, '%1', Rec."Full Name");
        if not LibraryBooks.IsEmpty() then
            Error(BooksExistsErr, Rec."Full Name", LibraryBooks.Count());

        LibraryBooks.FindFirst();
        LibraryBooks.FindLast();
        LibraryBooks.FindSet();
        LibraryBooks.FindSet(true);
        if LibraryBooks.IsEmpty() then;
    end;
}