use Win32::ODBC;

my $db;
my $db2;
my $MyDSN = "DSN=temppo;UID=sitemppo_se;PWD=si_change_se";

if (!($db = new Win32::ODBC($MyDSN))){
    print "Error connecting to $MyDSN\n";
    print "Error: " . Win32::ODBC::Error() . "\n";
    exit;
}


#$db->Sql('select count(name) from sitemppo_pvv.tuser');

$db->Sql("select ts.name, l.version, l.created as main_latest from sitemppo_se.teststructure ts, sitemppo_se.structureversion sv, sitemppo_se.label l, sitemppo_se.labledstructure ls where ts.teststructureid=sv.teststructureid and sv.structureversionid=ls.structureversionid and ls.labelid=l.labelid and ts.name='VW_MIBE_SE_Verification_Tests' and rownum<10 order by l.created DESC");
$db->FetchRow;
@row= $db->Data;
print "Total: $row[0] $row[1] $row[2]\n";

while ( $db->FetchRow() )
    {
        my( $i );
        my( @items );

        ( @items ) = $db->Data();
        foreach $i ( 0 .. 10 )
        {
            if ( defined( $items[ $i ] ) )
            {
                print( STDOUT $items[ $i ] );
            }
            if ( 10 != $i )
            {
                print( STDOUT "\t" );
            }
        }
        print( STDOUT "\n" );
    }

$db->Close();

