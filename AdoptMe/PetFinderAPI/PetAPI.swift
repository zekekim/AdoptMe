//
//  Authentication.swift
//  AdoptMe
//
//  Created by zeke kim on 4/27/22.
//

import Foundation
import Alamofire
import AlamofireImage




/*
 
* FIRST: Initialize PetAPI, ex. let api = PetAPI()
* SECOND: GET Request for Dogs, returning Dogs, ex. let dogs = PetAPI.fetch()
* THIRD: Access Dog objects, ex. let dog = Dogs.dogs[0]
* Note Dogs.dogs returns an array of Dog objects.
* Access dog data types by using ex. dog.id, dog.name, etc.
 
*/

//IDEA: Build PetAPI into observable object, where State is persisted through @Published and can access Dogs anywhere in the app. Not sure.

let clientID = "5TICZe10KCs0Nxw1VwDaMhQhArJMVoWVuF73EsL9on5KxKSF80"
let clientSecret = "JGBcAcBhWNGOaQV2U3uPAUeJYkUmhFweTnzQxOWv"

public class PetAPI {
    
    //If ever needed to authenticate again, you can use this method
    
    func authenticate(completionHandler: @escaping (_ result: String?) -> ()) {
        var initToken = ""
        let request = AF.request(
            "https://api.petfinder.com/v2/oauth2/token",
            method: .post,
            parameters: [
                "grant_type"    : "client_credentials",
                "client_id"     : clientID,
                "client_secret" : clientSecret
            ])
        
        request.responseDecodable(of: AuthResponse.self){ (response) in
            if let status = response.response?.statusCode {
                switch(status) {
                case 200:
                    if let authResponse = response.value{
                        initToken = authResponse.token
                        return completionHandler(initToken)
                    }
                default:
                        return completionHandler(nil)
                }
            }
        }
    }
    
    //USE Dogs.dogs to fetch the dogs.
    
    func fetch(token: String, completionHandler: @escaping (_ result: [Dog]?) -> ()) {
        var dogs:[Dog] = []

        let headers:HTTPHeaders = [
        "Authorization": "Bearer " + token
        ]
        let request = AF.request(
            "https://api.petfinder.com/v2/animals?type=dog",
            headers: headers
        )

        request.responseDecodable(of: Dogs.self) { (response) in
            if let status = response.response?.statusCode {
                switch(status) {
                case 200:
                    if let response = response.value {
                        dogs = response.dogs
                        return completionHandler(dogs)
                    }
                case 401:
                    print("access denied")
                case 500:
                    print("unexpected")
                case 403:
                    print("bad priveleges")
                case 404:
                    print("not found")
                default:
                    print("lol")
                        return completionHandler(nil)
                }
            }
        }
        
    }
}





