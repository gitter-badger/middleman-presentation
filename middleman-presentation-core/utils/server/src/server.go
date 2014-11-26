package main

import "net/http"
import "path/filepath"
import "os"
import "os/signal"
import "log"
import "math/rand"
import "fmt"
import "time"
import "github.com/gorilla/handlers"
import "github.com/skratchdot/open-golang/open"

func main() {
  go func(){
    sigchan := make(chan os.Signal, 1)
    signal.Notify(sigchan, os.Interrupt)
    <-sigchan
    fmt.Print("Captured CTRL-C. Exit..\n")

    os.Exit(0)
  }()

  dir, err := filepath.Abs(filepath.Dir(os.Args[0]))

  if err != nil {
    log.Fatal(err)
  }

  rand.Seed(time.Now().Unix())
  port := random(1024, 65535)
  listen := fmt.Sprintf("%s:%d", "127.0.0.1", port)


  fmt.Print("Open browser with http://" + listen + "\n")
  err = open.Start("http://" + listen + "/index.html")

  if err != nil {
    log.Fatal(err)
  }

  fmt.Print("Server listens on " + listen + "\n")
  http.Handle("/", handlers.CombinedLoggingHandler(os.Stdout, http.FileServer(http.Dir(dir))))
  panic(http.ListenAndServe(listen, nil))
}

func random(min, max int) int {
  rand.Seed(time.Now().Unix())
  return rand.Intn(max - min) + min
}
