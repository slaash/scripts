package main

import "fmt"
import "os"
import "strconv"
import "math"

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
	close(c)
}

func checkErr(err error){
	if err!=nil{
		fmt.Println(err)
	}
}

func printer(c chan float64){
	for i := range c{
		fmt.Println(i)
	}
}

func main() {
	c := make(chan float64)
	var err error
	var min, max float64
	min, err = strconv.ParseFloat(os.Args[1],64)
	checkErr(err)
	max, err = strconv.ParseFloat(os.Args[2],64)
	checkErr(err)	
	var i float64
	for i=min;i<=max;i++{
		go is_prime(i, c)
	}
	go printer(c)
}

