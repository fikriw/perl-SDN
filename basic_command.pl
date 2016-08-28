#/usr/bin/perl -w
use Telnet;
use Cisco;

my @output;

#Insert hostname here
my $host = ""; 

#GET USERNAME & PASSWORD
print "Please enter your login info!\n";
print "--------------------------------\n";
print "Username: ";
$username = <>;
chomp $username;
print "Password: ";
system('stty','-echo');
chop($password=<STDIN>);
system('stty','echo');
chomp $password;
print "\n--------------------------------\n";


#Connect to host
my $session = Cisco->new(Timeout => 5, prompt => '/(?m:^\\s?(?:[\\w.\/]+\:)?(?:[\\w.-]+\@)?[\\w.-]+\\s?(?:\(config[^\)]*\))?\\s?[\$#>]\\s?(?:\(enable\))?\\s*$)/', Errmode => 'return' );

chomp $host;
$session->open($host);
if ($session->errmsg){
        print "$host : Disconnect\n";
        $session->close;
}else{
        $session->login($username, $password);
        print "$host : Connect\n";
        #runnning command
        my @output = $session->cmd('show clock');
        print @output;
        $session->close;
}
print "\n";
