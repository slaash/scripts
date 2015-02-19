package main

import "fmt"
import "os"
import "os/exec"
import "bufio"
import "regexp"
import "reflect"

func checkErr(err error){
	if err!=nil{
		fmt.Println(err)
	}
}

func checkLine(s string, r1 *regexp.Regexp, r2 *regexp.Regexp){
	if r1.MatchString(s){
		fmt.Println(s)
		res := r2.FindAllStringSubmatch(s, -1)
//		fmt.Println(res)
		if res!=nil{
			for _,v := range res{
				fmt.Println("matched: ",v[1])
			}
		}
	}
}

func main() {
	fmt.Println(os.Getenv("PATH"))
	cmd:=exec.Command("ps","aux")
	rgx,err:=regexp.Compile(`^root`)
	fmt.Println(rgx, reflect.TypeOf(rgx))
	checkErr(err)
	rgx1,err:=regexp.Compile(`(\d+)`)
	checkErr(err)
	fmt.Println(rgx)
	out, err := cmd.StdoutPipe()
	fmt.Println(cmd)
	err=cmd.Start()
	checkErr(err)
	scanner:=bufio.NewScanner(out)
	for scanner.Scan() {
		line:=scanner.Text()
		checkLine(line, rgx, rgx1)
	}
	cmd.Wait()
}

