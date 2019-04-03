

import Foundation
struct ActorRoot:Codable
{
    let page,total_results:Int
   // let page, totalPages: Int
    let results: [Actor]
}

struct Actor:Codable {
    let profile_path, name: String
}
