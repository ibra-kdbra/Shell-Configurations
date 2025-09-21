# Intune Patch Compliance Calculator

A PowerShell script that generates comprehensive Windows patch compliance reports for Intune-managed devices.

## Overview

This script analyzes Intune device data against Microsoft's official patch release history to determine patch compliance status. It automatically downloads the latest Windows update information and compares device OS versions to identify compliant vs non-compliant devices.

## Features

- **Automatic Data Collection**: Downloads Microsoft's official patch release history
- **Comprehensive Analysis**: Checks Windows 7 through Windows 11 patch compliance
- **Intune Integration**: Processes exported Intune device CSV data
- **Detailed Reporting**: Provides compliance percentages, patch gaps, and required updates
- **Storage Information**: Includes device storage capacity reporting
- **Check-in Monitoring**: Tracks device last check-in times

## Prerequisites

- Windows PowerShell 5.0 or later
- Internet access (for downloading Microsoft patch data)
- Exported Intune device data in CSV format
- Administrative privileges for PowerShell execution

## Input Requirements

### Intune Device Export

Export device data from Microsoft Intune admin center with the following required columns:
- Device ID
- Serial number
- Device name
- Ownership (Corporate, Personal)
- OS version
- Primary user UPN
- Last check-in
- JoinType (Azure AD Joined, etc.)
- Manufacturer
- Model
- Managed by
- SkuFamily
- Total storage (bytes)
- Free storage (bytes)

### CSV File Format

Save the exported data as `D.csv` (recommended) or update the `$DeviceList` variable in the script.

## Configuration

Update these variables in the script before running:

```powershell
# Path to Intune device export CSV
$DeviceList = "C:\TEMP\IntunePatchingReport\D.csv"

# Working directory for temporary files and final report
$WorkingFolder = "C:\TEMP\IntunePatchingReport"
```

## Usage

1. **Prepare Device Data**: Export Intune devices to CSV format
2. **Configure Paths**: Update `$DeviceList` and `$WorkingFolder` variables
3. **Run Script**: Execute with administrative privileges

```powershell
# Set execution policy (required for first run)
Set-ExecutionPolicy -ExecutionPolicy 'ByPass' -Scope 'Process' -Force

# Run the script
.\Manually_Create_Intune_Patch_Compliance_Calculation_Using_PowerShell.ps1
```

## Output Files

The script generates a final compliance report at:

```
$WorkingFolder\Final_Patching_Report.csv
```

### Report Columns

| Column | Description |
|--------|-------------|
| DeviceName | Device display name |
| Serialnumber | Device serial number |
| PrimaryUserUPN | Primary user email address |
| Ownership | Corporate/Personal ownership |
| JoinType | Azure AD join type |
| Manufacturer | Hardware manufacturer |
| Model | Device model |
| Managedby | Management authority (Intune, SCCM, etc.) |
| Totalstorage (GB) | Total storage capacity |
| Freestorage (GB) | Available free storage |
| Lastcheckin | Last Intune check-in date/time |
| SkuFamily | Windows SKU family |
| OSVersion | Formatted OS version (e.g., Win10-22H2) |
| OS | Full OS version (e.g., 10.0.19045.3803) |
| InstalledKB | Currently installed KB/patch |
| PatchType | Patch Tuesday, Preview, or Out-of-Band updates |
| InstalledKB_ReleaseDate | KB release date |
| PatchingStatus | Compliant/Non-Compliant status |
| DevcieNotPatchSince_InDays | Days since last patch or "Compliant" |
| Latest_RequiredPatch | Required patch KB numbers |
| RequiredPatchRD | Required patch release date |

## Process Phases

### Phase 1: Device Data Import
- Imports and validates Intune CSV device data
- Maps CSV columns to script variables
- Prepares device information for analysis

### Phase 2: Microsoft Patch Data Collection
- Downloads Windows update history from Microsoft support pages
- Filters patch releases by type (Patch Tuesday, Preview, Out-of-Band)
- Creates comprehensive patch database
- Determines latest available patches per OS build

### Phase 3: Compliance Analysis
- Compares each device's OS version against latest patches
- Calculates patch age and compliance gaps
- Generates detailed compliance reports
- Provides executive summary with compliance percentages

## Supported Windows Versions

The script supports Windows versions from Windows 7 through Windows 11:

- Windows 7 (Build 7601)
- Windows 8.1 (Build 9600)
- Windows 10 (All versions: 1507, 1511, 1607, 1703, 1709, 1803, 1809, 1903, 1909, 2004, 20H2, 21H1, 21H2, 22H2)
- Windows 11 (All versions: 21H2, 22H2, 23H2, 24H2)

## Patch Compliance Logic

### Compliant Status
- Device OS version matches or exceeds latest available patch for that build
- Patch is identified as a Patch Tuesday release

### Non-Compliant Status
- Device OS build is older than latest patch for that build family
- Identifies specific required KB numbers and release dates
- Calculates days since device should have been patched

### Manual Check Status
- Preview or Out-of-Band updates detected
- Incomplete device data requires manual verification

## Security Considerations

- **Execution Policy**: Script requires `RemoteSigned` or `Bypass` execution policy
- **Internet Access**: Required for downloading Microsoft patch data
- **File Permissions**: Working folder must be writable
- **Data Privacy**: Contains device and user information - secure output appropriately

## Troubleshooting

### Common Issues

**"Access denied" or execution blocked**
```powershell
# Fix execution policy
Set-ExecutionPolicy -ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser'
```

**"Cannot find file" errors**
- Verify CSV file path and permissions
- Ensure working folder is writable
- Check for special characters in file paths

**"No updates found" or empty reports**
- Verify internet connectivity for downloading patch data
- Check Microsoft support site availability
- Review device CSV format matches expected columns

**Performance issues with large device sets**
- Script processes devices sequentially
- Progress bar displays completion status
- Typical run time: 5-15 minutes for 100-1000 devices

### Error Messages

- **"Import-Csv : Cannot validate argument"**: CSV file missing required columns or malformed
- **"Invoke-WebRequest : Unable to connect"**: No internet access or Microsoft sites unreachable
- **"Access to path denied"**: Insufficient permissions to write output files

## Output Examples

### Compliance Summary
```
Total Device Count: 250
Total Compliant Device Count: 180
Total Manually Check Required Patch Device Count: 25
Total Non-Compliant Device Count: 45

Patching Compliance Percentage: 72.00%
```

### Report Location
```
C:\TEMP\IntunePatchingReport\Final_Patching_Report.csv
```

## Maintenance

- **Patch Data Updates**: Script downloads fresh data each run
- **Windows Support**: Update OS build arrays as new Windows versions release
- **CSV Schema Changes**: Monitor Intune for export column changes

## Support

For issues or questions:
- Check Microsoft Intune admin center for latest console changes
- Verify PowerShell and .NET Framework versions
- Test connectivity to Microsoft update history URLs
- Ensure exported CSV includes all required columns

## Version History

- **Current**: Includes Windows 11 24H2 and 23H2 support
- **Previous**: Added Windows 11 22H2 compatibility
- **Initial**: Core Intune patch compliance functionality
