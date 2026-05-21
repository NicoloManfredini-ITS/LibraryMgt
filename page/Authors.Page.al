page 50100 Authors
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BBL Authors";
    Caption = 'Authors';
        
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
                RunObject = Page "Item List";
                RunPageMode = View;
                RunPageLink = "BBL Author" = field("Full Name");
                RunPageView = sorting("BBL Publication Year");
                Image = List;
            }
        }
    }
}