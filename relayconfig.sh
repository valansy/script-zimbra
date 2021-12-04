#!/bin/bash

## Konfigurasi di MTA server Zimbra untuk menggunakan relay jika domain tujuan Yahoo
## Jalankan sebagai user admin Zimbra

# Penambahan postfix lookup table untuk password smtp relay	
postmap /opt/zimbra/conf/relay_password

# Penambahan postfix lookup table untuk receiver domain
postmap /opt/zimbra/common/conf/transport

# Konfigurasi postfix untuk menggunakan password map yang baru dibuat	
zmprov ms `zmhostname` zimbraMtaSmtpSaslPasswordMaps lmdb:/opt/zimbra/conf/relay_password

# Konfigurasi postfix untuk menggunakan SSL auth	
zmprov ms `zmhostname` zimbraMtaSmtpSaslAuthEnable yes

# Konfigurasi postfix untuk menggunakan outgoing servername dibanding cname	
zmprov ms `zmhostname` zimbraMtaSmtpCnameOverridesServername no

# Konfigurasi postfix agar menggunakan TLS	
zmprov ms `zmhostname` zimbraMtaSmtpTlsSecurityLevel may

# Konfigurasi postfix agar menggunakan mekanisme login	
zmprov ms `zmhostname` zimbraMtaSmtpSaslSecurityOptions noanonymous

# Konfigurasi postfix untuk menggunakan TransportMaps yang baru dibuat untuk domain Yahoo	
zmprov ms `zmhostname` zimbraMtaTransportMaps "lmdb:/opt/zimbra/common/conf/transport,proxy:ldap:/opt/zimbra/conf/ldap-transport.cf"

# Reload konfigurasi postfix	
postfix reload

# Restart Service MTA Zimbra	
zmmtactl restart

echo 'Configuration Done'