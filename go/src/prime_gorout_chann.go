package main

import "fmt"
import "os"
import "strconv"
import "math"
import "time"

func is_prime(i float64, c chan float64){
	var j float64
	prim:=true
	for j=2;j<=math.Sqrt(i);j++{
		if math.Mod(i,j)==0{
			prim=false
		}
	}
	if prim==true{
		c <- i	
	}
}

func receiver(c chan float64){
//	for i:= range c{
//		fmt.Println(i)
//	}
	for {
		select {
			case i:= <- c:
				fmt.Println(strconv.FormatFloat(i,'g',100,64))
		}
	}
}

func main() {
	c := make(chan float64)
	var min, max float64
	min, _ = strconv.ParseFloat(os.Args[1],64)
	max, _ = strconv.ParseFloat(os.Args[2],64)
	var i float64
	for i=min;i<=max;i++{
		go is_prime(i, c)
	}
	go receiver(c)

	time.Sleep(time.Second*1)
}

