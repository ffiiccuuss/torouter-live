
DO NOT add the "-s" flag to /etc/default/openntpd, or init will not complete
boot level 2, any init.d scripts requiring $all will not be run, and the serial
console will not get enabled.

