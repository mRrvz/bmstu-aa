package ants

import (
	"fmt"
	"time"
)

// RunBenchmarks benchmarks!
func RunBenchmarks() {
	benchCount := 10
	bruteForceTime := make([]time.Duration, 0)
	antsTime := make([]time.Duration, 0)

	for i := 0; i < benchCount; i++ {

		graph := GetGraph("../data/graph_01.txt")
		colony := CreateColony(graph, 100)

		start := time.Now()
		_ = GoAnts(colony)
		end := time.Now()
		//fmt.Println(value)

		antsTime = append(antsTime, end.Sub(start))

		start = time.Now()
		_ = BruteForce(graph)
		end = time.Now()

		bruteForceTime = append(bruteForceTime, end.Sub(start))
	}

	for i := 0; i < benchCount; i++ {
		fmt.Println("Graph size: ", i, "\t| Brute force time: ", bruteForceTime[i], "\t| Ants time: ", antsTime[i])
	}
}
