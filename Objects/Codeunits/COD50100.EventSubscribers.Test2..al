codeunit 50100 "Event Subscriptions"
{
    [EventSubscriber(ObjectType::Page, Page::"O365 Activities", 'OnOpenPageEvent', '', true, false)]
    local procedure CalcOverdueSalesInvCM(var Rec: Record "Activities Cue")
    var
        _cle: Record "Cust. Ledger Entry";
        _totAmt: decimal;
    begin
        _cle.SetFilter("Document Type", '%1|%2', _cle."Document Type"::"Credit Memo", _cle."Document Type"::Invoice);
        _cle.SetFilter("Due Date", '..%1', WorkDate());
        _cle.SetRange(Open, true);
        _cle.SetAutoCalcFields("Remaining Amt. (LCY)");
        if _cle.FindSet() then
            repeat
                _totAmt += _cle."Remaining Amt. (LCY)";
            until _cle.Next() = 0;
        Rec."Overdue Sales Inv. and CM" := _totAmt;
        Rec.Modify;
    end;
}