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
    version := 1.23
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
| `go fmt ./...` | Auto-format code (built-in) |
| `goimports -w .` | Format **and** manage imports (de-facto industry standard) |
| `go vet ./...` | Built-in static analysis – catches common mistakes |
| `go mod tidy` | Add missing and remove unused module dependencies |

> ℹ️ `goimports` is a superset of `go fmt` – it also adds/removes imports automatically. Most IDEs run it on save.

### 1.4 Zero Values

Every variable in Go has a **zero value** when declared without initialization. There is no "undefined" or "null reference" exception. This is fundamental to Go's safety model.

| Type | Zero Value |
|------|------------|
| Numbers (`int`, `float64`, …) | `0` |
| `string` | `""` (empty string) |
| `bool` | `false` |
| Pointers, slices, maps, channels, functions, interfaces | `nil` |
| Structs | All fields set to their zero values |

```go
var s string       // ""
var n int          // 0
var p *User        // nil
var users []User   // nil slice (safe to read, len = 0, but writes via index will panic)
```

### 1.5 Best Practices and Go Idioms

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

Useful for daemons, event loops, and long-running services. Always provide an exit condition (`break`, `return`, or context cancellation):

```go
for {
    select {
    case msg := <-events:
        handle(msg)
    case <-ctx.Done():
        return
    }
}
```

#### Range over Integer (Go 1.22+)

A modern shorthand for "do something N times":

```go
for i := range 5 {
    fmt.Println(i)  // 0, 1, 2, 3, 4
}
```

#### Switch with `fallthrough`

By default Go does **not** fall through to the next case. The `fallthrough` keyword exists but is rarely used:

```go
switch n {
case 1:
    fmt.Println("one")
    fallthrough  // explicitly continue to next case
case 2:
    fmt.Println("two")
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

> ⚠️ **Slice gotcha – shared backing array:** sub-slicing does **not** copy data:
> ```go
> a := []int{1, 2, 3, 4}
> b := a[1:3]   // b shares memory with a
> b[0] = 99     // a is now [1, 99, 3, 4]
> ```
> `append` may or may not allocate a new backing array depending on capacity. To force an independent copy, use `slices.Clone` (Go 1.21+) or `append([]int{}, src...)`.

#### Iteration with for range

```go
for index, value := range numbers {
    fmt.Printf("Index: %d, Value: %d\n", index, value)
}
```

> ⚠️ **String range gotcha:** when you `range` a string, the index is the **byte position** and the value is a **`rune`** (Unicode code point, `int32`), not a `byte`. Multi-byte characters (UTF-8) skip indices.
> ```go
> for i, r := range "łoś" {
>     fmt.Printf("%d %c\n", i, r)  // 0 ł, 2 o, 3 ś  (note: indices jump)
> }
> ```

#### Maps (Dictionaries)

Key-value structures. Must be initialized with `make()` or a literal – a **`nil` map cannot be written to** (it panics).

```go
currencies := make(map[string]string)
currencies["PLN"] = "Zloty"
currencies["USD"] = "Dollar"

// Reading a missing key returns the zero value (does NOT panic):
value := currencies["EUR"]  // value == ""

// Idiomatic "comma ok" check to distinguish "missing" from "zero value":
value, exists := currencies["EUR"]
if !exists {
    fmt.Println("EUR not found in map")
}

// nil map gotcha:
var prices map[string]int
prices["A"] = 1  // panic: assignment to entry in nil map
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

#### Named Return Values

Return values can be named – they are auto-declared as zero-valued variables at function entry. Useful with `defer` for cleanup or when the same return is reused (e.g., in `defer` that mutates `err`):

```go
func readConfig() (cfg Config, err error) {
    defer func() {
        if err != nil {
            err = fmt.Errorf("readConfig: %w", err)
        }
    }()
    // ...
    return  // "naked return" – returns current cfg, err
}
```

> 💡 **When NOT to use naked returns:** in long functions they obscure what's actually returned. Use them only in short helpers or when `defer` mutates the return.

#### Variadic Functions

Accept a variable number of arguments of the same type. Inside the function, the parameter is a slice:

```go
func sum(nums ...int) int {
    total := 0
    for _, n := range nums {
        total += n
    }
    return total
}

sum(1, 2, 3)              // 6
nums := []int{1, 2, 3}
sum(nums...)              // spread slice into variadic call
```

#### Closures

Functions in Go are closures – they capture variables from the surrounding scope **by reference**:

```go
func counter() func() int {
    n := 0
    return func() int {
        n++
        return n
    }
}

c := counter()
c() // 1
c() // 2
```

> ⚠️ Closures inside goroutines are a classic source of bugs – be careful what they capture (especially loop variables, though Go 1.22+ fixes the most common case).

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

> 💡 **Idiomatic Go rarely uses `new()`.** Most code uses struct literals: `u := &User{Name: "Anna"}` is preferred over `u := new(User); u.Name = "Anna"`. `new()` survives mostly in `new(big.Int)` and similar low-level uses.

### 3.4 Garbage Collection

Go has a **concurrent, tri-color mark-and-sweep GC**. You don't manage memory manually – the runtime reclaims unreachable objects in the background with sub-millisecond pause times.

This is why **escape analysis** matters: the compiler decides whether a value lives on the cheap stack or the GC-managed heap.

### 3.5 Best Practices

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

#### Struct Tags

Tags are string metadata attached to fields, read at runtime via reflection. They are how `encoding/json`, `database/sql` drivers, validators, and ORMs map fields:

```go
type User struct {
    ID    int    `json:"id"                       db:"user_id"`
    Name  string `json:"name"                     db:"name"     validate:"required"`
    Email string `json:"email,omitempty"          db:"email"`
}
```

> 📌 `omitempty` skips empty fields when marshaling JSON. Tag syntax has no spaces inside backticks; multiple keys are space-separated.

#### Anonymous Structs

A struct type can be declared inline – useful for tests, local configuration, and one-shot JSON responses:

```go
resp := struct {
    Status string `json:"status"`
    Count  int    `json:"count"`
}{Status: "ok", Count: 42}
```

#### Struct Comparability

Two struct values can be compared with `==` **only if all their fields are comparable**. Structs containing slices, maps, or functions are not comparable and will fail to compile when compared:

```go
type Point struct{ X, Y int }
p1, p2 := Point{1, 2}, Point{1, 2}
p1 == p2  // true – all fields are comparable

type Bag struct{ items []int }
// Bag{} == Bag{}  // compile error
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

> 📌 **Receiver consistency:** if one method on a type uses a pointer receiver, **all methods should** – this avoids confusion about whether a method can mutate the value and makes the type satisfy interfaces consistently.

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

### 5.2 Empty Interface (`any`)

Type `any` is the modern alias (Go 1.18+) for the empty interface `interface{}`. Empty interface has no methods, meaning **every type implements it**. Prefer `any` in new code.

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

#### Type Switch

The canonical way to dispatch on dynamic type:

```go
func describe(i any) {
    switch v := i.(type) {
    case string:
        fmt.Println("string of length", len(v))
    case int:
        fmt.Println("int:", v)
    case nil:
        fmt.Println("nil")
    default:
        fmt.Printf("unsupported: %T\n", v)
    }
}
```

#### Common Standard-Library Interfaces

These appear everywhere in Go code and standard library – worth memorizing:

| Interface | Method | Purpose |
|-----------|--------|---------|
| `error` | `Error() string` | The error contract |
| `fmt.Stringer` | `String() string` | Custom `%v` / `Println` representation |
| `io.Reader` | `Read(p []byte) (n int, err error)` | Stream of bytes in |
| `io.Writer` | `Write(p []byte) (n int, err error)` | Stream of bytes out |
| `io.Closer` | `Close() error` | Resource that must be released |

### 5.3 Typed-Nil Pitfall ⚠️

A classic Go interview question. An interface value is `nil` **only** when both its type and value are nil:

```go
type MyError struct{}
func (*MyError) Error() string { return "boom" }

func bad() error {
    var e *MyError = nil
    return e            // returns a non-nil interface holding (*MyError, nil)
}

err := bad()
if err != nil {
    fmt.Println("got error:", err)  // executes! err != nil even though underlying value is nil
}
```

**Fix:** return literal `nil`, not a typed nil:
```go
func good() error {
    return nil
}
```

### 5.4 Generics (Go 1.18+)

Generics introduced **type parameters**, written in square brackets after the function/type name:

```go
func Map[T, U any](s []T, f func(T) U) []U {
    out := make([]U, len(s))
    for i, v := range s {
        out[i] = f(v)
    }
    return out
}

ints := []int{1, 2, 3}
doubled := Map(ints, func(n int) int { return n * 2 })
```

#### Type Constraints

Constraints specify what operations the type must support. Built-in constraints from `cmp` / `constraints`:

| Constraint | Allows |
|------------|--------|
| `any` | Any type (alias for `interface{}`) |
| `comparable` | Types supporting `==` and `!=` (used as map keys) |
| `cmp.Ordered` (Go 1.21+) | Types supporting `<`, `>` (numbers, strings) |

```go
func Max[T cmp.Ordered](a, b T) T {
    if a > b {
        return a
    }
    return b
}
```

Custom constraints are just interfaces (possibly with type unions):

```go
type Number interface {
    ~int | ~float64
}

func Sum[T Number](nums []T) T {
    var total T
    for _, n := range nums {
        total += n
    }
    return total
}
```

> 💡 **When NOT to reach for generics:** if a small interface (`io.Reader`, `Stringer`) does the job, prefer it. Generics shine for **collections, algorithms, and helpers** (slices/maps utilities, retry wrappers) – not for business logic.

### 5.5 Best Practices for Interface Design

✨ **Design Small Interfaces:** Best interfaces in Go have 1-2 methods (e.g., `io.Reader` or `io.Writer`).

✨ **Accept Interfaces, Return Structs:** 
- Functions should accept interfaces (flexibility, testing)
- Should return concrete types (avoid premature abstraction)

✨ **Define interfaces where they are consumed**, not where the implementation lives. The package that *needs* a behavior owns the interface.

✨ **Compile-time interface assertion** – guarantee a type implements an interface at compile time:

```go
var _ Notifier = (*EmailService)(nil)
```

If `EmailService` ever stops satisfying `Notifier`, the code fails to compile rather than failing at runtime.

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

> ⚠️ **Defer evaluates arguments immediately.** Only the **call** is delayed.
> ```go
> i := 1
> defer fmt.Println(i)  // prints 1, not 2 – `i` was captured at defer time
> i = 2
> ```

> ⚠️ **Defer-in-loop pitfall:** deferred calls fire when the **function** returns, not when the loop iteration ends. Processing a million files like this leaks all file descriptors until the function exits:
> ```go
> for _, path := range paths {
>     f, _ := os.Open(path)
>     defer f.Close()  // BUG: accumulates – will run only at end of function
>     // ...
> }
> ```
> **Fix:** wrap the body in a function, or call `Close()` explicitly inside the loop.

### 6.3 Custom Errors

#### Sentinel Errors

A pre-declared error value, compared with `errors.Is`:

```go
package store

var ErrNotFound = errors.New("store: not found")

// caller:
if errors.Is(err, store.ErrNotFound) {
    // ...
}
```

#### Custom Error Types

A type implementing the `error` interface – useful when you need to carry data:

```go
type ValidationError struct {
    Field string
    Value any
}

func (e *ValidationError) Error() string {
    return fmt.Sprintf("invalid %s: %v", e.Field, e.Value)
}

// caller:
var vErr *ValidationError
if errors.As(err, &vErr) {
    fmt.Println("field:", vErr.Field)
}
```

#### Joining Multiple Errors (Go 1.20+)

When several things can fail (e.g., validating multiple fields):

```go
err := errors.Join(err1, err2, err3)
// `errors.Is` / `errors.As` see all of them
```

### 6.4 Critical Situations: panic and recover

Go's equivalent of uncontrolled exceptions is `panic`. It stops program execution. Function `recover()` catches panic **only inside defer block**.

```go
defer func() {
    if r := recover(); r != nil {
        fmt.Println("Recovered from panic:", r)
    }
}()

panic("critical error!")
```

### 6.5 Best Practices

⚠️ **When to Use panic?** Almost never in application code:
- Truly unrecoverable startup conditions (missing required config, invalid program state at `init`)
- Programmer errors that indicate a bug (e.g., assertions in development)
- **Library code should NOT panic** – return an `error`. Panicking across package boundaries is rude.
- **Business logic** always returns `error`, never panics.

📎 **Error Wrapping** – preserve the chain so callers can still inspect with `errors.Is` / `errors.As`:

```go
return fmt.Errorf("readConfig: %w", err)
```

Use `%w` (wraps the error) when callers might need to inspect it; use `%v` (just formats) when the underlying error doesn't matter to the caller.

Error verification:
```go
errors.Is(err, target)         // sentinel comparison through the wrap chain
errors.As(err, &target)        // type assertion through the wrap chain
errors.Unwrap(err)             // peel one layer manually (rarely needed)
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

#### Channel Directions

In function signatures, you can constrain a channel to send-only or receive-only. This is a strong API hint and is enforced by the compiler:

```go
func producer(out chan<- int) { out <- 1 }   // send-only
func consumer(in <-chan int)  { <-in }       // receive-only
```

#### Closing Channels and `range`

`close(ch)` signals **no more values will be sent**. Receivers can detect this:

```go
ch := make(chan int, 3)
go func() {
    defer close(ch)              // closing is the SENDER's job, not the receiver's
    for i := 0; i < 3; i++ {
        ch <- i
    }
}()

for v := range ch {              // loops until ch is closed AND drained
    fmt.Println(v)
}
```

> 📌 Rules of thumb: **the sender closes** (closing a closed channel panics, sending on a closed channel panics); never close a channel from the receive side; nil channels block forever (useful trick with `select`).

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

### 7.4 Synchronization Primitives (`sync` package)

Not every concurrency problem needs a channel. The `sync` package offers traditional primitives that are often simpler and faster.

#### `sync.WaitGroup` – Spawn and Wait

The most common concurrency pattern: launch N goroutines, wait for all to finish.

```go
var wg sync.WaitGroup
for _, url := range urls {
    wg.Add(1)
    go func(u string) {
        defer wg.Done()
        fetch(u)
    }(url)
}
wg.Wait()
```

#### `sync.Mutex` / `sync.RWMutex`

Use a mutex to protect shared state. `RWMutex` allows many concurrent readers but exclusive writers:

```go
type SafeCounter struct {
    mu sync.Mutex
    n  int
}

func (c *SafeCounter) Inc() {
    c.mu.Lock()
    defer c.mu.Unlock()
    c.n++
}
```

#### `sync.Once` – One-Time Initialization

Guarantees a function runs exactly once, even when called from many goroutines:

```go
var (
    initOnce sync.Once
    db       *sql.DB
)

func getDB() *sql.DB {
    initOnce.Do(func() { db = openDB() })
    return db
}
```

#### `sync/atomic` – Lock-Free Counters

For simple integer counters and flags, atomics are faster than a mutex:

```go
var counter atomic.Int64
counter.Add(1)
fmt.Println(counter.Load())
```

#### `errgroup` – WaitGroup + Error Propagation + Cancel

From `golang.org/x/sync/errgroup` – the standard way to run concurrent tasks that can fail:

```go
g, ctx := errgroup.WithContext(ctx)
for _, url := range urls {
    url := url
    g.Go(func() error {
        return fetch(ctx, url)
    })
}
if err := g.Wait(); err != nil {     // first error cancels ctx for the rest
    return err
}
```

### 7.5 Context (Cancellation, Deadlines, Request Scope)

The `context.Context` type carries **cancellation signals, deadlines, and request-scoped values** through call chains. It is fundamental to any concurrent program – from HTTP servers to background workers.

#### Building Contexts

```go
ctx := context.Background()                              // root
ctx, cancel := context.WithCancel(ctx)                   // manual cancellation
defer cancel()

ctx, cancel := context.WithTimeout(ctx, 5*time.Second)   // auto-cancel after 5s
defer cancel()

ctx, cancel := context.WithDeadline(ctx, t)              // auto-cancel at a wall-clock time
defer cancel()
```

#### Listening for Cancellation

```go
func work(ctx context.Context) error {
    select {
    case <-time.After(5 * time.Second):
        return nil
    case <-ctx.Done():
        return ctx.Err()       // context.Canceled or context.DeadlineExceeded
    }
}
```

#### Best Practices

- **Always pass `ctx` as the first argument** to any function that does I/O or blocking work.
- **Never store a Context in a struct** – pass it explicitly.
- **`context.WithValue` is for request-scoped data only** (trace IDs, auth principals) – not a hidden mechanism for passing optional function parameters.
- **Always call `cancel()`** – usually with `defer` – to release resources.

### 7.6 Best Practices and CSP Model

🏆 **Golden Rule of CSP:**

> "Do not communicate by sharing memory; instead, share memory by communicating"

💡 **When Mutex vs Channel?** Use a `sync.Mutex` when protecting shared state in place (counters, caches, maps). Use a channel when you are actually **passing ownership** of data between goroutines or coordinating workflow.

⚠️ **Goroutine Leaks:** Never launch a goroutine if you don't know how and when it will end. Pair every long-running goroutine with a `context.Context` for cancellation.

⚠️ **Always test with `-race`** during development: `go test -race ./...`. The race detector catches data races that lurk silently in production.

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

### 8.2 Table-Driven Tests and Subtests

This is the **official and most common idiom** for writing tests in Go. Modern style uses **named subtests** via `t.Run` – each case appears separately in the output and can be run in isolation with `-run TestSum/case_name`:

```go
func TestSumTable(t *testing.T) {
    cases := []struct {
        name           string
        a, b, expected int
    }{
        {"positive", 2, 3, 5},
        {"mixed signs", 2, -3, -1},
        {"zero", 0, 0, 0},
    }
    for _, tc := range cases {
        t.Run(tc.name, func(t *testing.T) {
            t.Parallel()  // run cases concurrently
            if got := Sum(tc.a, tc.b); got != tc.expected {
                t.Errorf("Sum(%d, %d) = %d; want %d", tc.a, tc.b, got, tc.expected)
            }
        })
    }
}
```

#### Useful `*testing.T` Methods

| Method | Purpose |
|--------|---------|
| `t.Run(name, fn)` | Sub-test – better output, `-run` filtering |
| `t.Parallel()` | Mark test/sub-test as safe to run in parallel |
| `t.Helper()` | Mark helper – failure line numbers point to caller |
| `t.Cleanup(fn)` | Register cleanup, runs after test (cleaner than `defer` in setup helpers) |
| `t.Skip("reason")` | Skip in current run (e.g., requires external service) |
| `t.Fatalf(...)` | Fail and stop this test immediately |

#### `TestMain` – Package-Level Setup/Teardown

```go
func TestMain(m *testing.M) {
    setupDB()
    code := m.Run()
    teardownDB()
    os.Exit(code)
}
```

#### `testdata/` Convention

The Go tool **ignores** directories named `testdata` for building. Use it to store golden files, fixtures, and sample inputs:

```
mypkg/
├── parser.go
├── parser_test.go
└── testdata/
    ├── valid.json
    └── invalid.json
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

### 8.4 Fuzzing (Go 1.18+)

Fuzz tests generate random inputs to find edge cases and crashes. Function name must start with `Fuzz` and accept `*testing.F`:

```go
func FuzzReverse(f *testing.F) {
    f.Add("hello")                              // seed corpus
    f.Add("")
    f.Fuzz(func(t *testing.T, s string) {
        rev := Reverse(s)
        rev2 := Reverse(rev)
        if rev2 != s {
            t.Errorf("double reverse failed: %q != %q", s, rev2)
        }
    })
}
```

Run with `go test -fuzz=FuzzReverse`. Any failing input is automatically saved to `testdata/fuzz/...` and replayed in subsequent regular `go test` runs.

### 8.5 Example Tests as Living Documentation

Functions starting with `Example` are both tests AND examples rendered on `pkg.go.dev`:

```go
func ExampleSum() {
    fmt.Println(Sum(2, 3))
    // Output: 5
}
```

The `// Output:` comment is compared against actual output – the example is also a test.

### 8.6 CLI Test Tools

| Command | Description |
|---------|-------------|
| `go test ./...` | Run tests |
| `go test -v -run TestX ./pkg` | Verbose, single test |
| `go test -bench=. -benchmem` | Run benchmarks with allocation stats |
| `go test -coverprofile=coverage.out` | Code coverage |
| `go tool cover -html=coverage.out` | View coverage in browser |
| `go test -race ./...` | Race condition detector |
| `go test -fuzz=FuzzX` | Run a fuzz target |
| `go test -shuffle=on` | Randomize test order (catches order-dependence) |

### 8.7 Third-Party Libraries

Standard library is enough for ~90% of needs. When teams reach for external tools:

- **`testify`** (`github.com/stretchr/testify`) – `assert`/`require` packages reduce boilerplate; `mock` package for mock generation. Easy to overuse; prefer stdlib for new projects.
- **`gomock`** (`go.uber.org/mock`) – mock generation when you need strict interfaces verification.
- **`testcontainers-go`** – spin up real Postgres/Redis/Kafka in Docker for integration tests.

---

## 📅 Day 9: Ecosystem, Standard Library, and Web Server

### 9.1 Building an HTTP Server

Go's `net/http` standard library enables building **production-ready servers** without external frameworks. Since Go 1.22, the built-in `ServeMux` supports HTTP-method-prefixed routes and path wildcards – no third-party router needed for most cases:

```go
func statusHandler(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(map[string]string{"status": "OK"})
}

func main() {
    mux := http.NewServeMux()
    mux.HandleFunc("GET /api/status", statusHandler)               // Go 1.22+ syntax
    mux.HandleFunc("GET /users/{id}", userHandler)                 // path wildcard
    http.ListenAndServe(":8080", mux)
}
```

> ℹ️ Before Go 1.22, the `"GET "` prefix had no special meaning – you had to filter `r.Method` manually or use a third-party router.

### 9.2 Production-Ready Server: Timeouts and Graceful Shutdown

`http.ListenAndServe` uses **zero timeouts by default** – a slow client can hold a connection forever. Real production servers always configure timeouts and shut down gracefully on `SIGTERM`:

```go
func main() {
    srv := &http.Server{
        Addr:              ":8080",
        Handler:           mux,
        ReadHeaderTimeout: 5 * time.Second,
        ReadTimeout:       15 * time.Second,
        WriteTimeout:      15 * time.Second,
        IdleTimeout:       60 * time.Second,
    }

    go func() {
        if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
            log.Fatalf("server: %v", err)
        }
    }()

    // Wait for SIGINT/SIGTERM
    stop := make(chan os.Signal, 1)
    signal.Notify(stop, os.Interrupt, syscall.SIGTERM)
    <-stop

    // Drain in-flight requests
    ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
    defer cancel()
    if err := srv.Shutdown(ctx); err != nil {
        log.Printf("graceful shutdown failed: %v", err)
    }
}
```

### 9.3 Middleware Pattern

A middleware is any function that **wraps** an `http.Handler` to add cross-cutting behavior (logging, auth, metrics):

```go
func loggingMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        start := time.Now()
        next.ServeHTTP(w, r)
        slog.Info("request", "method", r.Method, "path", r.URL.Path, "dur", time.Since(start))
    })
}

// Chain:
handler := loggingMiddleware(authMiddleware(mux))
http.ListenAndServe(":8080", handler)
```

### 9.4 Structured Logging with `log/slog` (Go 1.21+)

The old `log` package is fine for hello-world but lacks structure. `log/slog` is the standard structured logger – key-value pairs, multiple handlers (text/JSON), levels, and `context.Context` integration:

```go
logger := slog.New(slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{
    Level: slog.LevelInfo,
}))
slog.SetDefault(logger)

slog.Info("user logged in", "user_id", 42, "ip", r.RemoteAddr)
slog.Error("db query failed", "query", q, "err", err)
```

Output (JSON):
```json
{"time":"2026-05-18T10:00:00Z","level":"INFO","msg":"user logged in","user_id":42,"ip":"1.2.3.4"}
```

> 📌 `slog` reads `context.Context` via `slog.InfoContext(ctx, ...)`, letting you propagate trace IDs and request scope through your log lines.

### 9.5 Other Standard-Library Workhorses

- **`encoding/json`** – `json.NewEncoder(w).Encode(v)` / `json.NewDecoder(r).Decode(&v)` stream over `io.Reader`/`io.Writer` (no full document in memory).
- **`database/sql`** – generic SQL interface; pair with a driver (`pgx`, `lib/pq`, `go-sql-driver/mysql`). Always pass `ctx` to `QueryContext` / `ExecContext`.
- **`time`** – `time.Now()`, `time.Duration`, `time.Ticker`. Note: comparing times uses `t.Equal(u)`, not `==` (different monotonic clock readings).

### 9.6 Best Practices

🚀 **Avoid Framework Overload:** Before adding Gin/Echo/Fiber, ensure built-in `http.NewServeMux` (Go 1.22+) isn't sufficient. Most "framework needs" are met by a router + a few middlewares.

📡 **Stream JSON:** Use `json.NewEncoder`/`json.NewDecoder` directly on IO streams – avoids loading entire documents into memory.

🔐 **Close Response Bodies:** As an HTTP **client**, always close response streams:

```go
resp, err := http.Get(url)
if err != nil {
    return err
}
defer resp.Body.Close()
```

⏱ **Propagate `ctx`** through every handler and downstream call. A canceled context (client disconnected) lets you abort DB queries and outbound HTTP calls early.

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
FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o server main.go

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /app/server /server
EXPOSE 8080
ENTRYPOINT ["/server"]
```

> 💡 **Alternative to `scratch`:** `gcr.io/distroless/static-debian12` adds CA certificates, `/etc/passwd`, time zones, and runs as non-root – nearly as small (~2 MB overhead) but far less painful in production. Use `scratch` only for truly minimal binaries that need nothing from the OS.

#### Build Tags

Conditional compilation per OS, architecture, or custom flag:

```go
//go:build linux && amd64
// +build linux,amd64

package main
```

Custom build tag (compile only with `go build -tags=integration`):
```go
//go:build integration

package main
```

### 10.4 Static Code Analysis and Linters

Run these in order – each catches different issues:

| Tool | What It Does |
|------|--------------|
| `go vet ./...` | Built-in static analysis: shadowed vars, unreachable code, printf format errors, lock-by-value copies |
| `staticcheck ./...` | Stronger checks (unused code, code-smell patterns); from `honnef.co/go/tools` |
| `golangci-lint run ./...` | Meta-linter – runs `govet`, `staticcheck`, `errcheck`, `gosimple`, dozens more under one config |

```bash
go vet ./...
staticcheck ./...
golangci-lint run ./...
```

### 10.5 Security: `govulncheck`

The **official** Go vulnerability scanner. Checks your imports against the Go vulnerability database and reports **only** vulnerabilities your code actually reaches (not just transitive dependency presence):

```bash
go install golang.org/x/vuln/cmd/govulncheck@latest
govulncheck ./...
```

Should be part of every CI pipeline.

### 10.6 Profiling and Diagnostics

When something is slow or leaks memory, reach for `pprof`. Two ways to collect profiles:

#### From Tests / Benchmarks

```bash
go test -cpuprofile=cpu.out -memprofile=mem.out -bench=.
go tool pprof cpu.out          # interactive
go tool pprof -http=:8081 cpu.out   # web UI with flame graphs
```

#### From a Running Server

Add one import to expose `/debug/pprof/` endpoints:

```go
import _ "net/http/pprof"
```

Then collect a 30-second CPU profile from production:

```bash
go tool pprof -http=:8081 http://prod:8080/debug/pprof/profile?seconds=30
go tool pprof http://prod:8080/debug/pprof/heap
go tool pprof http://prod:8080/debug/pprof/goroutine    # detect goroutine leaks
```

> 🔐 Never expose `/debug/pprof/` on a public interface – it leaks runtime details and is expensive to scrape.

---

## 📌 Course Summary

Congratulations! After completing this 10-day course, you should be able to:

✅ Understand **Go philosophy and core principles**  
✅ Write **clean and efficient** Go code (idiomatic style, zero values, slice/map gotchas)  
✅ Work with **structs, interfaces, generics, and polymorphism**  
✅ Handle **errors as values** (sentinels, custom types, `errors.Is`/`As`/`Join`)  
✅ Build **concurrent applications** with goroutines, channels, `sync` primitives, and **context**  
✅ Write **table-driven tests, subtests, fuzz tests, and benchmarks**  
✅ Create **production-grade HTTP servers** with middleware, graceful shutdown, and structured logging (`slog`)  
✅ **Compile, profile (`pprof`), scan (`govulncheck`), and deploy** Go applications to production  

---

## 🔗 Useful Resources

- 📖 [Official Go Documentation](https://go.dev)
- 🎓 [Go by Example](https://gobyexample.com)
- 📚 [Effective Go](https://go.dev/doc/effective_go)
- 🛠️ [Standard Library](https://pkg.go.dev/std)
- 💬 [Go Community](https://go.dev/help)

---

**Happy coding with Go!** 🚀
