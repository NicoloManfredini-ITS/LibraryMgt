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
                field("Entry No."; Rec."Entry No.") {  }
                field("Item No."; Rec."Item No.") {  }
                field("Serial No."; Rec."Serial No.") 
                { 
                    trigger OnAssistEdit()                        
                    begin
                        OpenTracking();
                    end;
                 }
                field("Subscription Id"; Rec."Subscription Id") {  }
                field("Posting Date"; Rec."Posting Date") {  }
                field("Due Date"; Rec."Due Date") {  }
                field("Deliver Status"; Rec."Deliver Status") {  }
                field("Return Status"; Rec."Return Status") {  }
            }
        }
    }

    var
        ITH: Page "Item Tracking Lines";

    procedure InitFromBookingHistory(BookingHistory: Record "BBL Booking History"; var TrackingSpecification: Record "Tracking Specification")
    var
        Item: Record Item;
    begin
        Item.Get(BookingHistory."Item No.");
        TrackingSpecification.Init();
        TrackingSpecification.SetItemData(BookingHistory."Item No.", Item.Description, '', '', '', 1, 1);
        TrackingSpecification.SetSource(Database::"BBL Booking History", 0, '', BookingHistory."Entry No.", '', 0);
        TrackingSpecification.SetQuantities(1, 1, 1, 1, 1, 0, 0);
    end;

    local procedure OpenTracking()
    var
        TrackingSpecification: Record "Tracking Specification";
        ItemTrackingLines: Page "Item Tracking Lines";
        ItemTrackingDataCollection: Codeunit "Item Tracking Data Collection";
    begin
        InitFromBookingHistory(Rec, TrackingSpecification);
        
        ItemTrackingDataCollection.AssistEditTrackingNo(TrackingSpecification, true, -1, "Item Tracking Type"::"Serial No.", 1);
        Rec."Serial No." := TrackingSpecification."Serial No.";
        Rec.Modify();
        CurrPage.Update();
    end;
}