package ants

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strconv"
	"strings"
)

// GetGraph read graph from file
func GetGraph(fname string) [][]int {
	graph := make([][]int, 0)
	file, err := os.Open(fname)

	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	defer file.Close()
	reader := bufio.NewReader(file)

	for {
		line, err := reader.ReadString('\n')
		if err == io.EOF {
			break
		}

		line = strings.TrimSuffix(line, "\n")
		line = strings.TrimSuffix(line, "\r")
		line = strings.TrimRight(line, " ")

		splittedLine := strings.Split(line, " ")
		path := make([]int, 0)

		for _, i := range splittedLine {
			num, err := strconv.Atoi(i)

			if err != nil {
				fmt.Println(err)
			}

			path = append(path, num)
		}

		graph = append(graph, path)
	}

	return graph
}
