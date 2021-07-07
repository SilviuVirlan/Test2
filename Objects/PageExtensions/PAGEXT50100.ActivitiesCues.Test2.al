pageextension 50100 "O365 Activities.ids" extends "O365 Activities"
{
    layout
    {
        addafter("Overdue Sales Invoice Amount")
        {
            field("Overdue Sales Inv. and CM"; Rec."Overdue Sales Inv. and CM")
            {
                ApplicationArea = Basic, Suite;

                trigger OnDrillDown()
                begin
                    DrillDownCalcOverdueSalesInvoiceCMAmount();
                end;
            }
        }
    }
    procedure DrillDownCalcOverdueSalesInvoiceCMAmount()
    var
        _cle: Record "Cust. Ledger Entry";
    begin
        _cle.SetFilter("Document Type", '%1|%2', _cle."Document Type"::"Credit Memo", _cle."Document Type"::Invoice);
        _cle.SetFilter("Remaining Amt. (LCY)", '<>0');
        _cle.SetFilter("Due Date", '..%1', WorkDate());
        _cle.SetRange(Open, true);
        _cle.SetCurrentKey("Remaining Amt. (LCY)");
        _cle.Ascending := false;

        PAGE.Run(PAGE::"Customer Ledger Entries", _cle);
    end;
}

// pagecustomization MyCustomization customizes "O365 Activities"
// {
//     layout
//     {
//         // Add changes to page layout here
//         modify("Overdue Sales Invoice Amount")
//         {
//             Visible = false;
//         }
//     }
// }
// pageextension 50000 PageExtension50000 extends "O365 Activities"
// {
//     layout
//     {
//         modify("Overdue Sales Invoice Amount")
//         {
//         Visible = false;
//         }
//     }
// }
