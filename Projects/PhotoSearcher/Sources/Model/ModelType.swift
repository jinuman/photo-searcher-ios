//
//  ModelType.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/23.
//

import Then

/// 모든 모델 타입에는 이 프로토콜이 적용됩니다.
public protocol ModelType: Then, Decodable {
    /// 모델에 정의된 전역 이벤트입니다. `PublishSubject<Event>`로 만들어져 이벤트 스트림을 구독하고 값을 전송할 수 있습니다.
    associatedtype Event = Void
}
