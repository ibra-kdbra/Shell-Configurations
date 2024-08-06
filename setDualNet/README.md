# Dual Net Setting

 automatically obtain the dynamic IP assigned by Wlan/EtherNet DHCP, then configure it as a static IP and add a default gateway, and finally test the networking status of the two networks

## Function

 Auto set static IP for wlan/ethernet, which dynamically assigned from dhcp,and add default gateway

### Param in

 default gateway that can access internet, if not enter, this value will be *.*.*.1 of wlan ip

### Notice

 make sure that wlan has not reonnect, we recommend that script is only execute 1 time when network environment changed.
