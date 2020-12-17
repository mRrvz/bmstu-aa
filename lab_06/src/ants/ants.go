package ants

import (
	"math"
	"math/rand"
	"time"
)

const (
	UintSize = 32 << (^uint(0) >> 32 & 1)
	MaxInt   = 1<<(UintSize-1) - 1
	MinInt   = -MaxInt - 1

	alpha = 3.0
	betta = 7.0
	q     = 20.0
	p     = 0.6

	pheromonCoef = 0.5
)

// Colony colony structure
type Colony struct {
	graph    [][]int
	pheromon [][]float64
	days     int
}

// Ant ant structure
type Ant struct {
	colony  *Colony
	visited [][]int
	path    [][]bool
	pos     int
}

func (colony *Colony) createAnt(position int) *Ant {
	ant := new(Ant)
	ant.colony = colony
	ant.visited = make([][]int, len(colony.graph))

	for i := 0; i < len(colony.graph); i++ {
		ant.visited[i] = make([]int, len(colony.graph))

		for j := 0; j < len(colony.graph[i]); j++ {
			ant.visited[i][j] = colony.graph[i][j]
		}
	}

	ant.pos = position
	ant.path = make([][]bool, len(colony.graph))

	for i := 0; i < len(colony.graph); i++ {
		ant.path[i] = make([]bool, len(colony.graph))
	}

	return ant
}

func (ant *Ant) getProbability() []float64 {
	probability := make([]float64, 0)
	sum := float64(0)

	for i, j := range ant.visited[ant.pos] {
		if 0 != j {
			d := math.Pow(ant.colony.pheromon[ant.pos][i], betta) * math.Pow((float64(1)/float64(j)), alpha)
			probability = append(probability, d)
			sum += d
		} else {
			probability = append(probability, 0)
		}
	}

	for _, val := range probability {
		val = val / sum
	}

	return probability
}

func (ant *Ant) updatePheromon() {
	delta := float64(0)

	for r := 0; r < len(ant.colony.pheromon); r++ {
		for i, j := range ant.colony.pheromon[r] {

			if 0 != ant.colony.graph[r][i] {
				delta = 0
				if ant.path[r][i] {
					delta = q / float64(ant.colony.graph[r][i])
				}

				ant.colony.pheromon[r][i] = (1 - p) * (float64(j) + delta)
			}

			if ant.colony.pheromon[r][i] <= 0 {
				ant.colony.pheromon[r][i] = 0.1
			}
		}
	}
}

func chooseWay(path []float64) int {
	sum := float64(0)

	for _, j := range path {
		sum += j
	}

	random := rand.New(rand.NewSource(time.Now().UnixNano())).Float64() * sum
	sum = 0

	for i, j := range path {
		if random < sum+j && random > sum {
			return i
		}

		sum += j
	}

	return MinInt
}

func (ant *Ant) makeMove(j int) {
	for i := range ant.visited {
		ant.visited[i][ant.pos] = 0
	}

	ant.path[ant.pos][j] = true
	ant.pos = j
}

func (ant *Ant) startMove() {
	way := MaxInt

	for cond := true; cond; cond = (way != MinInt) {
		way = chooseWay(ant.getProbability())

		if MinInt != way {
			ant.makeMove(way)
			ant.updatePheromon()
		}
	}
}

func (ant *Ant) distance() int {
	distance := 0

	for i, j := range ant.path {
		for k, sign := range j {
			if sign {
				distance += ant.colony.graph[i][k]
			}
		}
	}

	return distance
}

func pathContains(path []int, value int) bool {
	for i := 0; i < len(path); i++ {
		if path[i] == value {
			return true
		}
	}

	return false
}

func calculateRoutes(position int, graph [][]int, path []int, routes *[][]int) {
	path = append(path, position)

	if len(path) < len(graph) {
		for i := 0; i < len(graph); i++ {
			if !pathContains(path, i) {
				calculateRoutes(i, graph, path, routes)
			}
		}
	} else {
		*routes = append(*routes, path)
	}
}

// BruteForce let's go brute!
func BruteForce(graph [][]int) []int {
	path := make([]int, 0)
	shortest := make([]int, len(graph))

	for r := 0; r < len(graph); r++ {
		routes := make([][]int, 0)
		calculateRoutes(r, graph, path, &routes)

		minSum := int(MaxInt)

		for i := 0; i < len(routes); i++ {
			curr := 0
			for j := 0; j < len(routes[i])-1; j++ {
				curr += graph[routes[i][j]][routes[i][j+1]]
			}

			if curr < minSum {
				minSum = curr
			}
		}

		shortest[r] = minSum
	}

	return shortest
}

// CreateColony creating colony
func CreateColony(graph [][]int, days int) *Colony {
	colony := new(Colony)
	colony.graph = graph
	colony.days = days
	colony.pheromon = make([][]float64, len(colony.graph))

	for i := 0; i < len(colony.graph); i++ {
		colony.pheromon[i] = make([]float64, len(colony.graph[i]))

		for j := 0; j < len(colony.pheromon[i]); j++ {
			colony.pheromon[i][j] = pheromonCoef
		}
	}

	return colony
}

// GoAnts let's go ant clolony optimization!
func GoAnts(colony *Colony) []int {
	shortest := make([]int, len(colony.graph))

	for i := 0; i < colony.days; i++ {
		for j := 0; j < len(colony.graph); j++ {
			ant := colony.createAnt(j)
			ant.startMove()
			current := ant.distance()

			if (current < shortest[j]) || (0 == shortest[j]) {
				shortest[j] = current
			}
		}
	}

	return shortest
}
