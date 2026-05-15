table 50103 "BBL Publishers"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; Id; Integer)
        {
            Caption = 'Id';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Serial No."; Code[50])
        {
            Caption = 'Serial No.';

        }
    }
    
    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
    }
    
}