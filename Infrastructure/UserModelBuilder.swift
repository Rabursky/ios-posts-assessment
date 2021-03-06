//
//  UserModelBuilder.swift
//  Posts
//
//  Created by Marcin Raburski on 21.05.2016.
//  Copyright © 2016 Rzeczy. All rights reserved.
//

import Domain
import SwiftyJSON

class UserModelBuilder: ModelBuilder<UserModel> {
    override func build() throws -> UserModel {
        guard let input = self.input, let id = input["id"].int, let username = input["username"].string else {
            throw BuilderError.CouldNotParse
        }
        
        return UserModel(id: id, username: username)
    }
}
