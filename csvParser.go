// Author: Peter Reveles
// Creation Date: July 19, 2014

package main

import (
    "fmt"
    "net/http"
    "encoding/csv"
    //"strings"
    "time"
    "os"
)

const csv_URL ="http://forever.codeforamerica.org/fellowship-2015-tech-interview/Violations-2012.csv"

func main() {
	// pull data
    data, _ := http.Get(csv_URL)

    reader := csv.NewReader(data.Body)

   	records, _ := reader.ReadAll()

   	categoriesMap_Count := make(map[string]int)
   	categoriesMap_EarliestViolation := make(map[string]time.Time)
   	categoriesMap_LatestViolation := make(map[string]time.Time)

   	// parse data
   	for rowIDX, row := range records{
   		if rowIDX == 0 {
   			// this is the row which contains col titles
   			continue
   		}
   		
   		// col 0 -> violation_id
   		// col 1 -> inspection_id
   		// col 2 -> violation_category
   		// col 3 -> violation_date
   		// col 4 -> violation_date_closed
   		// col 5 -> violation_type
   		category := row[2]
   		violationDate := row[3]
   		// count violations per category
   		categoriesMap_Count[category]++
   		// keep track of earliest & latest violation date

    	// Mon Jan 2 15:04:05 -0700 MST 2006
    	t,_ := time.Parse("2006-01-02 15:04:05", violationDate)
    	//fmt.Println(t)

   		if currentEarliestViolationDate, ok := categoriesMap_EarliestViolation[category]; ok {
   			if t.Before(currentEarliestViolationDate) {
   				categoriesMap_EarliestViolation[category] = t
   			}
   		} else {
   			categoriesMap_EarliestViolation[category] = t
   		}

   		if currentLatestViolationDate, ok := categoriesMap_LatestViolation[category]; ok {
   			 if t.After(currentLatestViolationDate) {
   				categoriesMap_LatestViolation[category] = t
   			}
   		} else {
   			categoriesMap_LatestViolation[category] = t
   		}
   	}

   	// write data
   	file, err := os.Create("results.csv")

   	if err != nil {
   		panic(err)
   	}

   	writer := csv.NewWriter(file)
   	colTitles := make([]string, 4)
    colTitles[0] = "violation_category"
    colTitles[1] = "times_occured"
    colTitles[2] = "earliest_violation"
    colTitles[3] = "latest_violation"

    writer.Write(colTitles)

    for category, occurences := range categoriesMap_Count {
    	// violation_category
	   	// times_occured
	   	// earliest_violation
	   	// latest_violation
	   	//fmt.Println(data)
    	row := make([]string, 4)
    	row[0] = category
    	row[1] = fmt.Sprintf("%d", occurences)
    	row[2] = categoriesMap_EarliestViolation[category].String()
    	row[3] = categoriesMap_LatestViolation[category].String()

    	writer.Write(row)
	}

	writer.Flush()
	file.Close()
	fmt.Println("Job Complete")
}