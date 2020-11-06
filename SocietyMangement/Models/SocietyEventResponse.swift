//
//  SocietyEventResponse.swift
//  SocietyMangement
//
//  Created by Macmini on 06/11/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct SocietyEventResponse: Codable {
    let status: Int?
    let data: [SocietyEvent]?
    let message: String?
}

// MARK: - Datum
struct SocietyEvent: Codable {
    let noticeID, noticeTypeID: Int
    let title: String? //Title
    let datumDescription: String? // Description
    let publishDate: String?
    let visibleTill: String? //EventEndDate
    let eventTypeID: Int
    let eventStartDate: String? //EventStartDate
    let eventEndDate: String? //EventEndDate
    let creationDate, createdBy: String
    let pollEnabled, multiPollEnable, societyID: Int
    let attachments: [String]?
    let readAt: String?

    enum CodingKeys: String, CodingKey {
        case noticeID = "NoticeID"
        case noticeTypeID = "NoticeTypeID"
        case title = "Title"
        case datumDescription = "Description"
        case publishDate = "PublishDate"
        case visibleTill = "VisibleTill"
        case eventTypeID = "EventTypeID"
        case eventStartDate = "EventStartDate"
        case eventEndDate = "EventEndDate"
        case creationDate = "CreationDate"
        case createdBy = "CreatedBy"
        case pollEnabled = "PollEnabled"
        case multiPollEnable = "MultiPollEnable"
        case societyID = "SocietyID"
        case attachments
        case readAt = "ReadAt"
    }
}

/*
 
 {
     "data": [
         {
             "NoticeID": 113,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-28 10:51:08",
             "CreatedBy": "d56ef08b-0af8-400f-a6c1-6706ca77dda0",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [
                 "public/notices/event/LwSxcSU3ebdjfRCr8XiNUs2gGon4gnxn6cwwEMN0.jpeg"
             ],
             "ReadAt": null
         },
         {
             "NoticeID": 116,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-28 11:15:51",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [],
             "ReadAt": null
         },
         {
             "NoticeID": 119,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-28 17:36:28",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [],
             "ReadAt": null
         },
         {
             "NoticeID": 120,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-28 17:36:39",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [],
             "ReadAt": null
         },
         {
             "NoticeID": 121,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-28 17:37:27",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [
                 "public/notices/event/TCtx58gipqUJQpuvbV80vvjwzwIE1jvUDZXy66So.jpeg"
             ],
             "ReadAt": null
         },
         {
             "NoticeID": 122,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-28 17:37:50",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [
                 "public/notices/event/loGgAPDSSzvd46gd0BtO2SyD8sNiJ3PVSy7wx3Vq.jpeg"
             ],
             "ReadAt": null
         },
         {
             "NoticeID": 123,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-28 17:39:08",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [
                 "public/notices/event/SQ25zElqTJF3uJl7nwQEItmCArcFHi5ipM67FIkC.svg"
             ],
             "ReadAt": null
         },
         {
             "NoticeID": 124,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-28 17:39:40",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [
                 "public/notices/event/lpyvn26BxBEXk7gxEbB1ooYKzHeYSoqfabxs7ynw.png"
             ],
             "ReadAt": null
         },
         {
             "NoticeID": 125,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-28 17:39:59",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [
                 "public/notices/event/YYy881za6GTIznDAwkLKDM6njflu5mZGWjRBnJoP.png"
             ],
             "ReadAt": null
         },
         {
             "NoticeID": 126,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-28 17:40:10",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [
                 "public/notices/event/VFmzyGjDuDjxWjffWOQg59LHuGrGwXBoigdOB2C7.png"
             ],
             "ReadAt": null
         },
         {
             "NoticeID": 127,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-28 17:40:16",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [
                 "public/notices/event/PFQvRS7iWtsXWOdohoVvcNiPr8ARULxPLu5AkJ6h.png"
             ],
             "ReadAt": null
         },
         {
             "NoticeID": 128,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-29 04:59:41",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [
                 "public/notices/event/4iGeYonsoAOCulirYNhVlUTpJG4pAXszatJxxLPY.png"
             ],
             "ReadAt": null
         },
         {
             "NoticeID": 129,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-29 05:00:05",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [
                 "public/notices/event/rCKSAhR5uReQesYPQIZ0hUY6xzB0gNrSP3ekKdUD.png"
             ],
             "ReadAt": null
         },
         {
             "NoticeID": 130,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-29 05:03:55",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [
                 "public/notices/event/T68IKnXqWFleprny68IhwGdgVAPYULL1iKNEIo6G.png"
             ],
             "ReadAt": null
         },
         {
             "NoticeID": 131,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": null,
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-29 08:21:53",
             "CreatedBy": "d56ef08b-0af8-400f-a6c1-6706ca77dda0",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [
                 "public/notices/event/hZoyDyZVHUeVKnHBix8fCzMmBrLzRfqV1otKjB9c.png"
             ],
             "ReadAt": null
         },
         {
             "NoticeID": 134,
             "NoticeTypeID": 3,
             "Title": "My fourth event ed",
             "Description": "My fourth event description ed",
             "PublishDate": "2020-10-31 13:28:17",
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 00:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-10-31 13:28:17",
             "CreatedBy": "d56ef08b-0af8-400f-a6c1-6706ca77dda0",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [
                 "public/notices/event/sx8Ht0Xzf3fPnW7mQ0HLHAGRXE1qcx2HhRVXIphM.png"
             ],
             "ReadAt": null
         },
         {
             "NoticeID": 139,
             "NoticeTypeID": 3,
             "Title": "uuhu",
             "Description": "ttyy",
             "PublishDate": "2020-11-06 07:02:04",
             "VisibleTill": "2020-11-06 12:31:00",
             "EventTypeID": 1,
             "EventStartDate": "2020-11-06 12:31:00",
             "EventEndDate": "2020-11-06 12:31:00",
             "CreationDate": "2020-11-06 07:02:04",
             "CreatedBy": "8efc9b3c-3ce4-4b56-ab8e-ae0d2acfa7df",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [],
             "ReadAt": null
         },
         {
             "NoticeID": 141,
             "NoticeTypeID": 3,
             "Title": "My event 20201027 001",
             "Description": "My event 20201027 001",
             "PublishDate": "2020-11-06 11:03:14",
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 10:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-11-06 11:03:14",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [],
             "ReadAt": null
         },
         {
             "NoticeID": 142,
             "NoticeTypeID": 3,
             "Title": "My event 20201027 001",
             "Description": "My event 20201027 001",
             "PublishDate": "2020-11-06 11:15:42",
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 10:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-11-06 11:15:42",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [],
             "ReadAt": null
         },
         {
             "NoticeID": 143,
             "NoticeTypeID": 3,
             "Title": "My event 2020102",
             "Description": "My event 20201027 001",
             "PublishDate": "2020-11-06 11:41:26",
             "VisibleTill": "2020-11-11 00:00:00",
             "EventTypeID": 2,
             "EventStartDate": "2020-11-07 10:00:00",
             "EventEndDate": "2020-11-11 00:00:00",
             "CreationDate": "2020-11-06 11:41:26",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [],
             "ReadAt": null
         }
     ],
     "status": 1,
     "message": "Get society events done"
 }
 
 */
