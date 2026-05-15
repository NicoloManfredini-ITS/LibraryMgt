page 50101 "BBL Library Books"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BBL Library Books";
    
    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Title"; Rec.Title) {}
                field("Author"; Rec.Author) {
                    
                }
                field("Publication Year"; Rec."Publication Year") {}
                field("Genre"; Rec.Genre) {}
                field("Is Available"; Rec."Is Available") {}
                field("Status"; Rec.Status) {}
            }
        }
    }   
}