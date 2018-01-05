param (
    [string]$infile = ""
)

Function ExcelToCSV ([string]$File)
{ 
    $excelFile = "$pwd\" + $File + ".xlsx"
    $Excel = New-Object -ComObject Excel.Application
    $Excel.Visible = $false
    $Excel.DisplayAlerts = $false
    $wb = $Excel.Workbooks.Open($excelFile)
    foreach ($ws in $wb.Worksheets)
    {
        $ws.SaveAs("$pwd\" + $File + "_" + ($ws.name) + ".csv", 6)
    }
    $Excel.Quit()
}

ExcelToCSV -File "$infile"
#(Get-Content ).replace(';', ',') | Set-Content c:\temp\test.txt