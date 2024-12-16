// The Swift Programming Language
// https://docs.swift.org/swift-book

import Limbo

print("Hello, world!")

let sqlite3_ver = sqlite3_libversion_number()
print("sqlite3_version: \(sqlite3_ver)")

var db: OpaquePointer?

let part1DbPath = "testing.db"
if sqlite3_open(part1DbPath, &db) == SQLITE_OK {
    print("Successfully opened connection to database at \(part1DbPath)")
} else {
    print("Unable to open database.")
}

sqlite3_close(db)
