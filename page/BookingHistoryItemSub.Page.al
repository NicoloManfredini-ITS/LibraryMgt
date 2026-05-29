//Crea una pagina di tipo lista con i campi della booking history
page 50105 "BBL Booking History Item Sub."
{
    Caption = 'Booking History';
    PageType = ListPart;
    SourceTable = "BBL Booking History";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Serial No."; Rec."Serial No.") { }
                field("Subscription Id"; Rec."Subscription Id") { }
                field("Delivery Date"; Rec."Delivery Date") { }
                field("Due Date"; Rec."Due Date") { }
                field("Reservation Status"; Rec."Reservation Status") { }
                field("Reserv. Status Date"; Rec."Reserv. Status Date") { }
                field("Reserv. Status User Id"; Rec."Reserv. Status User Id") { }
            }
        }
    }
}