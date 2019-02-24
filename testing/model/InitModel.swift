//
//  InitModel.swift
//  testing
//
//  Created by squock on 13.02.19.
//  Copyright © 2019 squock. All rights reserved.
//

import Foundation

struct SendInit: Encodable{
    var id: Int?
    var token: String? 
}
//Данная модель временно не используется, задание рассмотреть позже
struct InitData: Decodable {
    let pin: String
    let cities: ItemsCities
    let timeWait: Int
    let specialities: ItemsSpecialities
    let callDoctorActivityList: ItemsCallDoctorActivityList
    //let fingerprint: Bool
    let requestsActivityList: ItemsRequestsActivityList
    let ads: String?
    let doctors: ItemsDoctors
    let hospitals: ItemsHospitals
    let entry_doctors: ItemsEntryDoctors
    
    enum CodingKeys: String, CodingKey{
        case pin
        case timeWait = "timeWait"
        case cities = "cities"
        case specialities = "specialities"
        case callDoctorActivityList = "callDoctorActivityList"
        //case fingerprint = "fingerprint"
        case requestsActivityList = "requestsActivityList"
        case ads = "ads"
        case doctors = "doctors"
        case hospitals = "hospitals"
        case entry_doctors = "entry_doctors"
    }
    /*func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pin, forKey: .pin)
    }*/
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pin = try container.decode(String.self, forKey: .pin)
        self.timeWait = try container.decode(Int.self, forKey: .timeWait)
        self.cities = try container.decode(ItemsCities.self, forKey: .cities)
        self.specialities = try container.decode(ItemsSpecialities.self, forKey: .specialities)
        self.callDoctorActivityList = try container.decode(ItemsCallDoctorActivityList.self, forKey: .callDoctorActivityList)
        //self.fingerprint = try container.decode(Bool.self, forKey: .fingerprint)
        self.requestsActivityList = try container.decode(ItemsRequestsActivityList.self, forKey: .requestsActivityList)
        self.ads = try container.decode(String.self, forKey: .ads)
        self.doctors = try container.decode(ItemsDoctors.self, forKey: .doctors)
        self.hospitals = try container.decode(ItemsHospitals.self, forKey: .hospitals)
        self.entry_doctors = try container.decode(ItemsEntryDoctors.self, forKey: .entry_doctors)
    }
}
struct ItemsCities: Decodable{
    let items: [Cities]
    //let version: String
    enum CodingKeys: String, CodingKey{
        case items = "items"
        //case version = "version"
    }
}
struct Cities: Decodable{
    let active: String
    let id: String
    let name: String
    enum CodingKeys: String, CodingKey{
        case active = "active"
        case id = "id"
        case name = "name"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.active = try container.decode(String.self, forKey: .active)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
struct ItemsSpecialities: Decodable{
    let items: [Specialities]
    
    enum CodingKeys: String, CodingKey{
        case items = "items"
    }
}
struct Specialities: Decodable{
    let active: String
    let id: String
    let name: String
    let spec_info: String
    let services: [Services]
   // let situation_ids: [SituationIds]//[String]
    
    enum CodingKeys: String, CodingKey{
        case active = "active"
        case id = "id"
        case name = "name"
        case spec_info = "spec_info"
        case services = "services"
        case situation_ids = "situation_ids"
    }
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.active = try container.decode(String.self, forKey: .active)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
        self.spec_info = try container.decode(String.self, forKey: .spec_info)
        //self.situation_ids = try container.decode([SituationIds].self, forKey: .situation_ids)
        self.services = try container.decode([Services].self, forKey: .services)
    }
}
struct SituationIds: Decodable{
    let sitationIds: String
    
    enum CodingKeys: String, CodingKey {
        case situationIds
    }
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sitationIds = try container.decode(String.self, forKey: .situationIds)
    }
}
struct Services: Decodable{
    let children_count: String
    let id: String
    let level: String
    let name: String
    let order: String
    let parent_id: String
    let speciality_id: String
    
    enum CodingKeys: String, CodingKey{
        case children_count = "children_count"
        case id = "id"
        case level = "level"
        case name = "name"
        case order = "order"
        case parent_id = "parent_id"
        case speciality_id = "speciality_id"
    }
}

struct ItemsCallDoctorActivityList: Decodable{
    let items: [CallDoctorActivityList]
    
    enum CodingKeys: String, CodingKey{
        case items = "items"
    }
}
struct CallDoctorActivityList: Decodable{
    let id: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
    }
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

struct ItemsRequestsActivityList: Decodable{
    let items: [RequestsActivityList]
    
    enum CodingKeys: String, CodingKey{
        case items = "items"
    }
}
struct RequestsActivityList: Decodable{
    let id: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
    }
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
struct ItemsDoctors: Decodable{
    let items: [Doctors]
    
    enum CodingKeys: String, CodingKey{
        case items = "items"
    }
}
struct Doctors: Decodable{
    let fio: String
    let hospital_id: String
    let id: String
    let spec_id: String
    
    enum CodingKeys: String, CodingKey{
        case fio = "fio"
        case hospital_id = "hospital_id"
        case id = "id"
        case spec_id = "spec_id"
    }
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.fio = try container.decode(String.self, forKey: .fio)
        self.hospital_id = try container.decode(String.self, forKey: .hospital_id)
        self.spec_id = try container.decode(String.self, forKey: .spec_id)
    }
}
struct ItemsHospitals: Decodable{
    let items: [Hospitals]
    
    enum CodingKeys: String, CodingKey{
        case items = "items"
    }
}
struct Hospitals: Decodable{
    let cityId: Int
    let id: Int
    let name: String
    let online_pay: Int
    
    enum CodingKeys: String, CodingKey{
        case cityId = "cityId"
        case id = "id"
        case name = "name"
        case online_pay = "online_pay"
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.cityId = try container.decode(Int.self, forKey: .cityId)
        self.name = try container.decode(String.self, forKey: .name)
        self.online_pay = try container.decode(Int.self, forKey: .online_pay)
    }
}
struct ItemsEntryDoctors: Decodable{
    let items: [EntryDoctors]
    
    enum CodingKeys: String, CodingKey{
        case items = "items"
    }
}
struct EntryDoctors: Decodable{
    let fio: String
    let hospital_id: String
    let id: String
    let spec_id: String
    let user_id: String
    
    enum CodingKeys: String, CodingKey{
        case fio = "fio"
        case id = "id"
        case hospital_id = "hospital_id"
        case spec_id = "spec_id"
        case user_id = "user_id"
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.hospital_id = try container.decode(String.self, forKey: .hospital_id)
        self.fio = try container.decode(String.self, forKey: .fio)
        self.spec_id = try container.decode(String.self, forKey: .spec_id)
        self.user_id = try container.decode(String.self, forKey: .user_id)
    }
}
