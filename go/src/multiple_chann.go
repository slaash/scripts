package main

import "fmt"
import "time"

func sender(c chan int){
	for i:=0 ; i<=10 ; i++ {
		c <- i
	}
}

func receiver(c chan int){
	for i:= range c{
		fmt.Println(i)
	}
//	for {
//		select {
//			case i:= <- c:
//				fmt.Println(i)
//			}
//	}
}

func main(){
	c:=make(chan int)
	for i:=0;i<=3;i++{
		go sender(c)
	}
	go receiver(c)

	time.Sleep(time.Second*3)
}

