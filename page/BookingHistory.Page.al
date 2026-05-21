//Crea una pagina di tipo lista con i campi della booking history
page 50104 "BBL Booking History List"
{
    PageType = List;
    SourceTable = "BBL Booking History";
    ApplicationArea = All;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Entry No."; Rec."Entry No.") { }
                field("Item No."; Rec."Item No.")
                {
                    Editable = FieldEditable;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Editable = FieldEditable;

                    trigger OnAssistEdit()
                    var
                        CustomMgt: Codeunit "BBL Custom Mgt.";
                    begin
                        CustomMgt.OpenTrackingFromBookingHistory(Rec);
                        CurrPage.Update();
                    end;
                }
                field("Subscription Id"; Rec."Subscription Id")
                {
                    Editable = FieldEditable;
                }
                field("Delivery Date"; Rec."Delivery Date") { }
                field("Due Date"; Rec."Due Date") { }
                field("Reservation Status"; Rec."Reservation Status") { }
                field("Reserv. Status Date"; Rec."Reserv. Status Date") { }
                field("Reserv. Status User Id"; Rec."Reserv. Status User Id") { }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;

                trigger OnAction()
                var
                    CustomMgt: Codeunit "BBL Custom Mgt.";
                begin
                    CustomMgt.ReleaseBookingHistoryLine(Rec);
                    SetEditability();
                    CurrPage.Update();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditability();
    end;

    var
        FieldEditable: Boolean;

    local procedure SetEditability()
    begin
        FieldEditable := Rec."Line Status" = Rec."Line Status"::Open;
    end;
}