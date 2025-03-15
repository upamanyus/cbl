package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	fIn, err := os.Open("in")
	if err != nil {
		panic(err)
	}
	defer fIn.Close()
	fOut, err := os.Create("out")
	if err != nil {
		panic(err)
	}
	defer fOut.Close()
	sc := bufio.NewScanner(fIn)
	for sc.Scan() {
		line := sc.Text()
		parts := strings.Split(line, " ")
		x, err := strconv.ParseFloat(parts[1], 64)
		if err != nil {
			panic(err)
		}
		fOut.WriteString(fmt.Sprintf("%s %05.2f\n", parts[0], x))
	}
}
