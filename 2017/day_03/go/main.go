package main

import (
	"fmt"
	"os"
	"strconv"
)

func abs(x int) int {
	if x < 0 {
		return -x
	} else {
		return x
	}
}

func main() {

	var tgt, err = strconv.Atoi(os.Args[1])

	if err != nil {
		os.Exit(1)
	}
	fmt.Println("Finding x,y for Spiral position", tgt)

	var x = 0
	var y = 0
	var d = 1
	var m = 1
	var index = 1

	// Initialize grid2d value map
	var grid2d = map[int]map[int]int{}
	for x := -1000; x < 1000; x++ {
		grid2d[x] = map[int]int{}
		for y := -1000; y < 1000; y++ {
			grid2d[x][y] = 0
		}
	}

	grid2d[0][0] = 1

	for i := 0; i < 50000; i++ {

		for 2*x*d < m {
			n := grid2d[x][y+1]
			ne := grid2d[x+1][y+1]
			nw := grid2d[x-1][y+1]
			e := grid2d[x+1][y]
			se := grid2d[x+1][y-1]
			s := grid2d[x][y-1]
			sw := grid2d[x-1][y-1]
			w := grid2d[x-1][y]

			if grid2d[x][y] == 0 {
				grid2d[x][y] = n + ne + nw + e + se + s + sw + w
			}
			fmt.Println(index, ":", " (", x, ",", y, ") =>", grid2d[x][y])

			if index == tgt {
				var dist = abs(x) + abs(y)
				fmt.Println("Distance to origin is: ", dist)
				os.Exit(0)
			}
			index++
			x += d
		}

		for 2*y*d < m {
			n := grid2d[x][y+1]
			ne := grid2d[x+1][y+1]
			nw := grid2d[x-1][y+1]
			e := grid2d[x+1][y]
			se := grid2d[x+1][y-1]
			s := grid2d[x][y-1]
			sw := grid2d[x-1][y-1]
			w := grid2d[x-1][y]

			if grid2d[x][y] == 0 {
				grid2d[x][y] = n + ne + nw + e + se + s + sw + w
			}
			fmt.Println(index, ":", " (", x, ",", y, ") =>", grid2d[x][y])

			if index == tgt {
				var dist = abs(x) + abs(y)
				fmt.Println("Distance to origin is: ", dist)
				os.Exit(0)
			}

			index++
			y += d
		}

		d *= -1
		m += 1

	}
}
