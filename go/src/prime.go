package main

import "fmt"
import "os"
import "strconv"
import "math"

func is_prime(i float64) bool{
	var j float64
	prim:=true

	for j=2;j<=math.Sqrt(i);j++{
		if math.Mod(i,j)==0{
			prim=false
			break
		}
	}
	if prim==true{
		return true
	}
	return false
}

func main() {
	var min, max float64
	min, _ = strconv.ParseFloat(os.Args[1],64)
	max, _ = strconv.ParseFloat(os.Args[2],64)
	var i float64
	for i=min;i<=max;i++{
		if is_prime(i)==true{
			fmt.Printf("%.0f\n", i)
		}
	}
}

