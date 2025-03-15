package main

import (
	"fmt"
	"math/rand/v2"
	"os"
)

const (
	nPeople  = 2
	maxYears = 5
)

func main() {
	f, err := os.Create("data/mef.txt")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	var seed [32]byte
	rnd := rand.New(rand.NewChaCha8(seed))

	for i := 0; i < nPeople; i++ {
		ssn := rnd.Uint64N(1_000_000_000)
		nYears := rnd.Uint64N(maxYears)

		for j := uint64(0); j < nYears; j++ {
			year := 1951 + rnd.Uint64N(73)
			amount := float64(rnd.Uint64N(1_000_000_000_000)) + rnd.Float64()
			f.WriteString(fmt.Sprintf("%09d %04d %015.2f\n", ssn, year, amount))
		}
	}
}
