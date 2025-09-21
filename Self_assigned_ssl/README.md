# Self-signed SSL/TLS Scripts

A set of bash scripts for generating self-signed SSL/TLS certificates for development and testing purposes. These scripts create a certificate authority (CA) and domain-specific certificates using OpenSSL.

## Prerequisites

- OpenSSL must be installed and available in your PATH
- Bash shell environment
- Execute permissions on all script files: `chmod +x *.sh` or `chmod +x *` in this directory

## Usage

### Root Certificate Authority

#### Generate CA Certificate

Creates a 2048-bit RSA private key and a self-signed root CA certificate valid for 1024 days.

```shell
./create-root-cert-and-key
```

**Files Generated:**
- `rootCA.key` - CA private key (keep secure!)
- `rootCA.pem` - CA certificate in PEM format

#### Renew CA Certificate

Renews the existing CA certificate for another 5 years (1830 days). Backs up current CA files before renewal.

```shell
./renew-root-cert
```

**Backup Location:**
- `_backups/YYYY-MM-DD_HH.MM/` - Timestamped backup directory containing:
  - `rootCA.pem`
  - `rootCA.pfx`
  - `rootCA.key`
  - `rootCA.srl`
  - `cacert.pem`

**Files Updated:**
- `rootCA.pem` - Renewed CA certificate
- `rootCA.pfx` - Updated PFX for IIS import

### Domain-Specific Certificates

Generates site-specific certificates signed by the root CA for development domains.

```shell
./create-certificate-for-domain [domain-name]
```

**Examples:**
```shell
./create-certificate-for-domain example.local
./create-certificate-for-domain dev.myapp.com
```

**Certificate Details:**
- 2048-bit RSA key
- Valid for 365 days (browsers limit validity periods for security)
- Subject: `//C=CA/ST=None/L=NB/O=None/CN=[domain-name]`
- Extensions: Basic constraints, key usage, DNS subject alternative name

**Directory Structure Created:**
```
certs/[domain-name]/
├── [domain-name].crt    # Certificate file
├── [domain-name].csr    # Certificate signing request
└── device.key           # Private key
```

**Additional Files Generated:**
- `[domain-name].pfx` - PKCS12 format for Windows/IIS import (no password)

### Windows PFX for IIS

PFX files are automatically generated for both CA and domain certificates. For IIS web server usage:

1. **CA Certificate Import:** Import `rootCA.pfx` into Windows Certificate Store as Trusted Root Certification Authority
2. **Site Certificate:** Import the domain's `.pfx` file into IIS for the respective website binding

The scripts output completion messages with IIS-specific import reminders.

## Certificate Extensions

The `v3.ext` file contains X.509 v3 certificate extensions applied to domain certificates:
- Authority Key Identifier
- Basic Constraints (CA:FALSE)
- Key Usage: Digital Signature, Non-Repudiation, Key Encipherment, Data Encipherment
- Subject Alternative Name with DNS entry for the domain

This file is automatically processed during certificate generation.

## Version Control

The `.gitignore` file excludes generated keys and certificates from version control:
- `/device.key`
- `/rootCA.*`

The `certs/` directory contains generated domain certificates and may also be ignored depending on your security policies.

## Troubleshooting

**"command not found: openssl"**
- Install OpenSSL: `apt install openssl` (Debian/Ubuntu) or `brew install openssl` (macOS)

**Certificate verification fails**
- Ensure the root CA certificate was generated first
- Check file permissions on `.key` files (should be readable only by owner)

**IIS PFX import issues**
- PFX files are generated without passwords
- For CA import, use the Certificate Import Wizard in MMC with "Trusted Root Certification Authorities" store

**Certificate validity issues**
- Domain certificates expire after 365 days
- CA certificates expire after 1024 days or can be renewed with `renew-root-cert`
