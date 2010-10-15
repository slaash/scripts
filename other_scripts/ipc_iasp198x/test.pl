use IPC::SysV qw(IPC_PRIVATE S_IRUSR S_IWUSR);
use IPC::Msg;
$msg = IPC::Msg->new(IPC_PRIVATE, S_IRUSR | S_IWUSR);
$msg->snd(pack("l! a*",$msgtype,$msg));
$msg->rcv($buf,256);
$ds = $msg->stat;
$msg->remove;

