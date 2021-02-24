//
//  ApiCallinstance.swift
//  demo
//
//  Created by MacMini on 25/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation
import Alamofire
struct Apicallhandler {
    
    static let sharedInstance : Apicallhandler = {
        let instance = Apicallhandler()
        return instance
    }()
   
    
    
    //Mark : Api call get Login
    
    func LoginNew(URL: String, param:Parameters, onCompletion: @escaping ((_ response: DataResponse<loginResponse>) -> Void)) {
        
        AF.request(URL, method: .post, parameters:param).responseDecodable { (response:DataResponse<loginResponse>) in
            
            onCompletion(response)
        }
        
    }
    
    
    //Mark : Api call get Login // not need
       func APISendOtp(URL: String, param:Parameters, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
           
           AF.request(URL, method: .post, parameters:param).responseJSON { (response:DataResponse<Any>) in
               
               onCompletion(response)
           }
       }
    
    
    //Mark : Api call for city
    
    func ApiCallGetCity(URL: String, param:Parameters, onCompletion: @escaping ((_ response: DataResponse<CityResponse>) -> Void)) {
        
        AF.request(URL, method: .post, parameters:param).responseDecodable { (response:DataResponse<CityResponse>) in
            
            onCompletion(response)
        }
    }
    

    
    //Mark : Api call for Area
    
    func ApiCallGetArea(URL: String, param:Parameters, onCompletion: @escaping ((_ response: DataResponse<AreaResponse>) -> Void)) {
        
        AF.request(URL, method: .post, parameters:param).responseDecodable { (response:DataResponse<AreaResponse>) in
            
            onCompletion(response)
        }
    }
    

    //Mark : Api call for get societies
    func ApiCallGetSociety(URL: String, param:Parameters, onCompletion: @escaping ((_ response: DataResponse<SocietyResponse>) -> Void)) {
        
        AF.request(URL, method: .post, parameters:param).responseDecodable { (response:DataResponse<SocietyResponse>) in
            
            onCompletion(response)
        }
    }
    
    
    //Mark : Api call get Buildings
    func GetAllBuidldings(URL: String, param:Parameters, onCompletion: @escaping ((_ response: DataResponse<BuildingResponse>) -> Void)) {
        
        AF.request(URL, method: .post, parameters:param).responseDecodable { (response:DataResponse<BuildingResponse>) in
            
            onCompletion(response)
        }
    }
    
    //Mark : Api call get Buildings
  /*  func GetAllBuidldingSociety(URL: String,token: String, param:Parameters, onCompletion: @escaping ((_ response: DataResponse<BuildingAddResponse>) -> Void)) {
        
        AF.request(URL, method: .post, parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<BuildingAddResponse>) in
            
            onCompletion(response)
        }
    } */
    
    
    func GetAllBuidldingSociety(token: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<BuildingAddResponse>) -> Void)) {
        
        AF.request(webservices().baseurl + API_GET_BUILDING_SOCIETY, method: .post,parameters:param, headers:["Authorization": "Bearer "+token]).responseDecodable {
            (response:DataResponse<BuildingAddResponse>) in
            
            onCompletion(response)
        }
        
    }
        
    
    //Mark : Api call for get Flats
    func ApiCallGetFlat(URL: String, param:Parameters, onCompletion: @escaping ((_ response: DataResponse<FlatResponse>) -> Void)) {
        
        AF.request(URL, method: .post, parameters:param).responseDecodable { (response:DataResponse<FlatResponse>) in
            
            onCompletion(response)
        }
    }
    
    /*(URL: String,society_id:String,building_id:String, onCompletion: @escaping ((_ response: DataResponse<FlatResponse>) -> Void)) {
        let parameter:Parameters = ["building_id":building_id]
        
        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<FlatResponse>) in
            
            onCompletion(response)
            
        }
    } */
    
    //Mark : Api call SignUp
    func ApiCallSignUp2(URL: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<SignUpStep2Response>) -> Void)) {
       
        AF.request(URL, method: .post, parameters:param).responseDecodable { (response:DataResponse<SignUpStep2Response>) in
            
            onCompletion(response)
            
        }
        
    }
    
    //Mark : Api call Activity-types

    func GetAllResent(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<GetRecentContactResponse>) -> Void)) {
        
        AF.request(URL, method: .post, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GetRecentContactResponse>) in
            
            onCompletion(response)
        }
        
    }
    
    func ApiCallGuestList(type:Int,token: String, onCompletion: @escaping ((_ response: DataResponse<GuestListResponse>) -> Void)) {
        
        AF.request(webservices().baseurl + API_GUEST_LIST, method: .post,parameters:["type":type], encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GuestListResponse>) in
            
            onCompletion(response)
        }
        
    }
    
    //Mark : Api call Activity-types

    func GetAllActivitytypes(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<UserActivityTypeResponse>) -> Void)) {
        
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<UserActivityTypeResponse>) in
            
            onCompletion(response)
        }
        
    }
    
    //Mark : Api call user Activity

    
    func ApiCallUserActivityList(token: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<UserActivityAllResponse>) -> Void)) {
        
        AF.request(webservices().baseurl + API_USER_ACTIVITY_LIST, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<UserActivityAllResponse>) in
            
            onCompletion(response)
        }
        
    }
    
   /* func ApiCallUserActivityList(token: String, onCompletion: @escaping ((_ response: DataResponse<UserActivityAllResponse>) -> Void)) {
        
        AF.request(webservices().baseurl + API_USER_ACTIVITY_LIST, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<UserActivityAllResponse>) in
            
            onCompletion(response)
        }
        
    } */
    
    func ApiCallUserActivityListFilter(UserActivityTypeID:String,token: String, onCompletion: @escaping ((_ response: DataResponse<UserActivityAllResponse>) -> Void)) {
        
        AF.request(webservices().baseurl + API_USER_ACTIVITY_LIST_FILTER_SEARCH + UserActivityTypeID, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<UserActivityAllResponse>) in
            
            onCompletion(response)
        }
        
    }
    
    func ApiCallUserActivityListcancel(URL: String,token: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }
        
    }
    
    func ApiCallMyHelperList(token: String, onCompletion: @escaping ((_ response: DataResponse<MyHelperListResp>) -> Void)) {
        
        AF.request(webservices().baseurl + API_MY_HELPER_LIST, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<MyHelperListResp>) in
            
            onCompletion(response)
        }
        
    }
    
    func ApiCallDeleteHelperList(token: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        AF.request(webservices().baseurl + API_DAILY_HELPER_DELETE, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }
        
    }
    
    func ApiCallNotifyToggleHelperList(token: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        AF.request(webservices().baseurl + API_DAILY_HELPER_NOTIFY_TOGGLE, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }
        
    }
    
    func ApiCallServiceToggleHelperList(token: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        AF.request(webservices().baseurl + API_DAILY_HELPER_NOTIFY_SERVICE, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }
        
    }
    
    
    func ApiCallDeleteFamilyMember(token: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        AF.request(webservices().baseurl + API_DELETE_FAMILY_MEMBER, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }
        
    }
    
    
    func ApiCallDeleteNotification(token: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
           
           AF.request(webservices().baseurl + API_DELETE_NOTIFICATION, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
               
               onCompletion(response)
           }
           
       }
    
    
    
    
    func ApiCallDeleteGuest(token: String, param:Parameters,onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        AF.request(webservices().baseurl + API_DELETE_GUEST, method: .post,parameters:param).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }
        
    }
    
    func ApiCallOUTMember(token: String, param:Parameters,onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
           
           AF.request(webservices().baseurl + API_IN_OUT, method: .post,parameters:param).responseJSON { (response:DataResponse<Any>) in
               
               onCompletion(response)
           }
           
       }
    
    // 1/9/20.
    
    //Mark : Api call get notice
    func GetPollList(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<PollListResponse>) -> Void)) {
       
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<PollListResponse>) in
            
            onCompletion(response)
        }
    }
    
    //Mark : Api call post Poll List Vote
    
    func apicallPollSubmitVote(URL: String, param:Parameters,token:String, onCompletion: @escaping ((_ response: DataResponse<PollListDetails>) -> Void))
    {
        //        let parameter:Parameters = [
        //            "NoticeID":NoticeID,
        //            "OptionID":OptionID
        //        ]
    
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<PollListDetails>) in
            
            onCompletion(response)
    
        }
    }
    

    //Mark : Api call poll Update
    func APIPollDetails(URL: String, param:Parameters,token:String, onCompletion: @escaping ((_ response: DataResponse<PollResultResponse>) -> Void)) {
       
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<PollResultResponse>) in
            
            onCompletion(response)
        }
    }
    
    //Mark : Api call get Amenties
       func GetAmenitiesList(URL: String, token:String , onCompletion: @escaping ((_ response: DataResponse<AmenitiesList>) -> Void)) {
        
          AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<AmenitiesList>) in
               
               onCompletion(response)
            
           }
       }
    
    
    func GetBookingsList(URL: String, token:String , onCompletion: @escaping ((_ response: DataResponse<BookingsList>) -> Void)) {
     
       AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<BookingsList>) in
            
            onCompletion(response)
         
        }
    }
    
    
    // 25/8/20.
    
    
    //Mark : Api call ProductDelete
       func BuySellProductDelete(URL: String, param:Parameters,token:String, onCompletion: @escaping ((_ response: DataResponse<BuySellProductDelete>) -> Void)) {
           
           AF.request(URL, method: .post, parameters:param,headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<BuySellProductDelete>) in
               
               onCompletion(response)
               
           }
       }
    
    //Mark : Api call Buy/Sell
    func GetBuySellList(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<BuySellCategoryList>) -> Void)) {
        
        AF.request(URL, method: .get, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<BuySellCategoryList>) in
            
            onCompletion(response)
            
        }
    }
    
    //Mark : Api call ProductList // Fresh Recommendation
    
    func GetProductList(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<BuySellProductList>) -> Void)) {
        
        AF.request(URL, method: .post,headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<BuySellProductList>) in
            
            onCompletion(response)
            
        }
    }
    
    //Mark : Api call ProductList Buy
    
    func GetProductListBuy(URL: String,param:Parameters, token:String, onCompletion: @escaping ((_ response: DataResponse<BuySellProductList>) -> Void)) {
        
        AF.request(URL, method: .post, parameters:param, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<BuySellProductList>) in
            
            onCompletion(response)
            
        }
    }
    
    //Mark : Api call ProductList
     func GetRelatedProduct(URL: String, param:Parameters,token:String, onCompletion: @escaping ((_ response: DataResponse<BuySellProductList>) -> Void)) {
         
         AF.request(URL, method: .post, parameters:param,headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<BuySellProductList>) in
             
             onCompletion(response)
             
         }
     }
    
    
    /////////////////////////// ////////
    
    func ApiCallGetHelpDesk(URL: String, token:String ,onCompletion: @escaping ((_ response: DataResponse<GetHelpDeskResponse>) -> Void)) {
           

           AF.request(URL, method: .post, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GetHelpDeskResponse>) in
               
               onCompletion(response)
           }
           
       }
    
    
    //Mark : Api call check email exists
    func ApiCallCheckMailExists(URL: String, email:String, onCompletion: @escaping ((_ response: DataResponse<VerifyEmailResponse>) -> Void)) {
        let parameter:Parameters = ["email":email]
        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<VerifyEmailResponse>) in
            onCompletion(response)
            
        }
    }
        
    
    //Mark : Api call get notice
    func GetAllNotice(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<NoticesResponse>) -> Void)) {
       
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<NoticesResponse>) in
            
            onCompletion(response)
        }
    }
    
    //Mark : Api call get notice
       func GetNotificationList(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<NotificationListResp>) -> Void)) {
          
           AF.request(URL, method: .post,parameters:[:], encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<NotificationListResp>) in
               
               onCompletion(response)
           }
       }
    
    
    //Mark : Api call get notice
    func GetAllEvents(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<SocietyEventResponse>) -> Void)) {
        //let parameter:Parameters = ["society_id":societyid , "building_id":BuildingID]
        
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<SocietyEventResponse>) in
            
            onCompletion(response)
        }
        
    }
    
    
    //Mark : Api call get EventList
    
    func GetEventList(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<AddEventTypeResponse>) -> Void)) {
        
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<AddEventTypeResponse>) in
            
            onCompletion(response)
        }
    }
   
    //Mark : Api call get Vehicle
    func GetVehicleList(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<GetVehicleList>) -> Void)) {
        
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GetVehicleList>) in
            
            onCompletion(response)
        }
    }
    
    //Mark : Api call get Vehicle
    func GetVehicleUserList(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<GetVehicleUserList>) -> Void)) {
        
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GetVehicleUserList>) in
            
            onCompletion(response)
            
        }
    }
    
    //Mark : Api call get notice
    func GetADDVehicle(URL: String, param : Parameters ,token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }
    }
    
    
    //Mark : Api call get Circulars
    func GetAllCirculars(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<CircularResponse>) -> Void)) {
        //var parameter:Parameters = ["society_id":societyid]
        
        AF.request(webservices().baseurl + API_USER_GET_CIRCULAR, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<CircularResponse>) in
            
            onCompletion(response)
        }
        

    }
    
    //Mark : Api call get Service Type
    
    func GetAllServiceType(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<ServiceTypeResponse>) -> Void)) {
        //var parameter:Parameters = ["society_id":societyid]
        
        AF.request(webservices().baseurl + API_SERVICE_TYPES, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<ServiceTypeResponse>) in
            
            onCompletion(response)
        }
        

    }
    
    //Mark : Api call get Buildings
    func DeleteCircular(URL: String, id:Int,token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        let parameter:Parameters = ["NoticeID":id]
        
        AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }

    }
    
    
    
    //Mark : Api call get Buildings
    func APIReferFriend(URL: String, param:Parameters,token: String , onCompletion: @escaping ((_ response: DataResponse<ReferFriendModel>) -> Void)) {
        
        AF.request(URL, method: .post, parameters:param,  encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<ReferFriendModel>) in
            onCompletion(response)
            
        }
    }
    
    func APIAttenceHelperList(URL: String, param:Parameters,token: String , onCompletion: @escaping ((_ response: DataResponse<AttendanceHelperResponse>) -> Void)) {
        
        AF.request(URL, method: .post, parameters:param,  encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<AttendanceHelperResponse>) in
            onCompletion(response)
            
        }
    }
    
    
    //Mark : Api call Get Helper
    
      func GetHelperList(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<HelperListResp>) -> Void)) {
          
          AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<HelperListResp>) in
              
              onCompletion(response)
              
          }
      }
    
    
    //Mark : Api call Get Helper
    
    func APIAddReview(URL: String, token:String ,params:Parameters, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
     
        AF.request(URL, method: .post, parameters:params , encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            onCompletion(response)
            
        }
    }
    
    
    //Mark : Api call Get Helper
    
    func GetHelperDetail(URL: String, helperID:String,token:String, onCompletion: @escaping ((_ response: DataResponse<HelperDetailsResponse>) -> Void)) {
        
        let parameter:Parameters = ["DailyHelperID" : helperID]
        
        AF.request(URL, method: .post, parameters:parameter , encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<HelperDetailsResponse>) in
            
            onCompletion(response)
            
        }
    }
    
    func GetHelperAssignDetail(URL: String, dailyHelperID:Int, vendorServiceTypeID:Int, token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        let parameter:Parameters = ["DailyHelperID" : dailyHelperID , "VendorServiceTypeID" : vendorServiceTypeID]
        
        AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in

        
      //  AF.request(URL, method: .post, parameters:parameter , encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<Any>) in
            
            onCompletion(response)
            
        }
    }
    
    
    //Mark : Api call get Buildings
       func DeleteReview(URL: String, id:String,token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
           let parameter:Parameters = ["CommentID":id]
           
           AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
               
               onCompletion(response)
           }

       }
    
    //MARK : Api call Delivery Leave Gate
    func ApicallDeliveryLeaveatGate(URL: String, token:String,VisitingFlatID:NSString,UserActivityID:NSString, onCompletion: @escaping ((_ response: DataResponse<DeliveryatGateResponse>) -> Void)) {
        
        let parameter:Parameters = ["VisitingFlatID":VisitingFlatID,"UserActivityID":UserActivityID]
        AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<DeliveryatGateResponse>) in
            
            onCompletion(response)
        }
        
    }
    
    // MARK: - Api call Deny
    
    func LogoutAPIDeny(URL: String,token: String,VisitingFlatID:NSString,ActivityID:NSString, onCompletion: @escaping ((_ response: DataResponse<logout>) -> Void)) {
       
        let parameter:Parameters = ["VisitingFlatID":VisitingFlatID,"ActivityID":ActivityID]

        AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<logout>) in
         
            onCompletion(response)
            
        }
    }
    
    // MARK: - Api call Delivery Visitor Approve
    
    func ApicallDeliveryVisitorApprove(URL: String, token:String,VisitingFlatID:NSString,ActivityID:NSString, onCompletion: @escaping ((_ response: DataResponse<DeliveryApproveResponse>) -> Void)) {
        
        let parameter:Parameters = ["VisitingFlatID":VisitingFlatID,"ActivityID":ActivityID]
        AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<DeliveryApproveResponse>) in
            
            onCompletion(response)
        }
        
    }
    
    
    //MARK : Api call Accept guest request
    
    func ApiAcceptGuestRequest(URL: String, token:String,type:Int,guest_id:String, onCompletion: @escaping ((_ response: DataResponse<AcceptReject>) -> Void)) {
        
        let parameter:Parameters = ["type":type,"guest_id":guest_id]
        AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<AcceptReject>) in
            
            onCompletion(response)
        }
        

    }
    
    //Mark : Api call Accept guest request
       func ApiDeleteFrequentEntry(URL: String, token:String,guest_id:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
           
           let parameter:Parameters = ["id":guest_id]
           AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
               
               onCompletion(response)
           }
           

       }
    
    //Mark : Api Delete booking Entry
    
       func ApiDeletebookingEntry(URL: String, token:String,booking_id:Int, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
           
           let parameter:Parameters = ["AmenitiesBookingID":booking_id]
           AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
               
               onCompletion(response)
           }
           

       }
    
    //Mark : Api add booking Entry
    
    func ApiAddBookingNow(URL: String,token: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<AddBookingNowResponse>) -> Void)) {
        
        AF.request(URL, method: .post,parameters:param, headers:["Authorization": "Bearer "+token]).responseDecodable {
            (response:DataResponse<AddBookingNowResponse>) in
            
            onCompletion(response)
        }
        
    }
        
    
    //Mark : Api call for get Flats
    
    //Mark : Api call get Login
    
    func LogoutAPI(URL: String,token: String, onCompletion: @escaping ((_ response: DataResponse<logout>) -> Void)) {
       
        AF.request(URL, method: .post, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<logout>) in
         
            onCompletion(response)
            
        }
    }
    
    // read notice
    func apiCallNoticeRead(URL: String,token: String, onCompletion: @escaping ((_ response: DataResponse<logout>) -> Void)) {
       
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<logout>) in
         
            onCompletion(response)
            
        }
    }
    /*
     func LogoutAPI(URL: String, param:Parameters, onCompletion: @escaping ((_ response: DataResponse<logout>) -> Void)) {
         
         AF.request(URL, method: .post, parameters:param).responseDecodable { (response:DataResponse<logout>) in
             
             onCompletion(response)
             
         }
     }

     */
    
    //Mark : Api call add Notice
    func AddCircular(URL: String, param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<AddCircularResponse>) -> Void)) {
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<AddCircularResponse>) in
            
            onCompletion(response)
        }
        
    }
    
    //Mark : Api call add Notice
  /*  func AddNotice(URL: String, param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<NoticesResponse>) -> Void)) {
        
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<NoticesResponse>) in
            
            onCompletion(response)
            
        }
        
    } */
    
    
     func AddNotice(URL: String, param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<AddNoticeResponse>) -> Void)) {
         
         AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<AddNoticeResponse>) in
             
             onCompletion(response)
             
         }
         
     }
    
    
    //Mark : Api call edit Notice
    func EditNotice(URL: String,param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
       
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            onCompletion(response)
        }
        

    }
    
    
    //Mark : Api call add FamilyMember
    
    func APIGetFamilyMember(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<GetFamilyMember>) -> Void)) {
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GetFamilyMember>) in
            
            onCompletion(response)
        }
        
    }
    
    //Mark : Api call add Notice
       func APIGetMemberFamilyList(URL: String, param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<GetFamilyMember>) -> Void)) {
           AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GetFamilyMember>) in
               
               onCompletion(response)
           }
           
       }
    
    //Mark : Api call get GetVehicleList_1
      func GetVehicleList_1(URL: String, param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<GetVehicleList>) -> Void)) {
          
          AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GetVehicleList>) in
              
              onCompletion(response)
          }
      }
    
    //Mark : Api call get Days
    
      func APICallGetDays(URL: String , token:String, onCompletion: @escaping ((_ response: DataResponse<GetDaysResponse>) -> Void)) {
          
          AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GetDaysResponse>) in
              
              onCompletion(response)
          }
      }
    
    //Mark : Api call add Frequent Entry
    func APIAddFrequentEntry(URL: String, param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }
        
    }
    
    //Mark : Api call add Frequent Entry Response
    
    func APIAddFrequentEntryUserResponse(URL: String, param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<UserNewResponse>) -> Void)) {
        
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<UserNewResponse>) in

      //  AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<UserNewResponse>) in
            
            onCompletion(response)
        }
        
    }
    
    
    //Mark : Api call get Members
  //  func GetAllMembers(URL: String,building_id:Int,token:String, onCompletion: @escaping ((_ response: DataResponse<MembersResponse>) -> Void)) {
        
    func GetAllMembers(URL: String,token:String, onCompletion: @escaping ((_ response: DataResponse<MembersResponse>) -> Void)) {

      
      //  let parameter:Parameters = ["society_id":societyid,"building_id":building_id]
        
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<MembersResponse>) in
            onCompletion(response)
        }
        
    }
    
    
    func GetAllMembersSearch(URL: String,token:String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<MembersResponse>) -> Void)) {
        
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<MembersResponse>) in
            onCompletion(response)
        }
        
    }
    
    
    //Mark : Api call Delete Notice
    func DeleteEvent(URL: String, id:Int,token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        let parameter:Parameters = ["NoticeID":id]
        
        AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            onCompletion(response)
        }
        
    }
    
    
    //Mark : Api call Delete Notice
    func DeleteNotice(URL: String, id:String,token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        let parameter:Parameters = ["NoticeID":id]
        
        AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            onCompletion(response)
        }
        
        //        AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
        
    }
    
    
    //Mark : Api call Notify count
    func GetNotifyCount(URL: String, token: String, onCompletion: @escaping ((_ response: DataResponse<NotificationCount>) -> Void)) {
        
        AF.request(URL, method: .get, encoding: JSONEncoding.default,headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<NotificationCount>) in
            
            onCompletion(response)
        }
        
    }
    
    
    //Mark : Api call Notify count
       func GetUpdateNotifyCount(URL: String,param:Parameters,token:String, onCompletion: @escaping ((_ response: DataResponse<UpdateNotificationCount>) -> Void)) {
           
           AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<UpdateNotificationCount>) in
               onCompletion(response)
           }
           
       }
    
    
    //Mark : Api call Notify count
          func APIReminder(URL: String,param:Parameters,token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
              
              AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
                  onCompletion(response)
              }
              
          }
    
    func APINoticeReminder(URL: String,token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
            
        }
        
    }
    
    //  APINoticeReminder
    
  /*  func APINoticeReminder(URL: String,token: String, onCompletion: @escaping ((_ response: DataResponse<logout>) -> Void)) {
       
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<logout>) in
         
            onCompletion(response)
            
        }
    } */
    
    func GetAllCompanySelectDetails(URL: String,token:String, onCompletion: @escaping ((_ response: DataResponse<DeliveryCompanySelectResponse>) -> Void)) {
        
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<DeliveryCompanySelectResponse>) in
            onCompletion(response)
        }
        
    }
    
    //Mark : Api call delete vehicle
    
    //Mark : Api call Add Company Details

    func ApiCallAddCompanyDetails(VendorName: String,VisitorEntryTypeID:Int,token: String,param:Parameters,onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        AF.request(webservices().baseurl + API_ADD_COMPANY_ENTRY, method: .post,parameters:param, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }
        
    }
    
    
    //Mark : Api user me api
    
  /*  func ApiCallAddSettings(token: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<AddSettingResponse>) -> Void)) {
        
        AF.request(webservices().baseurl + API_ADD_SETTING, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<AddSettingResponse>) in
            
                 onCompletion(response)
            }

    } */
    
    func ApiCallAddSettings(token: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
                
        AF.request(webservices().baseurl + API_ADD_SETTING, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
                 onCompletion(response)
            }

    }
    
    
    //Mark : Api user me api
    func ApiCallGetSettings(token: String, onCompletion: @escaping ((_ response: DataResponse<GetSettings>) -> Void)) {
        
        AF.request(webservices().baseurl + API_GET_SETTING, method: .get, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GetSettings>) in
            
                 onCompletion(response)
            }

    }

    
    func ApiCallGetFrequentguestList(token: String, onCompletion: @escaping ((_ response: DataResponse<GetFrequentEntryList>) -> Void)) {
           
           AF.request(webservices().baseurl + API_GET_FREQUENTGUEST_LIST, method: .get, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GetFrequentEntryList>) in
               
               onCompletion(response)
           }
           
       }

    
    
    
    
    
    ////////////////////////================//////////
    
    
    
    
    //Mark : Api call add Buildings
    func AddBuidldings(URL: String, society_id:String,user_id:String,building_name:String,building_description:String, onCompletion: @escaping ((_ response: DataResponse<BuidingResponse>) -> Void)) {
        var parameter:Parameters = ["society_id":society_id,
        "user_id":user_id,
        "building_name":building_name,
        "building_description":building_description]
        
        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<BuidingResponse>) in
            
            onCompletion(response)
            
        }
    }
    
    //Mark : Api call add Buildings
    func EditBuidldings(URL: String,buildingid:String,user_id:String,building_name:String,building_description:String, onCompletion: @escaping ((_ response: DataResponse<UpateBuildingResponse>) -> Void)) {
        let parameter:Parameters = [
                                    "building_id":buildingid,
                                    "user_id":user_id,
                                    "building_name":building_name,
                                    "building_description":building_description]
        
        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<UpateBuildingResponse>) in
            
            onCompletion(response)
            
        }
    }
    
    //Mark : Api call delete Buildings
    func DeleteBuilding(URL: String, id:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameter:Parameters = ["building_id":id]
        
        AF.request(URL, method: .post, parameters:parameter).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
            
        }
    }
    
    
//    //Mark : Api call add circular
//
//  func AddCircular(URL: String, society_id:String,member_id:String,building_id:String,title:String,description:String,file:UIImage, onCompletion: @escaping ((_ response: DataResponse<AddCircularResponse>) -> Void)) {
//        var parameters :Parameters = [
//            "society_id":society_id,
//            "building_id":building_id,
//            "member_id":member_id,
//            "title":title,
//            "description":description,
//        ]
//        AF.upload(
//            multipartFormData: { MultipartFormData in
//                for (key, value) in parameters {
//                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//                }
//
//                if(file != nil)
//                {
//                let imgData = UIImageJPEGRepresentation(file,1)
//                        MultipartFormData.append(imgData!, withName: "file", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
//                }
//
//        }, to:URL).uploadProgress(queue: .main, closure: { progress in
//
//            print("Upload Progress: \(progress.fractionCompleted)")
//        }).responseDecodable(completionHandler: { (response:DataResponse<AddCircularResponse>) in
//
//            onCompletion(response)
//         })
//    }
//
//    //Mark : Api call Edit circular
//
//    func EditCircular(URL: String, id:String,society_id:String,member_id:String,building_id:String,title:String,description:String,file:UIImage, onCompletion: @escaping ((_ response: DataResponse<AddCircularResponse>) -> Void)) {
//
//
//        // circular_id, society_id, building_id, title, description
//        var parameters :Parameters = [
//            "society_id":society_id,
//            "building_id":building_id,
//            "member_id":member_id,
//            "title":title,
//            "description":description,
//        ]
//        AF.upload(
//            multipartFormData: { MultipartFormData in
//                for (key, value) in parameters {
//                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//                }
//
//                if(file != nil)
//                {
//                    let imgData = UIImageJPEGRepresentation(file,1)
//                    MultipartFormData.append(imgData!, withName: "file", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
//                }
//
//        }, to:URL).uploadProgress(queue: .main, closure: { progress in
//
//            print("Upload Progress: \(progress.fractionCompleted)")
//        }).responseDecodable(completionHandler: { (response:DataResponse<AddCircularResponse>) in
//
//            onCompletion(response)
//        })
//    }
//
//

    
    
    //Mark : Api call get Members
    func DeleteMember(URL: String, id:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        let parameter:Parameters = ["id":id]
        
        AF.request(URL, method: .post, parameters:parameter).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
            
        }
    }
    
    
    
    //Mark : Api call Add member
    
    func AddMember(URL: String, society_id:String,building_id:String,member_id:String,member_name:String,member_phone:String,member_email:String,member_house_no:String,member_house_type:String,member_role:String,member_profession:String,member_profession_detail:String,member_username:String,member_password:String,member_gender:String,file:UIImage, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameters :Parameters = [
            "society_id":society_id,
            "building_id":building_id,
            "member_id":member_id,
            "member_name":member_name,
            "member_phone":member_phone,
            "member_email":member_email,
            "member_house_no":member_house_no,
            "member_house_type":member_house_type,
            "member_profession":member_profession,
            "member_profession_detail":member_profession_detail,
            "member_username":member_username,
            "member_password":member_password,
            "member_gender":member_gender,
            "member_role":member_role
        ]
        AF.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in parameters {
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if(file != nil)
                {
                    let imgData = UIImageJPEGRepresentation(file,1)
                    MultipartFormData.append(imgData!, withName: "file", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
        }, to:URL).uploadProgress(queue: .main, closure: { progress in
            
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { (response:DataResponse<Any>) in
            
            onCompletion(response)
        })
    }
    
    
    //Mark : Api call Update member
    
    func UPdateMember(URL: String,user_id:String,society_id:String,building_id:String,member_id:String,member_name:String,member_phone:String,member_email:String,member_house_no:String,member_house_type:String,member_role:String,member_profession:String,member_profession_detail:String,member_username:String,member_password:String,member_gender:String,file:UIImage, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameters :Parameters = [
            "user_id":user_id,
            "society_id":society_id,
            "building_id":building_id,
            "member_id":member_id,
            "member_name":member_name,
            "member_phone":member_phone,
            "member_email":member_email,
            "member_house_no":member_house_no,
            "member_house_type":member_house_type,
            "member_profession":member_profession,
            "member_profession_detail":member_profession_detail,
            "member_username":member_username,
            "member_password":member_password,
            "member_gender":member_gender,
            "member_role":member_role
        ]
        AF.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in parameters {
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if(file != nil)
                {
                    let imgData = UIImageJPEGRepresentation(file,1)
                    MultipartFormData.append(imgData!, withName: "file", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
        }, to:URL).uploadProgress(queue: .main, closure: { progress in
            
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { (response:DataResponse<Any>) in
            
            onCompletion(response)
        })
    }
    
    
    
    
    //Mark : Api call get Vednors
    func GetAllVedors(URL: String, societyid:String, onCompletion: @escaping ((_ response: DataResponse<VendorsResponse>) -> Void)) {
        var parameter:Parameters = ["society_id":societyid]
        
        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<VendorsResponse>) in
            
            onCompletion(response)
            
        }
        
    }
    
    
    //Mark : Api call Delete Vendor
    func DeleteVendor(URL: String, id:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameter:Parameters = ["vendor_id":id]
        
        AF.request(URL, method: .post, parameters:parameter).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
            
        }
    }
    

    //Mark : Api call add Vendor
    
    func AddVendor(URL: String, society_id:String,user_id:String,vendor_name:String,vendor_email:String,vendor_profession:String,vendor_phone:String,file:UIImage, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameters :Parameters = [
            "society_id":society_id,
            "user_id":user_id,
            "vendor_name":vendor_name,
            "vendor_email":vendor_email,
            "vendor_profession":vendor_profession,
            "vendor_phone":vendor_phone
        ]
        AF.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in parameters {
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if(file != nil)
                {
                    let imgData = UIImageJPEGRepresentation(file,1)
                    MultipartFormData.append(imgData!, withName: "file", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
        }, to:URL).uploadProgress(queue: .main, closure: { progress in
            
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { (response:DataResponse<Any>) in
            
            onCompletion(response)
        })
    }
    
    //Mark : Api call Edit Vendor
    
    func EditVendor(URL: String,vendor_id:String, society_id:String,user_id:String,vendor_name:String,vendor_email:String,vendor_profession:String,vendor_phone:String,file:UIImage, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameters :Parameters = [
            "vendor_id":vendor_id,
            "society_id":society_id,
            "user_id":user_id,
            "vendor_name":vendor_name,
            "vendor_email":vendor_email,
            "vendor_profession":vendor_profession,
            "vendor_phone":vendor_phone
        ]
        AF.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in parameters {
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if(file != nil)
                {
                    let imgData = UIImageJPEGRepresentation(file,1)
                    MultipartFormData.append(imgData!, withName: "file", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
        }, to:URL).uploadProgress(queue: .main, closure: { progress in
            
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { (response:DataResponse<Any>) in
            
            onCompletion(response)
        })
    }
    
    //Mark : Api call get all annnouncement
    func GetAllAnnouncement(URL: String, societyid:String, onCompletion: @escaping ((_ response: DataResponse<AnnouncementResponse>) -> Void)) {
        var parameter:Parameters = ["society_id":societyid]
        
        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<AnnouncementResponse>) in
            
            onCompletion(response)
            
        }
        
    }
    
    //Mark : Api call Delete Announcement
    func DeleteAnnoucement(URL: String, id:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameter:Parameters = ["announcement_id":id]
        
        AF.request(URL, method: .post, parameters:parameter).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
            
        }
    }
    
    
    
    

    //Mark : Api call add announcement
    func AddAnnouncement(URL: String, society_id:String, member_id:String, building_id:String, title:String, description:String, view_till:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameter:Parameters = ["society_id":society_id,
        "member_id":member_id,
        "building_id":building_id,
        "title":title,
        "description":description,
        "view_till":view_till,]
        
        AF.request(URL, method: .post, parameters:parameter).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
            
        }
    }
    
    //Mark : Api call edit Annoucement
    func EditAnnoucement(URL: String,announcement_id:String, society_id:String, member_id:String, building_id:String, title:String, description:String, view_till:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameter:Parameters = [
            "announcement_id":announcement_id,
            "society_id":society_id,
            "member_id":member_id,
            "building_id":building_id,
            "title":title,
            "description":description,
            "view_till":view_till,]
        
        AF.request(URL, method: .post, parameters:parameter).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
            
        }
    }
    
   
    //Mark : Api call Add event
    
    func AddEevent(URL: String, society_id:String,user_id:String,title:String,description:String,event_start_date:String,event_start_time:String,event_end_date:String,event_end_time:String,event_type:String,file:UIImage, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameters :Parameters = [
            "society_id":society_id,
            "member_id":user_id,
            "title":title,
            "description":description,
            "event_start_time":event_start_time,
            "event_start_date":event_start_date,
            "event_end_date": event_end_date,
            "event_end_time":event_end_time,
            "event_type":event_type]
        AF.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in parameters {
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if(file != nil)
                {
                    let imgData = UIImageJPEGRepresentation(file,1)
                    MultipartFormData.append(imgData!, withName: "event_attachment", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
        }, to:URL).uploadProgress(queue: .main, closure: { progress in
            
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { (response:DataResponse<Any>) in
            
            onCompletion(response)
        })
    }
    
    
    //Mark : Api call Update event
    
    func UpdateEvent(URL: String, event_id:String,society_id:String,user_id:String,title:String,description:String,event_start_date:String,event_start_time:String,event_end_date:String,event_end_time:String,event_type:String,file:UIImage, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameters :Parameters = [
            "event_id":event_id,
            "society_id":society_id,
            "member_id":user_id,
            "title":title,
            "description":description,
            "event_start_time":event_start_time,
            "event_start_date":event_start_date,
            "event_end_date": event_end_date,
            "event_end_time":event_end_time,
            "event_date":event_start_date,
            "event_time":event_start_time,
            "event_type":event_type]
        AF.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in parameters {
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if(file != nil)
                {
                    let imgData = UIImageJPEGRepresentation(file,1)
                    MultipartFormData.append(imgData!, withName: "event_attachment", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
        }, to:URL).uploadProgress(queue: .main, closure: { progress in
            
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { (response:DataResponse<Any>) in
            
            onCompletion(response)
        })
    }
    
    
//    //Mark : Api Family members
//    func ApiCallGetFamilyMembers(URL: String, member_id:String, onCompletion: @escaping ((_ response: DataResponse<FamilyMemberResponse>) -> Void)) {
//        var parameter:Parameters = ["member_id":member_id]
//        
//        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<FamilyMemberResponse>) in
//            
//            onCompletion(response)
//            
//        }
//    }
    
    //Mark : Api call Add Family Member
    
    func AddFamilyMember(URL: String, member_id:String,family_member_name:String,family_member_phone:String,family_member_gender:String,family_member_dob:String,family_member_bloodgroup:String,family_member_photos:UIImage, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameters :Parameters = [
            "member_id":member_id,
            "family_member_name":family_member_name,
            "family_member_phone":family_member_phone,
            "family_member_gender":family_member_gender,
            "family_member_dob":family_member_dob,
            "family_member_bloodgroup":family_member_bloodgroup]
        AF.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in parameters {
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if(family_member_photos != nil)
                {
                    let imgData = UIImageJPEGRepresentation(family_member_photos,1)
                    MultipartFormData.append(imgData!, withName: "family_member_photos", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
        }, to:URL).uploadProgress(queue: .main, closure: { progress in
            
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { (response:DataResponse<Any>) in
            
            onCompletion(response)
        })
    }
    
    //Mark : Api call Add Family Member
    
    func AddUpdateFamilyMember(URL: String, id:String,member_id:String,family_member_name:String,family_member_phone:String,family_member_gender:String,family_member_dob:String,family_member_bloodgroup:String,family_member_photos:UIImage, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameters :Parameters = [
            "id":id,
            "member_id":member_id,
            "family_member_name":family_member_name,
            "family_member_phone":family_member_phone,
            "family_member_gender":family_member_gender,
            "family_member_dob":family_member_dob,
            "family_member_bloodgroup":family_member_bloodgroup]
        AF.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in parameters {
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if(family_member_photos != nil)
                {
                    let imgData = UIImageJPEGRepresentation(family_member_photos,1)
                    MultipartFormData.append(imgData!, withName: "family_member_photos", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
        }, to:URL).uploadProgress(queue: .main, closure: { progress in
            
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { (response:DataResponse<Any>) in
            
            onCompletion(response)
        })
    }
    
    
    //Mark : Api user me api
    
   /* func ApiCallUserMe(token: String, onCompletion: @escaping ((_ response: DataResponse<UserMeResponse>) -> Void)) {
        
       // AF.request(webservices().baseurl + API_USER_ME, method: .post,parameters:[:], encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<UserMeResponse>) in
        
        AF.request(webservices().baseurl + API_USER_ME, method: .post, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<UserMeResponse>) in

                 onCompletion(response)
            }

    } */
    
    func ApiCallUserMe(URL: String,token: String, onCompletion: @escaping ((_ response: DataResponse<UserMeResponse>) -> Void)) {
       
        AF.request(URL, method: .post, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<UserMeResponse>) in
         
            onCompletion(response)
            
        }
    }
 
    //Mark : Api call Update 

    func ApiCallUpdateProfile(URL: String, id:String,memberemail:String,memberphone:String,member_name:String,member_profession:String,member_profession_detail:String,member_house_type:String,member_role:String,address:String,bloodgroup:String,profile:UIImage, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameters :Parameters = [
            "id":id,
            "memberemail":memberemail,
            "member_name":member_name,
            "memberphone":memberphone,
            "member_profession":member_profession,
            "member_profession_detail":member_profession_detail,
            "member_house_type":member_house_type,
            "member_role":member_role,
            "address":address,
            "bloodgroup":bloodgroup]
        AF.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in parameters {
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if(profile != nil)
                {
                    let imgData = UIImageJPEGRepresentation(profile,1)
                    MultipartFormData.append(imgData!, withName: "profile", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
        }, to:URL).uploadProgress(queue: .main, closure: { progress in
            
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { (response:DataResponse<Any>) in
            
            onCompletion(response)
        })
    }
    
    
    
    //Mark : Updatedevice token
    func UpdateToken(URL: String, memberid:String,token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        var parameter:Parameters = ["memberid":memberid,"token":token]
        
        AF.request(URL, method: .post, parameters:parameter).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
            
        }
    }

    
    
    //Mark : Api Get R
    func ApiGetRole(URL: String, onCompletion: @escaping ((_ response: DataResponse<GetRoleResponse>) -> Void)) {
        var parameter:Parameters = [:]
        
        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<GetRoleResponse>) in
            
            onCompletion(response)
            
        }
    }
    
    // 22/10/20 call
    
   //Mark : Api Get get profression
   func ApiGetProfession (URL: String,token: String, onCompletion: @escaping ((_ response: DataResponse<ProfessionResponse>) -> Void)) {
      
       AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<ProfessionResponse>) in
        
           onCompletion(response)
           
       }
   }
    
    
    //Mark : Api Get get Blood
    
    func ApiCallGetBlood(URL: String,token: String, onCompletion: @escaping ((_ response: DataResponse<BloodGroupResponse>) -> Void)) {
       
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<BloodGroupResponse>) in
         
            onCompletion(response)
            
        }
    }
   
    //Mark : Api call delete vehicle

    func ApiCallDeleteVehicle(Vehicleid:Int,token: String,param:Parameters,onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        AF.request(webservices().baseurl + API_DELETE_VEHICLE, method: .post,parameters:param, headers:["Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }
        
    }
    
    
    
}
