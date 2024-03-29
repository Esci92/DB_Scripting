[void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms.DataVisualization")
$chartSavePath = 'C:\MonitorCPUusage'
 
# Creating chart object
# The System.Windows.Forms.DataVisualization.Charting namespace contains methods and properties for the Chart Windows forms control.
   $chartobject = New-object System.Windows.Forms.DataVisualization.Charting.Chart
   $chartobject.Width = 800
   $chartobject.Height =800
   $chartobject.BackColor = [System.Drawing.Color]::orange
 
# Set Chart title 
   [void]$chartobject.Titles.Add("dotnet-helpers chart-Memory Usage")
   $chartobject.Titles[0].Font = "Arial,13pt"
   $chartobject.Titles[0].Alignment = "topLeft"
 
# create a chartarea to draw on and add to chart
   $chartareaobject = New-Object System.Windows.Forms.DataVisualization.Charting.ChartArea
   $chartareaobject.Name = "ChartArea1"
   $chartareaobject.AxisY.Title = "dotnet-helpers chart - Memory"
   $chartareaobject.AxisX.Title = "dotnet-helpers chart - ProcessName"
   $chartareaobject.AxisY.Interval = 100
   $chartareaobject.AxisX.Interval = 1
   $chartobject.ChartAreas.Add($chartareaobject)
 
# Creating legend for the chart
   $chartlegend = New-Object system.Windows.Forms.DataVisualization.Charting.Legend
   $chartlegend.name = "Legend1"
   $chartobject.Legends.Add($chartlegend)
 
# Get the top 5 process using in our system
   $topCPUUtilization = Get-Process | sort PrivateMemorySize -Descending  | Select-Object -First 5
 
# data series
   [void]$chartobject.Series.Add("VirtualMemory")
   $chartobject.Series["VirtualMemory"].ChartType = "Column"
   $chartobject.Series["VirtualMemory"].BorderWidth  = 3
   $chartobject.Series["VirtualMemory"].IsVisibleInLegend = $true
   $chartobject.Series["VirtualMemory"].chartarea = "ChartArea1"
   $chartobject.Series["VirtualMemory"].Legend = "Legend1"
   $chartobject.Series["VirtualMemory"].color = "#00bfff"
   $topCPUUtilization | ForEach-Object {$chartobject.Series["VirtualMemory"].Points.addxy( $_.Name , ($_.VirtualMemorySize / 1000000)) }
 
# data series
   [void]$chartobject.Series.Add("PrivateMemory")
   $chartobject.Series["PrivateMemory"].ChartType = "Column"
   $chartobject.Series["PrivateMemory"].IsVisibleInLegend = $true
   $chartobject.Series["PrivateMemory"].BorderWidth  = 3
   $chartobject.Series["PrivateMemory"].chartarea = "ChartArea1"
   $chartobject.Series["PrivateMemory"].Legend = "Legend1"
   $chartobject.Series["PrivateMemory"].color = "#bf00ff"
   $topCPUUtilization | ForEach-Object {$chartobject.Series["PrivateMemory"].Points.addxy( $_.Name , ($_.PrivateMemorySize / 1000000)) }
 
# save chart with the Time frame for identifying the usage at the specific time
   $chartobject.SaveImage("$chartSavePath\CPUusage_$(get-date -format `"yyyyMMdd_hhmmsstt`").png","png")