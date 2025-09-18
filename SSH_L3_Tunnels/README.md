# SSH L3 Tunnels

A robust Linux tool for managing Layer 3 SSH tunnels with advanced networking features.

![Status](https://img.shields.io/badge/status-active-brightgreen) ![OS](https://img.shields.io/badge/OS-Linux-lightgrey) ![License](https://img.shields.io/badge/license-BSD-blue)

SSH L3 Tunnels creates secure Layer 3 networking through SSH tunnels using Linux network namespaces for complete isolation. It features dynamic IP addressing, virtual Ethernet pairs, routing, NAT, and persistent tunnel management with YAML configuration.

## ✨ Key Features

- **🔗 Layer 3 SSH Tunnels**: Secure network-level tunneling over SSH
- **🛡️ Network Namespace Isolation**: Complete network configuration isolation
- **🔌 Virtual Ethernet Pairs**: Direct host-to-namespace communication
- **🚦 Routing and NAT**: Automatic routing table and NAT rule management
- **🔄 Persistent Connections**: autossh-based connection monitoring and recovery
- **⚙️ Dynamic Configuration**: Change connections and manage multiple tunnels
- **📄 YAML Configuration**: Save and load network configurations
- **🔥 nftables Integration**: Modern Linux firewall rule management

## Requirements

### System Requirements

| Component | Minimum Version | Purpose |
|-----------|----------------|---------|
| **Linux Kernel** | 4.18+ | Network namespace support |
| **iproute2** | Latest | Linux networking tools |
| **nftables** | Latest | Firewall rule management |
| **autossh** | Latest | Persistent SSH connection management |
| **SSH Client** | OpenSSH 7.0+ | Secure tunnel establishment |

### Prerequisites

```bash
# Install required packages on Debian/Ubuntu
sudo apt-get update
sudo apt-get install -y iproute2 nftables autossh openssh-client

# Verify installation
which ip nft autossh ssh
```

### Network Requirements

- **SSH Access**: Passwordless SSH to remote hosts (key-based authentication recommended)
- **Root Access**: Local and remote sudo privileges for network configuration
- **Network Interfaces**: Active network interface with internet connectivity
- **Firewall**: No blocking of SSH port (22) between hosts

## Quick Start

### Basic Tunnel Setup

```bash
# Clone repository
git clone https://github.com/ibra-kdbra/Shell-Configurations.git
cd Shell-Configurations/SSH_L3_Tunnels

# Make scripts executable
chmod +x *.sh

# Create isolated tunnel environment and connect
./setup.sh remote.example.com

# Verify tunnel (run in another terminal)
sudo ip netns exec vpn ping 8.8.8.8
```

### Expected Output

```
Removing old veth...
Creating new ns...
Created. ns list: vpn
Creating veth peers...
Adding peer to ns...
Setting up veth and up...
Setting ns ifaces up...
Assigning IP address of ns iface...
Setting routing in ns...
Setting NAT rules...
Checking internet in ns...
Ping succeeded
Making ssh tun/tap tunnel in ns...
Setting ssh tun/tap dev addr and up in ns...
Setting routing in ns...
Setting ssh tun/tap dev addr and up remote...
Ping succeeded
Saving config...
```

## Detailed Usage

### Core Scripts

| Script | Purpose | Parameters |
|--------|---------|------------|
| `setup.sh` | Initial tunnel setup with namespace isolation | `[remote_ip]` |
| `setups.sh` | Setup namespace without tunnel connection | None |
| `default_connection.sh` | Restore connection from YAML config | None |
| `change_connection.sh` | Change tunnel to new remote host | `[new_remote_ip]` |
| `ssh_tunnel_manager.sh` | High-level tunnel management | `--mode [default\|change] [params]` |

### Tunnel Manager Operations

```bash
# Setup default connection
./ssh_tunnel_manager.sh --mode default

# Change to new remote host
./ssh_tunnel_manager.sh --mode change new-remote.example.com
```

### Connection Management

```bash
# Initial setup with tunnel connection
./setup.sh remote-server.example.com

# Setup namespace only (no tunnel)
./setups.sh

# Restore saved connection
./default_connection.sh

# Switch to different remote host
./change_connection.sh different-server.example.com
```

## How It Works

### Network Architecture

The system creates an isolated networking environment using Linux namespaces:

```
[Host Network] ── veth pair ── [VPN Namespace]
       │                                │
       └──────── SSH Tunnel ────────────┘
                   (encrypted)
```

### Key Components

1. **Network Namespace (`vpn`)**: Isolated network environment for secure routing
2. **Virtual Ethernet Pair**: Direct communication between host and namespace
3. **SSH TUN Device**: Layer 3 tunneling for routing capabilities
4. **NFTables Rules**: Automatic NAT and firewall configuration
5. **Route Management**: Dynamic routing table updates

### IP Address Structure

| Component | IP Range | Purpose |
|-----------|----------|---------|
| **veth pair** | 10.0.0.1/24 | Host ↔ Namespace communication |
| **SSH tunnel** | 10.0.1.1/31 | Encrypted tunnel endpoints |
| **NFTables** | 10.0.0.0/8 | NAT and routing rules |

### Connection Process

```
1. Network Namespace Creation
2. Virtual Ethernet Setup (veth/vpeer)
3. IP Address Assignment
4. Routing Configuration
5. NFTables NAT Rules
6. SSH Tunnel Establishment (autossh)
7. Remote Configuration Sync
8. Tunnel Device Address Assignment
9. Route Updates for Connectivity
```

### Packet Flow

```
Client Application → VPN Namespace → SSH Tunnel → Remote Server → Internet
          ↓               ↓              ↓              ↓           ↓
     10.0.0.2        10.0.0.1      tun0/tun1     remote      destination
```

## Configuration

### YAML Configuration Format

Configurations are automatically saved as `config.yaml`:

```yaml
remote:
  IP: "remote.example.com"
local:
  TUN:
    IP: "10.0.1.1"
    dev: tun0
  NS:
    name: "vpn"
    dev: vpeer
  veth:
    IP: "10.0.0.1"
```

### Manual Configuration Editing

```bash
# Edit configuration file
vim config.yaml

# Apply custom configuration
./setup.sh  # Uses updated config.yaml
```

### Multiple Tunnel Support

Run multiple isolated tunnels by modifying namespace names:

```bash
# Create separate namespaces for different tunnels
TUN_NS_NAME=office ./setup.sh office-gateway.com
TUN_NS_NAME=home ./setup.sh home-server.com
```

## Troubleshooting

### Common Issues

#### SSH Connection Failures

**Symptom**: "SSH connection failed" or timeout errors
```bash
# Solutions:
# Verify SSH key authentication
ssh -T remote.example.com

# Check SSH host key (accept interactively first)
ssh -o StrictHostKeyChecking=no remote.example.com

# Enable verbose SSH debugging
autossh -v -M 0 -f -N remote.example.com
```

#### Network Namespace Issues

**Symptom**: "namespace creation failed" or routing errors
```bash
# Check namespace status
ip netns list

# Clean up stuck namespaces
ip netns delete vpn 2>/dev/null || true

# Verify network interface exists
ip link show
```

#### NFTables Rule Conflicts

**Symptom**: NAT or routing rule conflicts
```bash
# Check current nftables rules
sudo nft list ruleset

# Reset rules and retry
sudo nft flush ruleset
./nft_revert_host.sh
```

#### Tunnel Device Not Created

**Symptom**: tun0 device missing after SSH connection
```bash
# Check tunnel devices
ip link show | grep tun

# Verify autossh process
pgrep -f autossh

# Manual tunnel testing
ssh -w 0:1 -f -N remote.example.com
```

### Diagnostic Commands

```bash
# Check namespace and interfaces
ip netns exec vpn ip addr show
ip netns exec vpn ip route show

# Test tunnel connectivity
ip netns exec vpn ping 10.0.1.2
ip netns exec vpn traceroute 8.8.8.8

# Monitor SSH processes
ps aux | grep autossh
netstat -tunlp | grep :22

# Check system logs
journalctl -f | grep -i ssh
```

### Recovery Procedures

```bash
# Complete cleanup and restart
./nft_revert_host.sh
ip link delete veth 2>/dev/null || true
ip netns delete vpn 2>/dev/null || true
pkill -9 autossh 2>/dev/null || true

# Restart networking
sudo systemctl restart networking

# Fresh setup
./setup.sh remote.example.com
```

## Use Cases

### VPN Alternative

Replace traditional VPN software with SSH-based secure networking:

```bash
# Corporate access through SSH gateway
./setup.sh corporate-gateway.company.com

# All traffic in vpn namespace routes through SSH tunnel
ip netns exec vpn curl -s https://internal.company.com
```

### Remote Development

Secure access to development environments:

```bash
# Connect to remote development server
./setup.sh dev-server.example.com

# Run development tools in isolated namespace
ip netns exec vpn ssh dev-user@dev-server
```

### Network Segmentation

Create isolated network segments for testing:

```bash
# Multiple isolated environments
TUN_NS_NAME=testing ./setup.sh test-server.example.com
TUN_NS_NAME=staging ./setup.sh staging-server.example.com

# Switch between environments
ip netns exec testing ping service.testing.local
ip netns exec staging ping service.staging.local
```

### IoT and Embedded Systems

Secure management of embedded devices:

```bash
# Connect to IoT gateway
./setup.sh iot-gateway.local

# Access device management interfaces
ip netns exec vpn ssh admin@gateway
ip netns exec vpn curl http://device-manager.local
```

## Security Considerations

### SSH Authentication

- **Key-based authentication only** (no passwords)
- **SSH host key verification** for man-in-the-middle protection
- **Disable password authentication** on tunnel endpoints

### Network Isolation

- **Namespace isolation** prevents lateral movement
- **NFTables filtering** controls traffic flow
- **Minimal attack surface** through reduced network exposure

### Operational Security

- **Regular key rotation** for SSH authentication
- **Monitor connection logs** for unauthorized access
- **Limit tunnel scope** to required networks only

### Security Best Practices

```bash
# SSH hardening
# Disable root login
sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# Use strong keys
ssh-keygen -t ed25519 -f ~/.ssh/tunnel_key

# Limit SSH access
iptables -A INPUT -p tcp -s trusted.network/24 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP
```

## Installation

```bash
cd SSH_L3_Tunnels
chmod +x *.sh
```

## Dependencies

- iproute2 - Linux networking tools
- autossh - Persistent SSH connection management
- nftables - Modern Linux firewall
- openssh-client - SSH connectivity

## License

This project is part of the Shell-Configurations repository and follows the same licensing terms. See the main repository LICENSE file for details.

## Links

- [**Main Repository**](https://github.com/ibra-kdbra/Shell-Configurations) - Shell-Configurations project
- [**Linux Network Namespaces**](https://www.kernel.org/doc/html/latest/networking/net_ns.html) - Linux kernel network namespace documentation
- [**SSH Protocol**](https://tools.ietf.org/html/rfc4251) - SSH protocol specification
- [**NFTables**](https://wiki.nftables.org/) - Modern Linux firewall documentation

---

SSH L3 Tunnels provides enterprise-grade secure networking using standard Linux tools.
