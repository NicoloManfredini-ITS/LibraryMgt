table 50105 "BBL Subscription"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Subscription Id"; Guid)
        {
            Caption = 'Subscription Id';
            Editable = false;
        }
        field(2; "Customer No."; code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";

        }
        field(3; "Membership Date"; Date)
        {
            Caption = 'Membership Date';
            trigger OnValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
            begin
                //quando cambio il valore di subscription date Verifico se è vuota o no, se non è vuota calcola la data di scadenza, se è vuota allora cancella la data di scadenza

                if rec."Membership Date" <> 0D then begin
                    SalesSetup.Get();// si usa in certi cas, piu veloce dei find, ma è piu limitata,. Sfrutta la chiave primaria per leggere un record specific
                    SalesSetup.TestField("BBL Subscription Period");// Testfield serve a testare dei campi, per verificare che il cmpo sia valorizzato o con ubn valore specifico o che non sia vuoto
                    "Membership Expiration" := CalcDate(SalesSetup."BBL Subscription Period", rec."Membership Date")
                end //importante fare le cose parametriche
                else
                    "Membership Expiration" := 0D;
            end;
        }

        field(4; "Membership Expiration"; Date)
        {
            Caption = 'Membership Expiration';

        }

        field(5; "No.Books Taken"; Integer)
        {
            Caption = 'Number Of Books Booked';
            FieldClass = FlowField;
            CalcFormula = count("BBL Booking History" where("Subscription Id" = field("Subscription Id")));
            Editable = false;
        }

        field(6; "No.Books Returned"; Integer)
        {
            Caption = 'Number Of Books Returned';
            FieldClass = FlowField;
            CalcFormula = count("BBL Booking History" where("Subscription Id" = field("Subscription Id")));
            Editable = false;
        }

    }
    keys
    {
        key(Key1; "Customer No.")
        {
            Clustered = true;
        }
    }

}