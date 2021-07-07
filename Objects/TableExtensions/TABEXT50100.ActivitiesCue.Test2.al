tableextension 50100 "Activities Cue.IDS" extends "Activities Cue"
{
    fields
    {
        field(50000; "Overdue Sales Inv. and CM"; Decimal)
        {
            Caption = 'Overdue Sales Inv. + CM';
            AutoFormatExpression = GetAmountFormat;
            AutoFormatType = 11;
            DecimalPlaces = 0 : 0;
        }
    }
}

