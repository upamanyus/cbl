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
		a1, err := strconv.ParseInt(parts[1], 10, 32)
		if err != nil {
			panic(err)
		}
		a2, err := strconv.ParseInt(parts[2], 10, 32)
		if err != nil {
			panic(err)
		}
		fOut.WriteString(fmt.Sprintf("%s %05d %05d\n", parts[0], a1, a2))
	}
}
