//
//  Questions.swift
//  GK
//
//  Created by Oscar on 2021/02/12.
//

import Foundation

struct Questions: Decodable {
    let has_more: Bool
    let quota_max: Int
    let quota_remaining: Int
    let items: [QuestionsData]
}

struct QuestionsData: Decodable {
    let is_answered: Bool
    let view_count: Int
    let answer_count: Int
    let score: Int
    let title: String
    let body: String
    let owner: OwnerData
    let creation_date: Int
    let tags: [String]
}

struct OwnerData: Decodable {
    let display_name: String
    let reputation: Int
    let profile_image: String
}
