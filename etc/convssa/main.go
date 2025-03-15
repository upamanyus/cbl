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
	fOut, err := os.Create("data/benefit-base.txt")
	if err != nil {
		panic(err)
	}
	defer fOut.Close()
	sc := bufio.NewScanner(fIn)
	for sc.Scan() {
		line := sc.Text()
		parts := strings.Split(line, " ")
		x, err := strconv.ParseInt(parts[1], 10, 32)
		if err != nil {
			panic(err)
		}
		fOut.WriteString(fmt.Sprintf("%s %06d\n", parts[0], x))
	}
}
