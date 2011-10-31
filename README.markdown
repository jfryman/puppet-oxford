# Oxford Puppet Module

James Fryman <james@frymanet.com>

This module manages Oxford from within Puppet.

# Quick Start

Install and bootstrap Oxford Fact Exporter
* Download Manifest
* Customize params.pp.example (if necessary)
* Profit

# Requirements

Puppet Labs Standard Library
- http://github.com/puppetlabs/puppetlabs-stdlib

<pre>
  class { 'oxford':
    conn_type   => 'ldap',
    ldap_host   => 'ldap.frymanet.test',
    ldap_port   => '389',
    ldap_method => 'plain',
    ldap_user   => 'cn=oxford,ou=Special,dc=frymanet,dc=test',
    ldap_pass   => 'I shouldn never give out passwords!',
   }
</pre>

# TODO
* Publish Oxford as Gem
* Modify package class to pull from gem
