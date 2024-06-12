//
//  AuthViewModel.swift
//  GameOnSwiftUI
//
//  Created by Anaia Hoard on 11/06/2024.
//
//This view model is responsible for having all functionalitites associated with authenticating users, sending notifications to users...

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol{
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
        }
    }
    func signIn(withEmail email: String, password: String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }catch{
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    func createUser(withEmail email: String, password: String, fullname: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create account.")
        }
    }
    func signOut(){
        do{
            try Auth.auth().signOut() // sign user out on backend
            self.userSession = nil // wipes out user session
            self.currentUser = nil //wipes out current user data
        }catch{
            print("DEBUG: Failed to sign out with error")
        }
    }
    func deleteAccount(){
        
    }
    func fetchUser() async {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
        
    }
}
