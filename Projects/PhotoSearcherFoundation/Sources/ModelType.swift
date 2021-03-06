//
//  ModelType.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/23.
//

import Then

/// This protocol applies to all model, entity types.
public protocol ModelType: Then, Decodable {
    /// Global events defined in the model. Created with `PublishSubject<Event>`, you can subscribe to the event stream and send values.
    associatedtype Event = Void
}
