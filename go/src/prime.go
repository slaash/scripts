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
		fmt.Println(strconv.FormatFloat(i,'g',100,64))
	}
}

func main() {
	var min, max float64
	min, _ = strconv.ParseFloat(os.Args[1],64)
	max, _ = strconv.ParseFloat(os.Args[2],64)
	var i float64
	for i=min;i<=max;i++{
		is_prime(i)
	}
}

