package main

import "fmt"
import "os"
import "bufio"
import "io"

func checkErr(err error){
	if err!=nil{
		fmt.Println(err)
	}
}

func main() {
	fo, err:=os.Create("/tmp/out111.txt")
	checkErr(err)
	w:=bufio.NewWriter(fo)
	w.WriteString("Hello!")
	w.Flush()
	fo.Close()

	fi, err:=os.Open("/tmp/out111.txt")
	checkErr(err)
	scanner:=bufio.NewScanner(fi)
	for scanner.Scan(){
		fmt.Println(scanner.Text())
	}
	fi.Close()	

	fi, err=os.Open("/tmp/out111.txt")
	checkErr(err)
	reader:=bufio.NewReader(fi)
	for {
		path, err := reader.ReadString(10)
		if err == io.EOF {
			break
		}
		fmt.Println(path)
	}
	fi.Close()
}
