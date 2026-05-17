# 📚 Comprehensive Go (Golang) Course – From Basics to Practice
## Professional 10-Day Course

---

## 📖 Table of Contents

### Getting Started
- [Quick Start Guide](#quick-start-guide)
- [Project Directory Structure](#project-directory-structure)

### Course Modules
1. [Day 1: Introduction to Go and Environment Setup](#-day-1-introduction-to-go-and-environment-setup)
2. [Day 2: Control Flow, Loops, and Data Collections](#-day-2-control-flow-loops-and-data-collections)
3. [Day 3: Functions, Pointers, and Memory Management](#-day-3-functions-pointers-and-memory-management)
4. [Day 4: Structs, Methods, and Composition](#-day-4-structs-methods-and-composition)
5. [Day 5: Interfaces and Polymorphism](#-day-5-interfaces-and-polymorphism)
6. [Day 6: Error Handling and Defer](#-day-6-error-handling-and-defer)
7. [Day 7: Concurrency – Goroutines and Channels](#-day-7-concurrency--goroutines-and-channels)
8. [Day 8: Testing and Benchmarking](#-day-8-testing-and-benchmarking)
9. [Day 9: Ecosystem, Standard Library, and Web Server](#-day-9-ecosystem-standard-library-and-web-server)
10. [Day 10: Advanced Tooling, Compilation, and Deployment](#-day-10-advanced-tooling-compilation-and-deployment)

### Reference
- [Course Summary](#-course-summary)
- [Useful Resources](#-useful-resources)

---

## 🚀 Quick Start Guide

### Prerequisites
- Download and install Go from [go.dev](https://go.dev/dl)
- Verify installation: `go version`
- Have a text editor or IDE (VS Code, GoLand, etc.)

### First Project (5 minutes)

```bash
# Create and navigate to a project directory
mkdir my-go-app
cd my-go-app

# Initialize a new module
go mod init my-go-app

# Create main.go file
cat > main.go << 'EOF'
package main

import "fmt"

func main() {
    fmt.Println("Hello, Go!")
}
EOF

# Run the program
go run main.go

# Build an executable
go build -o my-app
./my-app
```

---

## 📁 Project Directory Structure

A well-organized Go project follows this structure:

```
my-go-project/
├── go.mod                 # Module definition
├── go.sum                 # Dependency hashes
├── main.go                # Entry point
├── README.md              # Project documentation
├── cmd/                   # Executable applications
│   ├── server/
│   │   └── main.go
│   └── client/
│       └── main.go
├── pkg/                   # Reusable packages
│   ├── database/
│   │   ├── database.go
│   │   └── database_test.go
│   ├── api/
│   │   ├── handler.go
│   │   └── handler_test.go
│   └── models/
│       ├── user.go
│       └── user_test.go
├── internal/              # Private packages (not importable externally)
│   ├── config/
│   │   └── config.go
│   └── utils/
│       └── helpers.go
├── tests/                 # Integration tests
│   ├── integration_test.go
│   └── fixtures/
├── scripts/               # Build and deployment scripts
│   ├── build.sh
│   └── deploy.sh
└── Dockerfile             # Container configuration
```

### Key Guidelines

📌 **pkg/:** Public packages that can be imported by other projects  
📌 **internal/:** Private packages (Go compiler prevents external imports)  
📌 **cmd/:** Each application entry point gets its own subdirectory  
📌 **_test.go:** Test files stay alongside source files  

---

## 📅 Day 1: Introduction to Go and Environment Setup

### 1.1 Go Language Philosophy

Go (Golang) was designed at **Google in 2007** by Robert Griesemer, Rob Pike, and Ken Thompson. The goal was to create a language that would solve scalability problems in large distributed systems:

- ❌ Slow compilation
- ❌ Complex memory management
- ❌ Inefficient concurrency in existing languages (C++, Java)

#### Core Principles of Go

| Principle | Description |
|-----------|-------------|
| **Simplicity and Minimalism** | Only 25 keywords. No class inheritance, no try-catch, no hidden type conversions |
| **Fast Compilation** | Compiles directly to machine code (single binary) in milliseconds |
| **Built-in Concurrency** | Goroutines and channels support at language level |

### 1.2 Syntax and First Program

Every Go source file must declare a package. An executable program always starts with package `main` and function `main()`.

#### Example: Basic Program

```go
package main

import "fmt"

func main() {
    var languageName string = "Go"
    version := 1.22
    fmt.Printf("Welcome to the world of %s! This course uses Go %v.\n", languageName, version)
}
```

#### Variable Types and Declarations

In Go, the type comes after the variable name:

```go
var x int = 10
var y, z int = 20, 30
var isTrue bool = true
```

### 1.3 Tooling

Go is renowned for its **excellent built-in toolset**. You don't need external package managers or formatting tools.

#### Module Initialization (Dependency Management)

```bash
go mod init my-project
```

This command generates a `go.mod` file that tracks library versions.

#### Running and Compilation

| Command | Description |
|---------|-------------|
| `go run main.go` | In-memory compilation and immediate execution |
| `go build -o app main.go` | Compile to executable file |
| `go fmt ./...` | Auto-format code |

### 1.4 Best Practices and Go Idioms

✅ **Unused Variables and Imports:** Go compiler is uncompromising. If you declare a variable or import a package and don't use it, the program won't compile.

✅ **Naming Conventions:** 
- `camelCase` for internal variables and functions
- `PascalCase` for exported elements

✅ **Short Declarations:** Use `:=` operator inside functions.

---

## 📅 Day 2: Control Flow, Loops, and Data Collections

### 2.1 Conditional Statements (if, switch)

In Go, conditional statements don't require parentheses around conditions, but **curly braces are mandatory**.

#### If with Initialization Section

A unique Go feature: declare a scoped variable directly in the condition:

```go
if shopOpen := checkShop(); shopOpen {
    fmt.Println("I'll go shopping")
} else {
    fmt.Println("Shop is closed")
}
```

#### Switch Statement

```go
switch system := "linux"; system {
case "linux":
    fmt.Println("Linux environment")
case "windows":
    fmt.Println("Windows environment")
default:
    fmt.Println("Other system")
}
```

> ℹ️ In Go, switch doesn't require `break`. Execution ends automatically after a match.

### 2.2 Loops: Only for

Go simplifies the language – there's **only one keyword** for iteration: `for`.

#### Classic Three-Part Loop

```go
for i := 0; i < 5; i++ {
    fmt.Println(i)
}
```

#### Loop as while

```go
n := 1
for n < 5 {
    n *= 2
}
```

#### Infinite Loop

```go
for {
    break
}
```

### 2.3 Data Collections: Arrays, Slices, and Maps

#### Arrays

Fixed size determined at compile time. Rarely used directly.

```go
var numbers [3]int = [3]int{10, 20, 30}
```

#### Slices

Dynamic windows into arrays. They have dynamic size and are passed very efficiently.

```go
numbers := make([]int, 0, 10)
numbers = append(numbers, 1, 2, 3)
```

#### Iteration with for range

```go
for index, value := range numbers {
    fmt.Printf("Index: %d, Value: %d\n", index, value)
}
```

#### Maps (Dictionaries)

Key-value structures. Must be initialized with `make()`.

```go
currencies := make(map[string]string)
currencies["PLN"] = "Zloty"
currencies["USD"] = "Dollar"

// Check if key exists (idiom "comma ok")
value, exists := currencies["EUR"]
if !exists {
    fmt.Println("EUR not found in map")
}
```

### 2.4 Best Practices

🎯 **Guard Clauses (Early Return):** Avoid deep if nesting. Check negation, handle error, and exit function early.

🎯 **Slice Performance:** If you know the target size beforehand, always initialize with capacity:

```go
numbers := make([]int, 0, 100)  // Prevents multiple allocations
```

---

## 📅 Day 3: Functions, Pointers, and Memory Management

### 3.1 Advanced Functions

Functions in Go are **"first-class citizens"** – they can be assigned to variables, passed as arguments, and returned by other functions.

#### Multiple Return Values

Standard mechanism in Go, often used to return a result and error simultaneously:

```go
func divide(a, b float64) (float64, error) {
    if b == 0 {
        return 0, errors.New("cannot divide by zero")
    }
    return a / b, nil
}
```

### 3.2 Pointers

A pointer stores a **memory address**. Go doesn't allow pointer arithmetic (e.g., `p++`), making it safe.

| Operator | Description |
|----------|-------------|
| `&` | Address-of operator |
| `*` | Dereference operator |

#### Example

```go
func changeValuePointer(x *int) {
    *x = 99
}

func main() {
    number := 10
    changeValuePointer(&number)
    fmt.Println(number)  // Output: 99
}
```

### 3.3 Memory Management: new() vs make()

| Function | Handles | Returns | Description |
|----------|---------|---------|-------------|
| `new(T)` | All types | `*T` | Allocates zeroed memory |
| `make(T)` | slice, map, chan | `T` | Allocates and initializes structure |

### 3.4 Best Practices

💡 **When to Use Pointers?** 
- When function must modify passed object
- When structure is large (expensive to copy)

💡 **Escape Analysis:** Go compiler decides whether a variable lives on **Stack** or **Heap**. If a function returns a pointer to a local variable, the compiler automatically moves it to the heap.

---

## 📅 Day 4: Structs, Methods, and Composition

### 4.1 Defining Structs

Go has no classes. **Structs** are used to group data.

```go
type User struct {
    ID     int
    Name   string
    Email  string
    status string
}
```

### 4.2 Methods: Value vs Pointer Receivers

A method is a function with a special argument called **receiver**, binding it to a struct type.

#### Value Receiver (Copy)

Works on a copy of the struct. Modifications inside method don't affect original.

```go
func (u User) Introduce() {
    fmt.Printf("Hello, I'm %s\n", u.Name)
}
```

#### Pointer Receiver (Reference)

Works on the original object in memory. Allows modifying struct fields.

```go
func (u *User) ChangeEmail(newEmail string) {
    u.Email = newEmail
}
```

### 4.3 Composition Instead of Inheritance

Go rejects traditional inheritance (no `extends`). Instead, it uses **composition through struct embedding**.

```go
type Address struct {
    City string
}

type Client struct {
    User
    Address
    TaxID string
}

// Usage:
c := Client{}
c.Name = "John"
c.City = "Warsaw"
```

### 4.4 Best Practices

🔐 **Visibility (Encapsulation):** 
- Capital letter (e.g., `User`) = **exported (public)**
- Lowercase (e.g., `status`) = **unexported (private)**

🏭 **Constructor Pattern (Factory Pattern):**

```go
func NewClient(name string) *Client {
    return &Client{
        User: User{Name: name},
    }
}
```

---

## 📅 Day 5: Interfaces and Polymorphism

### 5.1 Implicit Interface Implementation

In Go, **you don't use** keywords like `implements`. If a struct has all methods defined by an interface, it automatically implements it.

```go
type Notifier interface {
    Notify(message string) error
}

type EmailService struct{}

func (e EmailService) Notify(message string) error {
    fmt.Printf("Sending Email: %s\n", message)
    return nil
}
```

### 5.2 Empty Interface (interface{}) and any Type

Type `any` is an alias for empty interface. Empty interface has no methods, meaning **every type implements it**.

#### Type Assertion

To extract a concrete value from type `any`:

```go
func process(i any) {
    text, ok := i.(string)
    if ok {
        fmt.Println("This is a string:", text)
    }
}
```

### 5.3 Best Practices for Interface Design

✨ **Design Small Interfaces:** Best interfaces in Go have 1-2 methods (e.g., `io.Reader` or `io.Writer`).

✨ **Accept Interfaces, Return Structs:** 
- Functions should accept interfaces (flexibility, testing)
- Should return concrete types (avoid premature abstraction)

---

## 📅 Day 6: Error Handling and Defer

### 6.1 Errors as Values (Error Handling)

Go **doesn't have** exception mechanism (try-catch). Errors are **ordinary values** implementing simple `error` interface.

Standard pattern:

```go
file, err := os.Open("data.txt")
if err != nil {
    return err
}
```

### 6.2 Defer Mechanism

Keyword `defer` **postpones** function execution until the surrounding function ends. Primarily used for resource cleanup.

```go
func processFile() error {
    f, err := os.Open("data.txt")
    if err != nil {
        return err
    }
    defer f.Close()
    return nil
}
```

### 6.3 Critical Situations: panic and recover

Go's equivalent of uncontrolled exceptions is `panic`. It stops program execution. Function `recover()` catches panic **only inside defer block**.

```go
defer func() {
    if r := recover(); r != nil {
        fmt.Println("Recovered from panic:", r)
    }
}()

panic("critical error!")
```

### 6.4 Best Practices

⚠️ **When to Use panic?** 
- Only in situations preventing application startup
- Example: missing configuration file
- **Always return error in business logic**

📎 **Error Wrapping:**

```go
return fmt.Errorf("error: %w", err)
```

Error verification:
```go
errors.Is(err, target)
errors.As(err, &target)
```

---

## 📅 Day 7: Concurrency – Goroutines and Channels

### 7.1 Goroutines (Lightweight Threads)

A goroutine is a function that **runs concurrently** with others. One goroutine uses only ~**2-4 KB RAM**.

To run a function asynchronously, add keyword `go`:

```go
go printText("Asynchronously")
```

### 7.2 Channels

Channels enable **safe communication and data synchronization** between goroutines without memory races.

```go
ch := make(chan int)
go func() {
    ch <- 42
}()
result := <-ch
```

#### Channel Types

| Type | Initialization | Description |
|------|---|---|
| **Unbuffered** | `make(chan T)` | Sender blocks until receiver receives |
| **Buffered** | `make(chan T, capacity)` | Blocks only when buffer is full |

### 7.3 Select Statement

Statement `select` works like `switch` for channel operations. It blocks until one message is ready.

```go
select {
case msg1 := <-channel1:
    fmt.Println("From channel 1:", msg1)
case <-time.After(2 * time.Second):
    fmt.Println("Timeout!")
}
```

### 7.4 Best Practices and CSP Model

🏆 **Golden Rule of CSP:**

> "Do not communicate by sharing memory; instead, share memory by communicating"

💡 **When Mutex?** If you're building simple data structure (e.g., in-memory Cache) and only need to protect map from concurrent writes, traditional `sync.RWMutex` lock is simpler than channels.

⚠️ **Goroutine Leaks:** Never launch a goroutine if you don't know how and when it will end.

---

## 📅 Day 8: Testing and Benchmarking

### 8.1 Built-in Testing Framework

Go **doesn't require** external testing libraries. 

Test file must:
- End with suffix `_test.go`
- Function must start with `Test` and accept `*testing.T`

```go
func TestSum(t *testing.T) {
    if Sum(2, 3) != 5 {
        t.Errorf("Expected 5")
    }
}
```

### 8.2 Table-Driven Tests

This is the **official and most common idiom** for writing tests in Go:

```go
func TestSumTable(t *testing.T) {
    cases := []struct {
        a, b, expected int
    }{
        {2, 3, 5},
        {2, -3, -1},
    }
    for _, tc := range cases {
        result := Sum(tc.a, tc.b)
        if result != tc.expected {
            t.Errorf("Got %d, expected %d", result, tc.expected)
        }
    }
}
```

### 8.3 Performance Tests (Benchmarking)

Functions must start with `Benchmark` and accept `*testing.B`.

```go
func BenchmarkSum(b *testing.B) {
    for i := 0; i < b.N; i++ {
        Sum(10, 20)
    }
}
```

### 8.4 CLI Test Tools

| Command | Description |
|---------|-------------|
| `go test ./...` | Run tests |
| `go test -bench=. -benchmem` | Run benchmarks |
| `go test -coverprofile=coverage.out` | Code coverage |
| `go test -race ./...` | Race condition detector |

---

## 📅 Day 9: Ecosystem, Standard Library, and Web Server

### 9.1 Building Production HTTP Server

Go's `net/http` standard library enables building **production-ready servers** without external frameworks.

```go
func statusHandler(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(map[string]string{"status": "OK"})
}

func main() {
    mux := http.NewServeMux()
    mux.HandleFunc("GET /api/status", statusHandler)
    http.ListenAndServe(":8080", mux)
}
```

### 9.2 Context Package (Lifecycle Management)

Context propagates:
- Cancellation signals (Cancelation)
- Time limits (Timeout)

```go
func queryDatabase(ctx context.Context) error {
    select {
    case <-time.After(5 * time.Second):
        return nil
    case <-ctx.Done():
        return ctx.Err()
    }
}
```

### 9.3 Best Practices

🚀 **Avoid Framework Overload:** Before adding Gin or Fiber, ensure built-in `http.NewServeMux` isn't sufficient.

📡 **Stream JSON:** Use `json.NewEncoder` and `json.NewDecoder` – they operate directly on IO streams without loading entire documents into memory.

🔐 **Close Response Bodies:** As HTTP client, always close response stream:

```go
defer resp.Body.Close()
```

---

## 📅 Day 10: Advanced Tooling, Compilation, and Deployment

### 10.1 Cross-Compilation (Managing Architectures)

Go allows compiling binaries for any system and architecture using environment variables `GOOS` and `GOARCH`.

#### Linux (Intel 64-bit)

```bash
GOOS=linux GOARCH=amd64 go build -o app main.go
```

#### Raspberry Pi (ARM 32-bit)

```bash
GOOS=linux GOARCH=arm GOARM=7 go build -o app-rpi main.go
```

### 10.2 Binary Size Optimization

Flags `-s` and `-w` passed to linker remove debug symbols and drastically reduce size:

```bash
go build -ldflags="-s -w" -o app-prod main.go
```

### 10.3 Minimal Docker Container (Multi-stage Build)

With static compilation, the final container can use **scratch image**, achieving size of just **10-15 MB**.

```dockerfile
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o server main.go

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /app/server /server
EXPOSE 8080
ENTRYPOINT ["/server"]
```

### 10.4 Static Code Analysis and Linters

Official linter aggregator for Go is **golangci-lint**:

```bash
golangci-lint run ./...
```

---

## 📌 Course Summary

Congratulations! After completing this 10-day course, you should be able to:

✅ Understand **Go philosophy and core principles**  
✅ Write **clean and efficient** Go code  
✅ Work with **structs, interfaces, and polymorphism**  
✅ Handle **errors and manage resources**  
✅ Build **concurrent applications** with goroutines and channels  
✅ Write **tests and benchmarks**  
✅ Create **HTTP servers** and network applications  
✅ **Compile and deploy** Go applications to production  

---

## 🔗 Useful Resources

- 📖 [Official Go Documentation](https://go.dev)
- 🎓 [Go by Example](https://gobyexample.com)
- 📚 [Effective Go](https://go.dev/doc/effective_go)
- 🛠️ [Standard Library](https://pkg.go.dev/std)
- 💬 [Go Community](https://go.dev/help)

---

**Happy coding with Go!** 🚀
