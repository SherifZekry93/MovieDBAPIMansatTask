

import Foundation
class ActorRoot:Codable
{
    let page,total_results:Int?
   // let page, totalPages: Int?
    let results: [Actor]?
}

class Actor:Codable {
    let profile_path, name: String?
}
