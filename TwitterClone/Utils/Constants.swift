//
//  Constants.swift
//  TwitterClone
//
//  Created by made reihan on 25/03/24.
//

import Firebase
import FirebaseStorage
 
let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let REF_TWEETS = DB_REF.child("tweets")

let REF_USER_TWEETS = DB_REF.child("user-tweets")
