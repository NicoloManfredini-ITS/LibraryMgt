page 50103 "ITS Test API"
{
    PageType = API;
    Caption = 'TestAPI';
    APIPublisher = 'ITS';
    APIGroup = 'TestApis';
    APIVersion = 'v1.0';
    EntityName = 'TestAPIEntity';
    EntitySetName = 'TestAPIEntitySet';
    SourceTable = "Sales Line";
    DelayedInsert = true;
    
    
    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(LineType; Format(Rec.Type))
                {
                    Caption = 'Line Type';
                }
            }
        }
    }
}