package main

import "fmt"
import "os"
import "strconv"
import "math"
import "sync"
//import "time"

var done sync.WaitGroup

func is_prime(i float64, c chan float64){
	var j float64
	prim:=true
//	if (i==13){
//		time.Sleep(100 * time.Millisecond)
//	}
	for j=2;j<=math.Sqrt(i);j++{
		if math.Mod(i,j)==0{
			prim=false
		}
	}
	if prim==true{
		c <- i	
	}
	done.Done()
}

func main() {
	c := make(chan float64)
	var err error
	var min, max float64
	min, err = strconv.ParseFloat(os.Args[1],64)
	max, err = strconv.ParseFloat(os.Args[2],64)
	fmt.Println(err)
	var i float64
	for i=min;i<=max;i++{
		done.Add(1)
		go is_prime(i, c)
	}
	for i = range c{
		fmt.Println(i)
	}
	close(c)
	done.Wait()
}

