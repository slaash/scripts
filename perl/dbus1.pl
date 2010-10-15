#!/usr/bin/perl

use strict;
use warnings;

use Net::DBus;
use Net::DBus::Dumper;
use Data::Dumper;

my $dbus_srv="org.freedesktop.Avahi";
my $dbus_path=$dbus_srv;
$dbus_path=~s/\./\//g;
$dbus_path="/".$dbus_path;

my $bus = Net::DBus->find;
print dbus_dump($bus);

my $service=$bus->get_service("$dbus_srv");
print dbus_dump($service);

my $object=$service->get_object("$dbus_path","$dbus_srv");
print dbus_dump($object);

# Get a handle to the HAL service
#my $hal = $bus->get_service("org.freedesktop.Hal");

# Get the device manager
#my $manager = $hal->get_object("/org/freedesktop/Hal/Manager","org.freedesktop.Hal.Manager");
#$manager = $hal->get_object(":1/26",":1.26");

# List devices
foreach my $dev (@{$object->GetAllDevices}) {
	print $dev, "\n";
}

