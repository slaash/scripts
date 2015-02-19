package main

import "fmt"

func disp(i int, c chan int){
	c <- i
}

func main(){
	c := make(chan int)
	for i:=1;i<=10;i++{
		go disp(i, c)
	}
	for i:=1;i<=10;i++{
		ret := <-c
		fmt.Println(ret)
	}
}

