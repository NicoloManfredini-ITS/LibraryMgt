page 50100 Authors
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BBL Authors";
    
    
    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Full Name"; Rec."Full Name") {} 
            }
        }
    }
    
    actions
    {
        area(Processing)
        { }
        area(Navigation)
        {
            action(AuthorBooks)
            {
                Caption = 'Author Books';
                RunObject = Page "BBL Library Books";
                RunPageMode = View;
                RunPageLink = Author = field("Full Name");
                RunPageView = sorting("Publication Year");
                Image = List;
            }
        }
        area(Reporting)
        { }
    }
}