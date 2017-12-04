package main

import (
	"os"
	"fmt"
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

	if (err != nil) {
		os.Exit(1)
	}
	fmt.Println("Finding x,y for Spiral position", tgt)

	var x = 0
	var y = 0
	var d = 1
	var m = 1
	var index = 1
	
	for i:=0; i< 50000; i++ {
		

		for 2 * x * d < m {
			fmt.Println(index,":"," (",x,",",y,")")
			if (index == tgt) {
				var dist = abs(x) + abs(y)
				fmt.Println("Distance to origin is: ", dist)
				os.Exit(0)
			}
			index++
			x += d
		}
		
		

		for 2 * y * d < m {
			fmt.Println(index,":"," (",x,",",y,")")
			if (index == tgt) {
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