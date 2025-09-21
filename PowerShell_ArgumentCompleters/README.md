# PowerShell Argument Completers

A comprehensive collection of PowerShell argument completers derived from [TabExpansionPlusPlus](https://github.com/lzybkr/TabExpansionPlusPlus/), updated to use PowerShell's built-in `Register-ArgumentCompleter` cmdlet.

## Overview

This PowerShell module provides intelligent tab completion for hundreds of PowerShell commands and parameters. Instead of just completing command names, these completers intelligently suggest parameter values and options based on context.

## Features

- **Context-aware completions**: Suggestions based on current command and parameters
- **Extensive coverage**: 40+ completer files covering core PowerShell and specialized modules
- **Fast loading**: Modular design allows selective loading to optimize startup time
- **Cross-platform compatible**: Works with Windows PowerShell and PowerShell Core

## Prerequisites

- **PowerShell 5.0+** for Windows PowerShell, or **PowerShell Core 6.0+**
- **Administrative privileges** recommended for optimal functionality
- **Module must be in `$env:PSModulePath`** or loaded from explicit path

## Installation

### Option 1: PowerShellGet (Recommended)

```powershell
Install-Module -Name ArgumentCompleters -Scope CurrentUser
```

### Option 2: Manual Installation

1. **Clone/Download**: Copy the module directory to a location in your `$env:PSModulePath`
2. **Standard locations**:
   - `%USERPROFILE%\Documents\WindowsPowerShell\Modules\ArgumentCompleters\` (Windows PowerShell)
   - `%USERPROFILE%\Documents\PowerShell\Modules\ArgumentCompleters\` (PowerShell Core)
   - `/usr/local/share/powershell/Modules/` (Linux/macOS with PowerShell Core)

3. **Import the module** (add to your PowerShell profile):
   ```powershell
   Import-Module ArgumentCompleters
   ```

4. **Persistent loading**: Add the import command to your PowerShell profile:
   ```powershell
   notepad $PROFILE
   # Add: Import-Module ArgumentCompleters
   ```

### Option 3: Basic Import (No Installation)

```powershell
# Import directly from path (substitute actual path)
Import-Module "C:\Path\To\ArgumentCompleters\ArgumentCompleters.psd1"
```

## Usage

Completers activate automatically after module import. Simply use Tab completion as you normally would:

### Examples

```powershell
# Get-Command parameters
Get-Command -Verb <TAB>  # Completes with available verbs: Add, Clear, Convert, etc.

# Help system completions
Get-Help -<TAB>  # Completes parameter names: -Category, -Component, etc.

# Scope parameter completions
Get-Variable -Scope <TAB>  # Completes with: Global, Local, Script, Private

# Network adapter completions
Get-NetAdapter -<TAB>  # Completes parameter names for networking cmdlets
```

### Performance Optimization

For faster startup, selectively load only the completers you need:

```powershell
# Load only specific completers
$completers = @(
    'Microsoft.PowerShell.Core.ps1',
    'Microsoft.PowerShell.Management.ps1',
    'NetAdapter.ps1'
)
foreach ($completer in $completers) {
    . "$PSScriptRoot\Completers\$completer"
}
```

## Supported Completers

### Core PowerShell (Microsoft.PowerShell.*)
- **Core**: Commands like `Get-Command`, `Get-Help`, sessions, providers
- **Management**: File system, registry, processes, services, event logs
- **Utility**: Encoding, CSV handling, XML operations
- **Diagnostics**: Debugging, tracing, performance counters
- **LocalAccounts**: User and group management (Windows 10/Server)
- **Security**: Security descriptors, access control

### Specialized Modules
- **Hyper-V**: Virtual machine and host management
- **NetAdapter**: Network interface configuration
- **NetSecurity**: Firewall, IPsec, network security
- **NetTCPIP**: TCP/IP settings, DNS, routes
- **SmbShare**: SMB file and printer sharing
- **ScheduledTasks**: Task Scheduler management
- **PrintManagement**: Printer configuration

### Server Administration
- **DHCP**: DHCP server management
- **DNS**: DNS server and client configuration
- **FailoverClusters**: Cluster management and migration
- **GroupPolicy**: GPO management and analysis
- **PnpDevice**: Plug and Play device management
- **Storage**: Storage pools, volumes, disks
- **DNSServer**: DNS server administration

### Application Specific
- **Appx**: UWP app package management
- **BitsTransfer**: Background Intelligent Transfer Service
- **CimCmdlets**: CIM/WMI operations
- **DFS**: Distributed File System
- **DisM**: Windows image servicing
- **ISE**: PowerShell ISE integration
- **Microsoft.Azure***: Azure PowerShell module completions
- **PowerShellDirect**: VM direct session management
- **RoboCopy**: Advanced file copy completions
- **WDAC**: Windows Defender Application Control
- **Winget**: Windows Package Manager

### Additional Features
- **Hexo**: Static site generation
- **PowerShellWebAccess**: Web console management

## Compatibility

| PowerShell Version | Status | Notes |
|-------------------|--------|-------|
| Windows PowerShell 5.0+ | ✅ Fully supported | All completers functional |
| PowerShell Core 6.0+ | ✅ Fully supported | Cross-platform where applicable |
| PowerShell 7.x | ✅ Fully supported | Enhanced functionality |

### Platform Considerations

- **Windows-only completers**: Certain modules like Hyper-V, DHCP, DNS Server, Storage Spaces require Windows
- **PowerShell Core limitations**: Some Windows-specific cmdlets may not be available
- **Cross-platform**: Networking, utility, and core PowerShell completers work on all platforms

## Troubleshooting

### Module Won't Import

```powershell
# Check module path
$env:PSModulePath -split ';'

# Verify module files exist
Get-ChildItem $PSScriptRoot\*.ps*1

# Force import with verbose output
Import-Module ArgumentCompleters -Verbose -Force
```

### Completions Not Working

```powershell
# Check completer registration
Get-PSReadLineKeyHandler | Where-Object {$_.Function -like '*complete*'}

# Verify module is loaded
Get-Module | Where-Object {$_.Name -eq 'ArgumentCompleters'}

# Restart PowerShell session
# Ensure PSReadLine is loaded (usually automatic in modern PowerShell)
```

### Slow Startup

**Solutions:**
- **Selective loading**: Remove unused completer files from `Completers\` directory
- **Profile optimization**: Import module only when needed
- **Background loading**: Consider loading completers asynchronously

```powershell
# Profile example with selective loading
Import-Module ArgumentCompleters -AsJob  # If supported
```

### Errors After Updates

```powershell
# Clear module cache
Remove-Module ArgumentCompleters -ErrorAction SilentlyContinue
Get-Module ArgumentCompleters | Remove-Module
Import-Module ArgumentCompleters -Force
```

## Configuration

Edit the module manifest (`ArgumentCompleters.psd1`) to modify:

- **Module metadata**: Version, author, description
- **Dependencies**: Required modules and PowerShell versions
- **File inclusion**: Which completer files to load

## Contributing

The completers are generated from TabExpansionPlusPlus. To update:

1. Fork the original TabExpansionPlusPlus repository
2. Port new completers to use `Register-ArgumentCompleter`
3. Add comprehensive parameter validation
4. Test across PowerShell versions
5. Submit pull requests

## License

Inherited from TabExpansionPlusPlus project.

## Changelog

- **v2.0**: Updated to use `Register-ArgumentCompleter`, PowerShell Core support
- **v1.x**: Based on TabExpansionPlusPlus with Invoke-TabExpansion