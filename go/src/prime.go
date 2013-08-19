package main

import "fmt"
import "os"
import "strconv"
import "math"

func is_prime(i float64){
	var j float64
	prim:=true
	for j=2;j<=math.Sqrt(i);j++{
		if math.Mod(i,j)==0{
			prim=false
		}
	}
	if prim==true{
		fmt.Println(i)
	}
}

func main() {
	var err error
	var min, max float64
	min, err = strconv.ParseFloat(os.Args[1],64)
	max, err = strconv.ParseFloat(os.Args[2],64)
	fmt.Println(err)
	var i float64
	for i=min;i<=max;i++{
		is_prime(i)
	}
	fmt.Println(i)
}

