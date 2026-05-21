tableextension 50101 BBLT50101 extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "BBL Subscription Period"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Subscription Period (Months)';

            trigger OnValidate()
            begin
                CheckPeriodDuration("BBL Subscription Period", Rec.FieldCaption("BBL Subscription Period"));
            end;
        }
        field(50101; "BBL Reservation Period"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Reservation Period (Months)';

            trigger OnValidate()
            begin
                CheckPeriodDuration("BBL Reservation Period", Rec.FieldCaption("BBL Reservation Period"));
            end;
        }
    }

    local procedure CheckPeriodDuration(Period: DateFormula; FieldCaption: Text)
    var
        OnlyMonthsErr: Label '%1 only supports durations in months.';
    begin
        if StrPos(Format(Period), 'M') = 0 then
            Error(OnlyMonthsErr, FieldCaption);
    end;
}


/*
Value: Integer;
String: Text;

String := 'TestStringForStrPos';
Value := StrPos(String, 'For'); // Returns 11
*/