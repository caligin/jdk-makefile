Why
=
- If jdk is not a .deb with appropriate 'provides' other versions might be installed as dependency.
- Want to avoid multiple versions of the platform unless *really* necessary. Less versions, less headache.
- In case of that happening, we want to be able to use the alternatives system.
- Enforce security configuration on crypto. (e.g. disable weak cyphers, enable jce unlimited)
- JDK license. If it has to be accepted, accept it. But at least make it 'accept & package once, install on all machines/vms/containers'

JDK license considerations
=
The license agreement is personal || company-wise if you accept it representing your company (and have the right to), therefore downloading it once, package it for internal use & distribute it inside the boundaries of your machines || your organization should be ok.

It also states that distribution should be of "the entire thing" and "without modification". I really hope that this does not extend to config files (and the jce jars) as one of my targets is to disable weak ciphers by default.

If this reveals to be actually an issue, putting the replacement & config steps in a postinstall script *should* be enough to work around this.

But... *I DO NOT SPEAK LEGALESE SO ALL OF THIS IS MY (possibly very wrong) UNDERSTANDING OF THE LICESE. IF YOU KNOW THAT THIS IS VERY WRONG PLEASE TELL ME AT ONCE*.

How
=
- download jdk from http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
- download jce unlimited from http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html

I hate to say this, but that license should be accepted and I won't provide a script to circumvent that. 

- place the files in the same directory as `Makefile` and this `README.md`.
- `make`
- profit!

Requirements
=
- docker + internet connection to download the appropriate images (if you don't have them already)
- [maybe in roadmap?] fpm on the host system as an alternative to docker
- make

Platform support
=
Ubuntu/deb based distros.

I will very likely not provide support for other platforms (rpm, OSX, win...), merely as a matter of "I'll do it when I'll need it", but I'd like to encourage everyone that needs it to fork this, hack it & provide pull requests, I'll be glad to help integrate any extra support!

License
=
MIT