package main

import "fmt"
import "math"
import "os"
import "strconv"

func main(){
//	fmt.Println(os.Args[1])
	min, err:=strconv.Atoi(os.Args[1])
//	fmt.Println(min,err)
	max, err:=strconv.Atoi(os.Args[2])
	if err!=nil{
		fmt.Println("mumu")
	}
	fmt.Println(min, max)
	os.Exit(0)
	for i:=min; i<=max; i++{
//	for i:=1; i<=10; i++{
		prim:=true
		for j:=2; float64(j)<=math.Sqrt(float64(i)); j++{
			if i % j ==0 {
				prim=false
				break
			}
		}
		if prim==true{
			fmt.Println(i)
		}
	}
}

