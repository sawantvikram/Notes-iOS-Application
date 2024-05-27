//
//  DatabaseHelper.swift
//  Notes
//
//  Created by Touchzing media on 30/08/23.
//

import Foundation
import FMDB
var shareInstance = DatabaseHelper()
class DatabaseHelper: NSObject{
    
    var database:FMDatabase? = nil
    
    
    class func getInstance() -> DatabaseHelper{
        if shareInstance.database == nil{
            shareInstance.database = FMDatabase(path: Util.getPath("mydb.db"))
        }
        return shareInstance
    }
    
    // "INSERT INTO reginfo (name, username, email, password) VALUES(?,?,?,?)"
    func getAllNotesItems() -> [[String: String]] {
        var notes: [[String: String]] = []
        var noteItemtemp: [String: String] = [:]
        noteItemtemp["Heading"] = "null"
        noteItemtemp["Body"] = "null"
        noteItemtemp["Date"] = "null"
        notes.append(noteItemtemp)
        
        guard let database = shareInstance.database, database.open() else {
            return notes
        }

        do {
            let resultSet = try database.executeQuery("SELECT Heading, Body, Date FROM Notes", values: nil)
            while resultSet.next() {
                var noteItem: [String: String] = [:]
                if let heading = resultSet.string(forColumn: "Heading"),
                   let body = resultSet.string(forColumn: "Body"),
                   let date = resultSet.string(forColumn: "Date") {
                    noteItem["Heading"] = heading
                    noteItem["Body"] = body
                    noteItem["Date"] = date
                    notes.append(noteItem)
                }
            }
        } catch {
            print("Error fetching note items: \(error)")
        }

        shareInstance.database?.close()
        return notes
    }

    
    func updateMenuItem(id: Int, newName: String) -> Bool {
            guard let database = database, database.open() else {
                return false
            }

            do {
                let query = "UPDATE menu SET name = ? WHERE id = ?"
                let success = try database.executeUpdate(query, values: [newName, id])
                database.close()
                return true
            } catch {
                print("Error updating menu item: \(error)")
                database.close()
                return false
            }
        }
    
    
    func deleteMenuItemByName(name: String) -> Bool {
           guard let database = database, database.open() else {
               return false
           }

           do {
               let query = "DELETE FROM menu WHERE name = ?"
               let success = try database.executeUpdate(query, values: [name])
               database.close()
               return true
           } catch {
               print("Error deleting menu item: \(error)")
               database.close()
               return false
           }
       }
    
    
    func insertNoteItem(heading: String, body: String, date: String) -> Bool {
         guard let database = database, database.open() else {
             return false
         }
       
         do {
             let query = "INSERT INTO Notes (Heading, Body, Date) VALUES (?, ?, ?)"
             let success = try database.executeUpdate(query, values: [heading, body, date])
             database.close()
             return true
         } catch {
             print("Error inserting menu item: \(error)")
             database.close()
             return false
         }
     }

     // Get the number of rows in the 'menu' table
    func numberOfRowsInMenuTable() -> Int {
        guard let database = database, database.open() else {
            return 0
        }

        do {
            let resultSet = try database.executeQuery("SELECT COUNT(*) as count FROM menu", values: nil)
            if resultSet.next() {
                let rowCount = resultSet.int(forColumn: "count")
                database.close()
                return Int(rowCount)
            }
        } catch {
            print("Error getting row count: \(error)")
        }

        database.close()
        return 0
    }

    
    func getIDByName(name: String) -> Int? {
           guard let database = database, database.open() else {
               return nil
           }

           do {
               let query = "SELECT id FROM menu WHERE name = ?"
               let resultSet = try database.executeQuery(query, values: [name])

               if resultSet.next() {
                   let id = resultSet.int(forColumn: "id")
                   database.close()
                   return Int(id)
               }
           } catch {
               print("Error getting ID by name: \(error)")
           }

           database.close()
           return nil
       }
}
