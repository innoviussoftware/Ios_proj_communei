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
    
    //Mark : Api call get Login
       func APISendOtp(URL: String, param:Parameters, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
           
           AF.request(URL, method: .post, parameters:param).responseJSON { (response:DataResponse<Any>) in
               
               onCompletion(response)
           }
       }
    
    
    //Mark : Api call for city
    func ApiCallGetCity (URL: String, onCompletion: @escaping ((_ response: DataResponse<CityResponse>) -> Void)) {
        let parameter:Parameters = [:]
        
        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<CityResponse>) in
            
            onCompletion(response)
            
        }
    }
    
    //Mark : Api call for Area
    func ApiCallGetArea (URL: String,city_id:String, onCompletion: @escaping ((_ response: DataResponse<AreaResponse>) -> Void)) {
        let parameter:Parameters = ["city_id":city_id]
        
        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<AreaResponse>) in
            
            onCompletion(response)
            
        }
    }

    //Mark : Api call for get societies
    func ApiCallGetSociety (URL: String,city_id:String,area_id:String, onCompletion: @escaping ((_ response: DataResponse<SocietyResponse>) -> Void)) {
        let parameter:Parameters = ["area_id":area_id]
        
        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<SocietyResponse>) in
            
            onCompletion(response)
            
        }
    }
    
    
    //Mark : Api call for get Flats
    func ApiCallGetFlat (URL: String,society_id:String,building_id:String, onCompletion: @escaping ((_ response: DataResponse<FlatResponse>) -> Void)) {
        let parameter:Parameters = ["building_id":building_id]
        
        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<FlatResponse>) in
            
            onCompletion(response)
            
        }
    }
    
    //Mark : Api call SignUp
    func ApiCallSignUp2(URL: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<SignUpStep2Response>) -> Void)) {
       
        AF.request(URL, method: .post, parameters:param).responseDecodable { (response:DataResponse<SignUpStep2Response>) in
            
            onCompletion(response)
            
        }
        
    }
    
    func ApiCallGuestList(type:Int,token: String, onCompletion: @escaping ((_ response: DataResponse<GuestListResponse>) -> Void)) {
        
        AF.request(webservices().baseurl + API_GUEST_LIST, method: .post,parameters:["type":type], encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GuestListResponse>) in
            
            onCompletion(response)
        }
        
    }
    
    
    func ApiCallMyHelperList(token: String, onCompletion: @escaping ((_ response: DataResponse<MyHelperListResp>) -> Void)) {
        
        AF.request(webservices().baseurl + API_MY_HELPER_LIST, method: .post,parameters:[:], encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<MyHelperListResp>) in
            
            onCompletion(response)
        }
        
    }
    
    
    func ApiCallDeleteFamilyMember(token: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        AF.request(webservices().baseurl + API_DELETE_FAMILY_MEMBER, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
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
    
    
    
    func ApiCallGetHelpDesk(param:Parameters,onCompletion: @escaping ((_ response: DataResponse<GetHelpDeskResponse>) -> Void)) {
           
           AF.request(webservices().baseurl + API_GET_HELP_DESK, method: .post,parameters:param).responseDecodable { (response:DataResponse<GetHelpDeskResponse>) in
               
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
       
        AF.request(URL, method: .post,parameters:[:], encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<NoticesResponse>) in
            
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
    func GetAllEvents(URL: String, societyid:String,BuildingID:String,token:String, onCompletion: @escaping ((_ response: DataResponse<EvenetResponse>) -> Void)) {
        //let parameter:Parameters = ["society_id":societyid , "building_id":BuildingID]
        
        AF.request(URL, method: .post,parameters:[:], encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<EvenetResponse>) in
            
            onCompletion(response)
        }
        
    }
   
    //Mark : Api call get notice
    func GetVehicleList(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<GetVehicleList>) -> Void)) {
        
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GetVehicleList>) in
            
            onCompletion(response)
        }
    }
    
    //Mark : Api call get notice
    func GetADDVehicle(URL: String, param : Parameters ,token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }
    }
    
    
    //Mark : Api call get Circulars
    func GetAllCirculars(URL: String, token:String, onCompletion: @escaping ((_ response: DataResponse<CircularResponse>) -> Void)) {
        //var parameter:Parameters = ["society_id":societyid]
        
        AF.request(webservices().baseurl + API_USER_GET_CIRCULAR, method: .post,parameters:[:], encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<CircularResponse>) in
            
            onCompletion(response)
        }
        

    }
    
    //Mark : Api call get Buildings
    func DeleteCircular(URL: String, id:String,token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        let parameter:Parameters = ["circular_id":id]
        
        AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }

    }
    
    //Mark : Api call get Buildings
    func GetAllBuidldings(URL: String, societyid:String, onCompletion: @escaping ((_ response: DataResponse<BuildingResponse>) -> Void)) {
        let parameter:Parameters = ["society_id":societyid]
        
        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<BuildingResponse>) in
            
            onCompletion(response)
            
        }
    }
    
    
    //Mark : Api call get Buildings
    func APIReferFriend(URL: String, param:Parameters, onCompletion: @escaping ((_ response: DataResponse<ReferFriendModel>) -> Void)) {
        
        AF.request(URL, method: .post, parameters:param).responseDecodable { (response:DataResponse<ReferFriendModel>) in
            onCompletion(response)
            
        }
    }
    
    
    
    //Mark : Api call Get Helper
      func GetHelperList(URL: String, societyid:String, onCompletion: @escaping ((_ response: DataResponse<HelperListResp>) -> Void)) {
          let parameter:Parameters = ["society_id":societyid]
          
          AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<HelperListResp>) in
              
              onCompletion(response)
              
          }
      }
    
    
    //Mark : Api call Get Helper
    func APIAddReview(URL: String, token:String ,params:Parameters, onCompletion: @escaping ((_ response: DataResponse<AddRatingReviewResponse>) -> Void)) {
        AF.request(URL, method: .post, parameters:params , encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<AddRatingReviewResponse>) in
            onCompletion(response)
            
        }
    }
    
    
    //Mark : Api call Get Helper
    func GetHelperDetail(URL: String, helperID:String,userId:String, onCompletion: @escaping ((_ response: DataResponse<HelperDetailsResponse>) -> Void)) {
        let parameter:Parameters = ["id" : helperID ,"user_id":userId]
        
        AF.request(URL, method: .post, parameters:parameter).responseDecodable { (response:DataResponse<HelperDetailsResponse>) in
            
            onCompletion(response)
            
        }
    }
    
    
    //Mark : Api call get Buildings
       func DeleteReview(URL: String, id:String,token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
           let parameter:Parameters = ["id":id]
           
           AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
               
               onCompletion(response)
           }

       }
    
    
    
    
    //Mark : Api call Accept guest request
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
    
    
    
    //Mark : Api call get Login
    func LogoutAPI(URL: String, param:Parameters, onCompletion: @escaping ((_ response: DataResponse<logout>) -> Void)) {
        
        AF.request(URL, method: .post, parameters:param).responseDecodable { (response:DataResponse<logout>) in
            
            onCompletion(response)
            
        }
    }
    
    //Mark : Api call add Notice
    func AddCircular(URL: String, param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<AddCircularResponse>) -> Void)) {
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<AddCircularResponse>) in
            
            onCompletion(response)
        }
        
    }
    
    //Mark : Api call add Notice
    func AddNotice(URL: String, param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<AddNoticeResponse>) -> Void)) {
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<AddNoticeResponse>) in
            onCompletion(response)
        }
        
    }
    
    //Mark : Api call edit Notice
    func EditNotice(URL: String,param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
       
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            onCompletion(response)
        }
        

    }
    
    
    //Mark : Api call add Notice
    func APIGetFamilyMember(URL: String, param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<GetFamilyMember>) -> Void)) {
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GetFamilyMember>) in
            
            onCompletion(response)
        }
        
    }
    
    //Mark : Api call add Notice
       func APIGetMemberFamilyList(URL: String, param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<GetFamilyMember>) -> Void)) {
           AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<GetFamilyMember>) in
               
               onCompletion(response)
           }
           
       }
    
    
    
    //Mark : Api call add Notice
    func APIAddFrequentEntry(URL: String, param : Parameters , token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        AF.request(URL, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }
        
    }
    
    
    //Mark : Api call get Members
    func GetAllMembers(URL: String, societyid:String,building_id:String,token:String, onCompletion: @escaping ((_ response: DataResponse<MembersResponse>) -> Void)) {
        let parameter:Parameters = ["society_id":societyid,"building_id":building_id]
        
        AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<MembersResponse>) in
            onCompletion(response)
        }
        
    }
    
    //Mark : Api call Delete Notice
    func DeleteEvent(URL: String, id:String,token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        let parameter:Parameters = ["event_id":id]
        
        AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            onCompletion(response)
        }
        
    }
    
    
    //Mark : Api call Delete Notice
    func DeleteNotice(URL: String, id:String,token:String, onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        let parameter:Parameters = ["notice_id":id]
        
        AF.request(URL, method: .post,parameters:parameter, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            onCompletion(response)
        }
        
    }
    
    
    //Mark : Api call Notify count
    func GetNotifyCount(URL: String,token:String, onCompletion: @escaping ((_ response: DataResponse<NotificationCount>) -> Void)) {
        
        AF.request(URL, method: .get, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<NotificationCount>) in
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
    
    
    //Mark : Api user me api
    func ApiCallAddSettings(token: String,param:Parameters, onCompletion: @escaping ((_ response: DataResponse<AddSettingResponse>) -> Void)) {
        
        AF.request(webservices().baseurl + API_ADD_SETTING, method: .post,parameters:param, encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<AddSettingResponse>) in
            
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
    func ApiCallUserMe(token: String, onCompletion: @escaping ((_ response: DataResponse<UserMeResponse>) -> Void)) {
        
        AF.request(webservices().baseurl + API_USER_ME, method: .post,parameters:[:], encoding: JSONEncoding.default, headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseDecodable { (response:DataResponse<UserMeResponse>) in
            
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
    
    
   //Mark : Api Get get profression
   func ApiGetProfession(URL: String, onCompletion: @escaping ((_ response: DataResponse<ProfessionResponse>) -> Void)) {
       var parameter:Parameters = [:]
       
       AF.request(URL, method: .get, parameters:parameter).responseDecodable { (response:DataResponse<ProfessionResponse>) in
           onCompletion(response)
           
       }
   }
   
    
    //Mark : Api call delte vehicle

    func ApiCallDeleteVehicle(Vehicleid:String,token: String,onCompletion: @escaping ((_ response: DataResponse<Any>) -> Void)) {
        
        AF.request(webservices().baseurl + API_DELETE_VEHICLE + Vehicleid, method: .get,headers:["Accept": "application/json","Authorization": "Bearer "+token]).responseJSON { (response:DataResponse<Any>) in
            
            onCompletion(response)
        }
        
    }
    
    
    
}
