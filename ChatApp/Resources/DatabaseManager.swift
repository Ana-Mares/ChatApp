//
//  DatabaseManager.swift
//  ChatApp
//
//  Created by user217567 on 4/25/22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager{
    
    static let shared = DatabaseManager() //clasa singleton pentru usurinta

    private let database = Database.database(url:"https://chatapp-fbda6-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    
    
    
}

//MARK: - Account Management
extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping ( (Bool) -> Void)) {
        
        var safeForDBEmail = email.replacingOccurrences(of: ".", with: "-") //altfel crapa la interactiunea cu DB-ul
        safeForDBEmail = safeForDBEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeForDBEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    
    /// Inserts new user to database
    public func insertUser (with user: ChatAppUser) {
        database.child(user.safeEmail).setValue([  //=> delimitam userii pe baza email - trebuie sa fie unic
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    //let profilePictureUrl: String
    
    var safeEmail: String {
        var safeForDBEmail = emailAddress.replacingOccurrences(of: ".", with: "-") //altfel crapa la interactiunea cu DB-ul
        safeForDBEmail = safeForDBEmail.replacingOccurrences(of: "@", with: "-")
        return safeForDBEmail
    }
}
