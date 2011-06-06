puppet-lwes
===========

Description
-----------

A Puppet report processor for sending metrics to a [LWES](http://lwes.sourceforge.net/) server via the LWES APIs based on
https://github.com/jamtur01/puppet-ganglia/

Requirements
------------

* `lwes` gem
* `Puppet`
* A [LWES](http://lwes.sourceforge.net/) listener

Installation & Usage
--------------------

1.  Install the `lwes` gem on your Puppet master

        $ sudo gem install lwes

2.  Install puppet-lwes as a module in your Puppet master's module
    path.

3.  Update the `lwes_server` and `lwes_port` variables in the `lwes.yaml` file with 
    your Ganglia server IP and port and copy the file to `/etc/puppet/`. An example file is included.

4.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = lwes
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

5.  Run the Puppet client and sync the report as a plugin

Author
------

Shanker Balan <shanker.balan@inmobi.com>

License
-------

    Author:: Shanker Balan (<shanker.balan@inmobi.com>)
    Copyright:: Copyright (c) 2011 InMobi
    License:: The BSD License


	Copyright (c) 2011, Shanker Balan
	All rights reserved.

	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:
	Redistributions of source code must retain the above copyright notice, this
	list of conditions and the following disclaimer.  Redistributions in binary
	form must reproduce the above copyright notice, this list of conditions and the
	following disclaimer in the documentation and/or other materials provided with
	the distribution.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
	FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
	DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
	SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
	CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
	OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
	OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
