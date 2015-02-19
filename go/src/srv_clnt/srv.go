package main

import "net"
import "bufio"
import "fmt"

func handleConn(conn net.Conn){
	w:=bufio.NewWriter(conn)
	s:=bufio.NewScanner(conn)
	remHost:=conn.RemoteAddr().String()
	fmt.Println("Connection from: "+remHost)
	w.WriteString("Hello!"+"\n")
	w.Flush()
	for s.Scan(){
		t:=s.Text()
		fmt.Println(remHost+":"+t)
		w.WriteString(remHost+":"+t+"\n")
		w.Flush()
	}
}

func main(){
	ln,_:=net.Listen("tcp",":12345")
	fmt.Println("Server listening on: "+ln.Addr().String())
	for {
		conn,_:=ln.Accept()
		go handleConn(conn)
	}
}
