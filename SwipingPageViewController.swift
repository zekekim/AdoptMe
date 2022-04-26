//
//  SwipingPageViewController.swift
//  AdoptMe
//
//  Created by Farhan Hussain on 4/24/22.
//

import UIKit

class SwipingPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! // Holds image of dog
    
    /*
    // Function queries dogs from PetFinder Api
    func queryDogInfo()
    {
        guard let url = URL(string: "https://api.petfinder.com/v2/types/Dog")
        else {
            return;
        }
        
        var request = URLRequest(url: url)
        
        // Base call
        // GET https://api.petfinder.com/v2/types/{type}
        //      Where "GET" is the method
        //      Where "GET" is the method
        //      Where "GET" is the method

        // Every request needs 3 pieces of info... Method, body, headers
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "name": "Dog",
                    "coats": "Short",
                    "colors": "Black",
                    "genders": "Male"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        // Make the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
        
        do {
//            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let response = try JSONDecoder().decode(Response.self, from: data)
            print("SUCCESS: \(response)")
        }
        catch {
            print(error)
        }
        task.resume()
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    }*/
}


// These two structs allow us to get data from the PetFinder API. Swift provides a protocall called "Codable", which allows us to convert data from a network call (data from a RESTFUL API) into a class/struct with one line of code

struct Response: Codable {
    let name: String
    let coats: String
    let colors: String
    let genders: String
    let breeds: String

}

//struct MyResult: Codable {
//
//}

