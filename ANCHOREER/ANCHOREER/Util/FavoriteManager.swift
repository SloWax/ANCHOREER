//
//  FavoriteManager.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/12.
//

import RealmSwift

protocol Persistable {
    associatedtype ManagedObject : RealmSwift.Object

    init(managedObject : ManagedObject)

    func managedObject() -> ManagedObject
}

class FavoriteManager {
    static let shared = FavoriteManager()
    
    let realm = try! Realm()
    
    func create(_ data: MovieListDto.Response.Item) {
        let movie = data.managedObject()
        
        try! realm.write {
            realm.add(movie)
        }
    }
    
    func retrieve() -> [MovieListDto.Response.Item] {
        let favoriteObjects = realm.objects(RealmItemModel.self)
        var favoriteList = [MovieListDto.Response.Item]()
        
        favoriteObjects.forEach { item in
            let convertItem = MovieListDto.Response.Item(managedObject: item)
            favoriteList.append(convertItem)
        }
        
        return favoriteList
    }
    
    func delete(_ data: MovieListDto.Response.Item) {
        let favoriteObjects = realm.objects(RealmItemModel.self)
        let toDelete = data.managedObject()
        
        if let deleteIndex = favoriteObjects.firstIndex(where: { $0.link == toDelete.link }) {
            try! realm.write {
                realm.delete(favoriteObjects[deleteIndex])
            }
        }
    }
}

class RealmItemModel : Object {
    @objc dynamic var title: String = ""
    @objc dynamic var link: String = ""
    @objc dynamic var image: String? = nil
    @objc dynamic var subtitle: String = ""
    @objc dynamic var pubDate: String = ""
    @objc dynamic var director: String = ""
    @objc dynamic var actor: String = ""
    @objc dynamic var userRating: String = ""
}

extension MovieListDto.Response.Item: Persistable {

    init(managedObject: RealmItemModel) {
        self.title = managedObject.title
        self.link = managedObject.link
        self.image = managedObject.image
        self.subtitle = managedObject.subtitle
        self.pubDate = managedObject.pubDate
        self.director = managedObject.director
        self.actor = managedObject.actor
        self.userRating = managedObject.userRating
    }

    func managedObject() -> RealmItemModel {
        let module = RealmItemModel()
        module.title = self.title
        module.link = self.link
        module.image = self.image
        module.subtitle = self.subtitle
        module.pubDate = self.pubDate
        module.director = self.director
        module.actor = self.actor
        module.userRating = self.userRating
        
        return module
    }
}
