# 🌐 setDualNet

📡 **Dual Network Configuration Tool** | 🔌 **Static IP Management** | ⚙️ **Network Automation**

> **Bridge • Configure • Connect** - Automatically convert DHCP-assigned IPs to static configuration for dual network interfaces

## 🔍 What is setDualNet?

setDualNet is a powerful network configuration script that transforms dynamic DHCP-assigned IP addresses into static configurations for systems with both WLAN (Wireless) and Ethernet interfaces. It intelligently manages network routing, default gateways, and connectivity testing to ensure seamless dual network operation.

## ✨ Key Features

- **🔄 Dynamic to Static**: Converts DHCP leases to permanent static IPs
- **📊 Dual Interface Support**: WLAN + Ethernet simultaneous configuration
- **🚪 Smart Gateway**: Automatic default gateway detection and configuration
- **🔍 Network Validation**: Comprehensive connectivity testing
- **🛡️ Status Monitoring**: Real-time network health checks
- **⚡ One-Command Setup**: Simple execution with optional parameters
- **🔄 Auto-Recovery**: Network reconfiguration on failure detection

## 🏗️ How It Works

```
DHCP IPs ⭢ Network Analysis ⭢ Static Configuration ⭢ Gateway Setup ⭢ Connectivity Test
     ↓              ↓                ↓                 ↓              ↓
  wlan0/eth0   IP Ranges        Permanent IPs   Default Route    Internet Access
```

### Network Transformation Example:

| Interface | Before (DHCP) | After (Static) | Status |
|-----------|---------------|----------------|---------|
| **wlan0** | 192.168.1.100 | 192.168.1.100 | ✅ Configured |
| **eth0**  | 192.168.2.150 | 192.168.2.150 | ✅ Configured |
| **Gateway**| Auto-detected | 192.168.1.1   | ✅ Active |

## 📋 Requirements

### System Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| **OS** | Linux kernel 2.6+ | Linux kernel 4.0+ |
| **Shell** | Bash 4.0+ | Bash 5.0+ |
| **Permissions** | Root/sudo access | Root/sudo access |
| **Network** | Dual interfaces (wlan0 + eth0) | Stable DHCP environment |

### Prerequisites

```bash
# Ensure required tools are available
which ifconfig route ping  # Should return paths
# Script must be run with root privileges
sudo -v  # Test sudo access
```

### Network Requirements

- **Dual interfaces**: System must have both wlan0 and eth0
- **DHCP configuration**: Interfaces should initially receive IPs from DHCP
- **Network connectivity**: At least one interface should have internet access
- **IP address space**: Sufficient IPs available in subnet for static configuration

## 🚀 Quick Start

### Basic Usage

```bash
# Make script executable
chmod +x setDualNet.sh

# Run with default gateway detection
sudo ./setDualNet.sh

# Run with custom gateway
sudo ./setDualNet.sh 192.168.1.254
```

### Expected Output

```
WLAN and Ethernet is all connected, Script running...
Wlan original IP from DHCP is: 192.168.1.100
Ethernet original IP from DHCP is: 192.168.2.150
eth interm ip is:192.168.2.255 wlan interm ip is:192.168.1.255
Now Wlan Static IP is: 192.168.1.100
Now Ethernet Static IP is: 192.168.2.150
Add Default Gateway: 192.168.1.1
Ping default gw from Para1 192.168.1.1 Sucess!
Ping Internet 8.8.8.8 Sucess!
```

✨ **Success!** Your dual network is now configured with static IPs and active routing.

### Advanced Setup

```bash
# With custom gateway and logging
sudo ./setDualNet.sh 10.0.0.1 2>&1 | tee network_setup.log

# Verify configuration
ip route show
ip addr show
```

## 📖 Detailed Usage

### Command Syntax

```bash
sudo ./setDualNet.sh [gateway_ip]
```

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `gateway_ip` | Optional | `wlan_ip.1` | Default gateway for internet routing |

### Parameter Examples

```bash
# Use detected gateway (recommended)
sudo ./setDualNet.sh

# Use custom gateway (corporate networks)
sudo ./setDualNet.sh 10.0.0.1

# Use different gateway
sudo ./setDualNet.sh 172.16.0.254
```

### Execution Flow

1. **Initial Status Check** 🔍
   - Verify wlan0 and eth0 are connected
   - Confirm DHCP IPs are assigned
   - Check network routes

2. **IP Address Capture** 📝
   - Read current DHCP-assigned IPs
   - Store original configurations

3. **Network Reconfiguration** ⚙️
   - Temporarily reconfigure interfaces
   - Apply static IP settings
   - Set network masks (255.255.255.0)

4. **Gateway Configuration** 🚪
   - Add default route
   - Verify gateway reachability

5. **Connectivity Validation** ✅
   - Test gateway connectivity
   - Verify internet access
   - Auto-recover on failures

## 🌐 Network Architecture

### Dual Network Topology

```
    ┌─────────────────┐
    │   Internet      │
    └───────┬─────────┘
            │
    ┌───────┼─────────┐
    │       │         │
    │  WLAN   ETH   │
    │ 192.168.1.100 │ 192.168.2.150
    │               │
    │   Device      │
    └───────────────┘
         Gateway: 192.168.1.1
```

### IP Configuration Matrix

| Network Segment | WLAN (wlan0) | Ethernet (eth0) | Gateway |
|----------------|-------------|----------------|---------|
| **Subnet** | 192.168.1.0/24 | 192.168.2.0/24 | N/A |
| **IP Assignment** | DHCP → Static | DHCP → Static | Static |
| **Routing** | Primary route | Backup route | Default |

## 🔧 Configuration Details

### Network Interface Mapping

The script assumes standard Linux interface names:
- **wlan0**: Wireless network interface
- **eth0**: Wired Ethernet interface

### IP Address Handling

```bash
# Script preserves original IP addresses
# DHCP: 192.168.1.100 → Static: 192.168.1.100 (same IP)
# Only converts lease type, maintains address
```

### Gateway Selection Logic

- **No parameter**: Uses wlan.network.1 (e.g., 192.168.1.1)
- **With parameter**: Uses specified IP address
- **Validation**: Tests gateway reachability before applying

## 🔍 Monitoring & Validation

### Network Status Checks

The script performs multiple validation stages:

```bash
# Stage 1: Initial connectivity
route | grep -E "(wlan|eth)"
ifconfig wlan0 | grep "inet addr"
ifconfig eth0 | grep "inet addr"

# Stage 2: Configuration verification
ping -c 2 -W 2 $gateway_ip
ping -c 2 -W 2 8.8.8.8
```

### Success Indicators

| Check | Command | Expected |
|-------|---------|----------|
| **Gateway Ping** | `ping -c 2 gateway` | ✅ Success |
| **Internet Test** | `ping -c 2 8.8.8.8` | ✅ Success |
| **Route Table** | `route -n` | Default route present |

## 🐛 Troubleshooting

### Common Issues & Solutions

#### Issue: "WLAN or Ethernet is disconnected"
```
Error: WLAN or Ethernet is disconnected, now exit...

Solution:
1. Ensure both wlan0 and eth0 have active connections
2. Check interface status: ip link show
3. Verify DHCP is working: dhclient -r; dhclient
4. Run script only when both networks are connected
```

#### Issue: "WLAN is reconnected, scripts may failed"
```
Warning: WLAN is reconnected, scripts may failed...pls check wlan status

Solution:
1. Avoid network changes during script execution
2. Ensure stable WLAN connection
3. Consider using wired connection for critical setups
4. Script is designed for one-time execution
```

#### Issue: "Ping default gw failed"
```
Error: Ping default gw X.X.X.X failed, now reconfig ip, pls check later...

Solution:
1. Verify gateway IP is correct and reachable
2. Check network firewall rules
3. Test connectivity: ping -c 4 gateway_ip
4. Use alternative gateway parameter
```

#### Issue: "Default Gateway Existence"
```
Notice: Default Gateway Existence, pls check it

Solution:
1. Script detected existing default route
2. Check current routing: route -n
3. Remove conflicting routes if needed
4. Or proceed if current gateway is preferred
```

### Diagnostic Commands

```bash
# Check network interfaces
ip addr show
ip link show

# View routing table
route -n
ip route show

# Test connectivity
ping -c 4 8.8.8.8
ping -c 4 [gateway_ip]

# Check DHCP leases
dhclient -r wlan0
dhclient wlan0
```

### Recovery Procedures

```bash
# Restore DHCP configuration
dhclient -r wlan0
dhclient -r eth0
dhclient wlan0
dhclient eth0

# Restart network services
systemctl restart NetworkManager
# or
service networking restart

# Manual IP restoration
ifconfig wlan0 down && ifconfig wlan0 up
ifconfig eth0 down && ifconfig eth0 up
```

## 📋 Usage Examples

### Enterprise Network Setup

```bash
# Corporate dual-segment configuration
sudo ./setDualNet.sh 10.0.0.1

# Output expected:
# - WLAN: 192.168.1.100 (corporate WiFi)
# - Ethernet: 192.168.2.150 (direct LAN connection)
# - Gateway: 10.0.0.1 (corporate router)
```

### Home Network Configuration

```bash
# Residential setup with default gateway
sudo ./setDualNet.sh

# Output expected:
# - WLAN: Connected to home WiFi
# - Ethernet: Connected to home router
# - Gateway: Auto-detected (192.168.1.1)
```

### IoT Device Configuration

```bash
# Embedded device with specific routing
sudo ./setDualNet.sh 172.16.0.254

# Output expected:
# - wlan0: IoT control network access
# - eth0: Direct device management
# - Gateway: IoT network controller
```

### Testing Environment Setup

```bash
# Development server with dual paths
sudo ./setDualNet.sh

# Verify configuration
curl ifconfig.me    # Test internet connectivity
arp -a             # Check network neighbors
netstat -rn        # Validate routing table
```

## 🛡️ Security Considerations

### Network Best Practices

- **Run with minimal privileges**: Use sudo only when necessary
- **Validate IP ranges**: Ensure static IPs are within authorized ranges
- **Monitor for conflicts**: Check for IP address collisions
- **Secure storage**: Avoid hardcoding sensitive gateway IPs

### Firewall Integration

```bash
# Consider firewall rules for dual networks
iptables -A INPUT -i wlan0 -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -i eth0 -s 192.168.2.0/24 -j ACCEPT
```

### Enhancement Ideas

- ✅ **IPv6 Support**: Add dual stack configuration
- 🔄 **Interface Detection**: Auto-detect interface names
- 📊 **Network Monitoring**: Add continuous status monitoring
- 📝 **Logging**: Implement detailed execution logging
- 🔒 **Security**: Add network security validation

## 📄 License

This script is part of the Shell-Configurations repository and follows the same licensing terms. See the main repository LICENSE file for details.

## 🔗 Links

- [**Main Repository**](https://github.com/ibra-kdbra/Shell-Configurations) - Shell-Configurations project
- [**Linux Networking**](https://www.kernel.org/doc/html/latest/networking/) - Linux network documentation
- [**DHCP Documentation**](https://tools.ietf.org/html/rfc2131) - DHCP specification

---

*🌐 Empowering dual network configurations since the project started*
