#Display system hardware description
"###############################System Report#########################"
function hd
{
"System Hardware description"
Get-WmiObject win32_computersystem | Format-List
"##################################################################################

"
}
hd

#Display operating system description
function os {
"Operating System description"
Get-WmiObject win32_operatingsystem|Format-List name, version
"######################################################################################

"}
os

#Display processor description
function pcr {
"Processor description"
Get-CimInstance -ClassName cim_processor | Format-List name, CurrentClockSpeed, MaxClockSpeed, numberofcores,
@{n= "L1CacheSize"; 
    e= {switch ($_.L1CacheSize) 
     { 
        $null { $val = "data unavailable"} 
        default {$val = $_.L1CacheSize } 
        }; 
        $val 
        } 
  },
@{n= "L2CacheSize";
    e= {switch ($_.L2CacheSize) 
        { 
        $null { $val = "data unavailable"} 
        default {$val = $_.L2CacheSize } 
        }; 
        $val 
        } 
  },
@{n= "L3CacheSize"; 
    e= {switch ($_.L3CacheSize) 
    { 
    $null { $val = "data unavailable"} 
    default {$val = $_.L3CacheSize } 
    }; 
    $val 
        } 
  }
"#########################################################################################


" }
pcr

#Display RAM summary
function ram {
"RAM summary"
$ramc=0
$Sysram = Get-WmiObject win32_physicalmemory 
foreach ($ram in $Sysram) {
                     new-object -typename psobject -property @{Vendor=$ram.Manufacturer
                                                               Description=$ram.Description
                                                               "Size(GB)"=$ram.Capacity / 1gb -as [int]
                                                               BankLabel= $ram.banklabel
                                                               Slot = $ram.Devicelocator
                                                               }
                                                               $ramc = $ram.capacity/1gb -as [int]
                                                               }
                                                               "
Total RAM (GB) = $($ramc)"
                            
"####################################################################################################

"
}
ram

#Display physical drive summary
function dr {
"Physical Drive summary"
$diskdrives = Get-CimInstance cim_diskdrive
foreach ($disk in $diskdrives)
{
$partitions = $disk|Get-CimAssociatedInstance -resultclassname cim_diskpartition
foreach ($partition in $partitions )
{
$logicaldisks = $partition | Get-CimAssociatedInstance -ResultClassName cim_logicaldisk
foreach ($logicaldisk in $logicaldisks)
{
New-Object -TypeName psobject -Property @{Vendor=$disk.Manufacturer
                                            Model=$disk.Model
                                          "Size(GB)"=$logicaldisk.size/1gb -as [int]
                                          "Freespace(GB)"=$logicaldisk.freespace/1gb -as [int]
                                          "Percentage free"=($logicaldisk.freespace)/($logicaldisk.size)*100
                                          }|Format-Table
}
}
}
"##################################################################################################

"}
dr

#Calling a script from lab 3 for network adapter configuration

"Network Adapter summary"
pslab3
"#########################################################################################################

"

#Display videocard summary
function vid {
"Video Card summary"
Get-WmiObject win32_videocontroller | Format-List name, description, videomodedescription
}
vid
"###########################################________END________##################################################"