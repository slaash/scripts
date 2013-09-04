package main

import "fmt"
import "os"
import "strconv"

func checkErr(err error){
	if err != nil{
		fmt.Println(err)
	}
}

func main(){
	var info []string
	info=append(info,strconv.Itoa(os.Getpid()))
	info=append(info,strconv.Itoa(os.Getppid()))
	h,err:=os.Hostname()
	checkErr(err)
	info=append(info,h)
	pwd,err:=os.Getwd()
	checkErr(err)
	info=append(info,pwd)
	info=append(info,strconv.Itoa(os.Getuid()))
	info=append(info,strconv.Itoa(os.Getgid()))
	info=append(info,strconv.Itoa(os.Getpagesize()))
	for _,v := range info{
		fmt.Println(v)
	}
	fmt.Println(os.Environ())
	f_info,err:=os.Stat("/bin/bash")
	checkErr(err)
	fmt.Println(f_info.Name(),f_info.Size(),f_info.Mode(),f_info.ModTime(),f_info.IsDir())
}

