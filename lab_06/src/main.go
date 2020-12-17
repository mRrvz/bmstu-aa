package main

import (
	"./ants"
)

func main() {
	ants.RunBenchmarks()
	/*
	   graph := ants.GetGraph("../data/graph_01.txt")
	   /*
	   for i := 0; i < 5; i++ {
	       for j := 0; j < 5; j++ {
	           print(graph[i][j], " ")
	       }
	   }
	   print(graph)
	*/
	/*
	   way := ants.BruteForce(graph)
	   for i := 0; i < 5; i++ {
	       print(way[i], " ")
	   }
	*/
}
