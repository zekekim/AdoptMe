//
//  SwipingPageViewController.swift
//  AdoptMe
//
//  Created by Farhan Hussain on 4/24/22.
//

import UIKit


class SwipingPageViewController: UIViewController {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    //@IBOutlet weak var imageView: UIImageView! // Holds image of dog
    @IBOutlet weak var card: UIView!
    var ogCardPoint: CGPoint?
    var divisor: CGFloat!
    var api = PetAPI()
    var initToken: String?
    var dogArray: [Dog]?
    var currentDog: Dog?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ogCardPoint = card.center
        divisor = (view.frame.width / 2) / 0.61

        var token: String? = nil
        api.authenticate { (result) in
            if(result == "nope")
            {
                
                print("error")
                return
                //HANDLE AUTHENTICATE ERROR
            }
            else {
                self.initToken = result
                token = result
                self.api.fetch(token: token!) { (result) in
                    if(result == nil)
                    {
                        print("error")
                        return
                        //HANDLE DOG EMPTY RESPONSE
                    }
                    else {
                        self.dogArray = result!.filter{$0.photos.count > 0}
                        self.loadCard()
                    }
                }
            }
            
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    //Loads Random Dog Into Card
    //Current Dog is stored in currentDog
    
    func loadCard() {
        dogImage.image = UIImage(named: "corgi-icon-180x180")
        
        var randInt:Int
        var dog:Dog?
        
        if dogArray != nil {
            randInt = Int.random(in: 0..<dogArray!.count)
            dog = dogArray![randInt]
            
            currentDog = dog
            if !(currentDog?.photos.count == 0)  {
                getData(from: URL(string: currentDog?.photos[0].large ?? "")!) { data, response, error in
                    guard let data = data, error == nil else {return}
                    DispatchQueue.main.async() { [weak self] in
                        self?.dogImage.image = UIImage(data: data)
                    }
                }
            }
        } else {
            var imgLoadErroAlert = UIAlertController(title: "Img Could Not Load", message: "Img Could Not Load", preferredStyle: .alert)
            imgLoadErroAlert.addAction( UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            self.present(imgLoadErroAlert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func onBackBtn(_ sender: UIBarButtonItem) {
        dismiss(animated:true, completion: nil)
    }
    

    
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        let timeToResetCard = 0.2
        
        // Allow card to move
        card.center = CGPoint(x: ogCardPoint!.x + point.x, y: ogCardPoint!.y + point.y)
        
        // Rotate card left or right (Affine == to preserve parallel relatioship)
        // 100/2 = 50/0.61 = 81.967
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
        
        // If card is being dragged right... else... left...
        if xFromCenter > 0 {
            thumbImageView.image = UIImage(named: "thumbsUp")
            thumbImageView.tintColor = UIColor.green
        } else {
            thumbImageView.image = UIImage(named: "thumbsDown")
            thumbImageView.tintColor = UIColor.red
        }
        
        thumbImageView.alpha = abs(xFromCenter) / view.center.x
        
        // When finger lets go of card...
        if sender.state == UIGestureRecognizer.State.ended {
            
            // If card close to edge of screen, move card off screen
            if card.center.x < 75 {
                // Move card to the left side
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + timeToResetCard) {
                       //call any function
                    self.resetCard()
                    self.loadCard()
                }
                return
            } else if card.center.x > (view.frame.width - 75) {
                // Move card to right side
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + timeToResetCard) {
                       //call any function
                    self.resetCard()
                    self.loadCard()
                }
                return
            }
            
            // Animate card back to center
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.ogCardPoint!
                self.thumbImageView.alpha = 0
                self.card.transform = CGAffineTransform.identity
            })
            loadCard()
        }
        
        // When card leaves screen, reset and load card back
//        if card.frame.origin.x > 300 {
//            print("HERE")
//            // Animate card back to center
//            UIView.animate(withDuration: 0.2, animations: {
//                card.center = self.ogCardPoint!
//                self.thumbImageView.alpha = 0
//                self.card.transform = CGAffineTransform.identity
//            })
//            loadCard()
//        }
        
    }
    
    @IBAction func reset(_ sender: UIButton) {
        resetCard()
        loadCard()
    }
    
    func resetCard() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.card.center = self.ogCardPoint!
            self.thumbImageView.alpha = 0
            self.card.alpha = 1
            // undos transformationn on card
            self.card.transform = CGAffineTransform.identity
            let imageView = UIProgressView()
            self.dogImage.addSubview(imageView)
        })
        
    }
    
    // Function displays thumbs up on dogImage. Called when card is being swiped rightward
    func displayThumbsUp(){
        
        let image = UIImage(systemName: "hand.thumbsup.fill")
        image?.withTintColor(.black)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: ogCardPoint!.x - 155, y: ogCardPoint!.y - 155, width: 222, height: 222)
        dogImage.addSubview(imageView)
                
        //Imageview on Top of View
        self.view.bringSubviewToFront(imageView)
    }
    
    
    
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

