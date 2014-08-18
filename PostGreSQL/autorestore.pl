#!/usr/bin/perl
#use warnings;
use strict;

use DBI;

# You will need DBI installed. You can install it with CPAN like so:
# $ sudo cpan install DBI
# You might need to install DBI::Pg too
# $ sudo cpan install DBI::Pg

# How to do db dumps:
# $ sudo -i -u postgres 
# $ pgdump -Fc dbname > somefile.dump
# In this video they say always use pg_dump -Fc (Custom format) for making backups.
# http://www.youtube.com/watch?v=FyR3TD11hlc



my $dbh;
my $host = "localhost";

my ($dumpfile,$dbname,$username,$password) = @ARGV;

# Run with $ ./autorestore.pl /tmp/somedumpfile.dump dbname someusername somegoodpassword

# Check for no arguments
if (@ARGV == 0) {
# Then print out:

# Usually if you are on Linux then scp your .dump file to the machine you want to restore it on to the /tmp directory
# Then login and:  
# $ sudo chown postgres:postgres /tmp/filename.dump
# Then
# $ sudo -i -u postgres
# $ cd /tmp
# $ ./autorestore.pl /tmp/somedumpfile.dump dbname someusername somegoodpassword


# Run with  ./autorestore.pl /tmp/somedumpfile.dump dbname someusername somegoodpassword
print "Make sure you run this script as the postgres user\n";
print "Run with  ./autorestore.pl /tmp/somedumpfile.dump dbname someusername somegoodpassword\n";
}

else {


$dbh = DBI->connect("dbi:Pg:dbname=$dbname;host=$host;", $username, $password, {AutoCommit => 0});
  # The AutoCommit attribute should always be explicitly set

   if ($DBI::err) {
     # This means we don't have this db so lets create it.
     print "We dont have this database with that name, lets create it.\n";
     system("createdb $dbname --owner $username");

# Do Something

}

# Now restore the .dump file
print "Restoring the dump file $dumpfile\n";
#system("psql -f $dumpfile $dbname");
system("pg_restore -d $dbname $dumpfile");

}
