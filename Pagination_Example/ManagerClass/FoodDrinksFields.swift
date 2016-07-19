//
//  ViewController.swift
//  Pagination_Example
//
//  Created by EkambaramE on 18/07/16.
//  Copyright © 2016 Karya Technologies. All rights reserved.
//

//API response to http://apis-development.fizz.in/hangouts/13.0375051/80.2387716/food-and-drink/1/10?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJGaXp6IGUtVmVudHVyZXMgUHZ0IEx0ZC4iLCJ1c2VySWQiOiI1NzZkMWE4MTI2NDk1MGU3NjM5NGZiMzMiLCJpYXQiOjE0NjgyMzQ4MDd9.ssCNouUOIfxG2H3nI7IkMdqffzL4l5cRkbwe3Xf3Uw4 looks like:

/*
{
    merchantId: "56a3285aa6579ac94739b1ae",
    area: "T. Nagar",
    city: "Chennai",
    timings: [
    [
    "11:00 AM",
    "11:00 PM"
    ]
    ],
    address: "No. 6, Srinivasa Road, T. Nagar, Chennai - 600017",
    latitude: 13.041621698736034,
    longitude: 80.23629875688539,
    createdAt: "2016-01-25T08:54:48.398Z",
    updatedAt: "2016-05-11T09:27:14.393Z",
    tags: [
    "buffet,fine dine,north indian,chinese,t nagar,ozaann,arabian,biryani"
    ],
    id: "56a5e2d8b57755b8b383d799",
    isFavorite: false,
    name: "Ozaann",
    logo: "https://s3-ap-southeast-1.amazonaws.com/fizz-production-bucket/brands/CN40VM9q-ozaanlogo.jpg",
    cashbackPercentage: 4,
    isDiscounted: true,
    awardedLoyalty: false,
    heroImage: "https://s3-ap-southeast-1.amazonaws.com/fizz-production-bucket/hangouts/g5qxDFYR-ozaanimagefinal.jpg",
    distanceFromUser: 0.5303665777983029,
    offers: [
    {
    approvedBy: "56a07585d4490e07d9380a74",
    locationId: "56a5e2d8b57755b8b383d799",
    description: "Get 15% Flat Off on Minimum Bill of Rs. 450/-",
    finePrint: "• Cannot be combined with other offers. • Valid only for Dine-in & Take away. • Discount applicable on bill before taxes. • Taxes as applicable.",
    audience: "all",
    status: "live",
    createdAt: "2016-01-25T08:59:07.445Z",
    updatedAt: "2016-01-28T16:19:00.448Z",
    hangoutId: "",
    offerType: "PercentDiscountMin",
    discount: "15",
    amount: "450",
    maxDiscount: 0,
    id: "56a5e3dbb57755b8b383d79a"
    },
    {
    approvedBy: "56a07585d4490e07d9380a74",
    locationId: "56a5e2d8b57755b8b383d799",
    description: "Get 25% Off on Buffet Bill",
    finePrint: "• Cannot be combined with other offers. • Prior appointment/reservation is recommended. • Valid only for Dine-in. • Discount applicable on bill before taxes. • Taxes as applicable.",
    audience: "all",
    status: "live",
    createdAt: "2016-01-25T09:01:24.289Z",
    updatedAt: "2016-01-28T16:22:17.378Z",
    hangoutId: "",
    offerType: "PercentDiscount",
    discount: "25",
    amount: 0,
    maxDiscount: 0,
    id: "56a5e464b57755b8b383d79b"
    },
    {
    approvedBy: "56a07585d4490e07d9380a74",
    locationId: "56a5e2d8b57755b8b383d799",
    description: "Get 30 - 40% Off on Buffet Bill",
    finePrint: "• Valid only for Special Occasion • Cannot be combined with other offers. • Prior appointment/reservation is recommended. • Valid only for Dine-in. • Discount applicable on bill before taxes. • Taxes as applicable.",
    audience: "all",
    status: "live",
    createdAt: "2016-01-25T09:03:15.480Z",
    updatedAt: "2016-01-28T16:29:58.332Z",
    hangoutId: "",
    offerType: "PercentDiscount",
    discount: "30",
    amount: 0,
    maxDiscount: 0,
    id: "56a5e4d3b57755b8b383d79c"
    }
    ]
},

*/

import Foundation
import Alamofire
import SwiftyJSON

//Key Value
enum FoodDrinksFields: String {
    
    case Name = "name"
    case Area = "area"
    case DistanceFromUser = "distanceFromUser"
    case Logo = "logo"
    case HeroImage = "heroImage"
    case Offers = "offers"
    case Description = "description"
    case Address = "address"
    case Timings = "timings"
    case Tags = "tags"
}

// Adding list of pages
class FoodDrinksWrapper {
    
    var foodDrinks: Array<FoodDrinks>?
    var count: Int?
    var pageNumber = 1
    private var next: String?
    private var previous: String?
}

// Main Classes
class FoodDrinks {
  
    var idNumber: Int?
    var name: String?
    var area: String?
    var distanceFromUser: String?
    var logo: String?
    var heroImage: String?
    var offers: [AnyObject]?
    var timing: String?
    var address : String?
    var tags: [String]?
    
    static var pageNumber  = 1
    static let urlToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJGaXp6IGUtVmVudHVyZXMgUHZ0IEx0ZC4iLCJ1c2VySWQiOiI1NzZkMWE4MTI2NDk1MGU3NjM5NGZiMzMiLCJpYXQiOjE0NjgyMzQ4MDd9.ssCNouUOIfxG2H3nI7IkMdqffzL4l5cRkbwe3Xf3Uw4"
  
    /**
     Initialization the Dictionary
     
     - parameter json: json description
     - parameter id:   id description
     
     - returns: return value description
     */
    
    init() {
    }
    
    required init(json: JSON, id: Int?) {
      
        self.idNumber = id
        self.name = json[FoodDrinksFields.Name.rawValue].stringValue
        self.area = json[FoodDrinksFields.Area.rawValue].stringValue
        self.heroImage = json[FoodDrinksFields.HeroImage.rawValue].stringValue
        self.distanceFromUser = json[FoodDrinksFields.DistanceFromUser.rawValue].stringValue
        self.logo = json[FoodDrinksFields.Logo.rawValue].stringValue
        self.heroImage = json[FoodDrinksFields.HeroImage.rawValue].stringValue
        self.address = json[FoodDrinksFields.Address.rawValue].stringValue
        self.timing = json[FoodDrinksFields.Timings.rawValue][0][0].stringValue
        self.timing = self.timing! + " to " + json[FoodDrinksFields.Timings.rawValue][0][1].stringValue
        self.tags = json[FoodDrinksFields.Tags.rawValue].arrayObject as? [String]
        self.offers = json[FoodDrinksFields.Offers.rawValue].arrayObject  //json[FoodDrinksFields.Offers.rawValue][0][FoodDrinksFields.Description.rawValue].stringValue
    }
 
    /**
     Conficating URL
     
     - returns: return value description
     */
    class func endpointForFoodDrinks() -> String {
        let urlString = "http://apis-development.fizz.in/hangouts/13.0375051/80.2387716/food-and-drink/1/10"
        return urlString
    }
    
    /**
     Get URL string
     
     - parameter path:              path description
     - parameter completionHandler: completionHandler description
     */
    private class func getSpeciesAtPath(path: String, completionHandler: (FoodDrinksWrapper?, NSError?) -> Void) {
       
        Alamofire.request(.GET, path,parameters: ["token": urlToken])
            .responseSpeciesArray { response in
                if let error = response.result.error
                {
                    completionHandler(nil, error)
                    return
                }
                completionHandler(response.result.value, nil)
        }
    }
    
    /**
     Get perticular pages
     
     - parameter completionHandler: completionHandler description
     */
    class func getSpecies(completionHandler: (FoodDrinksWrapper?, NSError?) -> Void) {
        getSpeciesAtPath(endpointForFoodDrinks(), completionHandler: completionHandler)
    }
    
    
    /**
     Get More pages
     
     - parameter wrapper:           wrapper description
     - parameter completionHandler: completionHandler description
     */
    class func getMoreSpecies(wrapper: FoodDrinksWrapper?, completionHandler: (FoodDrinksWrapper?, NSError?) -> Void) {
     
        if wrapper == nil || wrapper?.next == nil
        {
            completionHandler(nil, nil)
            return
        }
        
        getSpeciesAtPath(wrapper!.next!, completionHandler: completionHandler)
    }
}

// MARK: - Extension Alamofire
extension Alamofire.Request {
    
    /**
     Serialize the json object
     
     - parameter completionHandler: completionHandler description
     
     - returns: return value description
     */
    func responseSpeciesArray(completionHandler: Response<FoodDrinksWrapper, NSError> -> Void) -> Self {
       
        let responseSerializer = ResponseSerializer<FoodDrinksWrapper, NSError> { request, response, data, error in
          
            guard error == nil else {
                return .Failure(error!)
            }
            guard let responseData = data else {
                let failureReason = "Array could not be serialized because input data was nil."
                let error = NSError(domain: "com.MyAppDomain.error", code: 6004 , userInfo: [failureReason:failureReason]) // DataSerializationFailed : -6004
                return .Failure(error)
            }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, responseData, error)
            
            switch result {
            case .Success(let value):
               
                let json = SwiftyJSON.JSON(value)
                
                let wrapper = FoodDrinksWrapper()
                
                let nextPageNumber = FoodDrinks.pageNumber + 1
                var previousPageNumber: Int = 1
                if FoodDrinks.pageNumber <= 1 {
                   previousPageNumber  = 1
                } else {
                    previousPageNumber = FoodDrinks.pageNumber - 1
                }
               
                FoodDrinks.pageNumber = nextPageNumber
                wrapper.next = "http://apis-development.fizz.in/hangouts/13.0375051/80.2387716/food-and-drink/" + "\(nextPageNumber)" + "/10"
                wrapper.previous = "http://apis-development.fizz.in/hangouts/13.0375051/80.2387716/food-and-drink/" + "\(previousPageNumber)" + "/10"
                wrapper.count = 140
                
                var allSpecies:Array = Array<FoodDrinks>()
              
                let results = json["data"]
               
                for jsonSpecies in results
                {
                    let species = FoodDrinks(json: jsonSpecies.1, id: Int(jsonSpecies.0))
                    allSpecies.append(species)
                }
                
                wrapper.foodDrinks = allSpecies
                return .Success(wrapper)
                
            case .Failure(let error):
                return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer,
                        completionHandler: completionHandler)
    }
}