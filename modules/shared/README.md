# `modules/shared/`

This folder contains modules that are identical for both home manager and nixos.
These are not common as usually they need different implementations. Right now
these modules are just used as global variables. You can read whether the
system uses wireless from anywhere in the config by checking
`config.system.hardware.usesWireless`. The same file can set these variables for
both home manager and nixos.
