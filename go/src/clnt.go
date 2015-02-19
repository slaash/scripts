package main

import "net"
import "fmt"
import "os"
import "bufio"

func reader(conn net.Conn){
	s:=bufio.NewScanner(conn)
	remHost:=conn.RemoteAddr().String()
	fmt.Println("Reading from from: "+remHost)
	for s.Scan(){
		t:=s.Text()
		fmt.Println("Got from "+remHost+":"+t)
	}
}

func writer(s string, conn net.Conn){
	w:=bufio.NewWriter(conn)
	w.WriteString(s+"\n")
	w.Flush()
}
		
func main(){
	host:=os.Args[1]
	port:=os.Args[2]
	conn, _ := net.Dial("tcp", host+":"+port)
	fmt.Println(conn.LocalAddr().String()+" connected to "+conn.RemoteAddr().String())
	go reader(conn)
	var input string
	for {
		input=""
		fmt.Print("# ")
		fmt.Scanln(&input)
//		conn.Write([]byte(input+"\n"))
		go writer(input,conn)
	}
}

