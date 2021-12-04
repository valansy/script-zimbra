#!/bin/bash

## Konfigurasi SMTP Relay auth & transport maps untuk tujuan domain Yahoo ##
## Jalankan sebagai root

# Konfigurasi file SMTP credential untuk AWS SES
echo 'email-smtp.us-east-1.amazonaws.com  AKIAVKLUBLHZHSW7TLNI:BF0o4QO6yrxLf3D1bVwmoXgeEKVJMltIcfyn6hfLwJ6n' > /opt/zimbra/conf/relay_password

#Konfigurasi domain tujuan (Yahoo.com & Yahoo.co.id) yang akan menggunakan relay AWS	
echo 'yahoo.com : [email-smtp.us-east-1.amazonaws.com]:587' >> /opt/zimbra/common/conf/transport
echo 'yahoo.co.id : [email-smtp.us-east-1.amazonaws.com]:587' >> /opt/zimbra/common/conf/transport

echo 'Done'