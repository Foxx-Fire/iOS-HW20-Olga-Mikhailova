//
//  Model.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 17.08.2025.
//
import Foundation

struct SectionHeaderModel {
    let title: String
    let buttonTitle: String?
    let buttonAction: (() -> Void)?
    let sectionType: SectionType
    
    // без кнопки
    init(title: String, sectionType: SectionType) {
        self.title = title
        self.buttonTitle = nil
        self.buttonAction = nil
        self.sectionType = sectionType
    }
    
    // с кнопкой
    init(title: String, buttonTitle: String, buttonAction: @escaping () -> Void, sectionType: SectionType) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        self.sectionType = sectionType
    }
}

enum SectionType {
    case myAlbums
    case sharedAlbums
    case mediaTypes
    case otherAlbums
}

struct MyAlbum {
    let imageName: String
    let title: String
    let count: Int
}

struct FirstSharedAlbum {
    let imageNames: [String]
    let title: String
    let subtitle: String
}

struct SharedAlbum {
    let imageName: String
    let title: String
    let subtitle: String
}

struct MediaAndOther {
    let imageName: String
    let title: String
    let count: Int
    let chevronName: String
}

extension SectionHeaderModel {
    static var allSections: [SectionHeaderModel] = [
        SectionHeaderModel(
            title: "My Albums",
            buttonTitle: "See All",
            buttonAction: { print("See All tapped for My Albums") },
            sectionType: .myAlbums
        ),
        SectionHeaderModel(
            title: "Shared Albums",
            buttonTitle: "See All",
            buttonAction: { print("See All tapped for Shared Albums") },
            sectionType: .sharedAlbums
        ),
        SectionHeaderModel(title: "Media Types", sectionType: .mediaTypes),
        SectionHeaderModel(title: "Other Albums", sectionType: .otherAlbums)
    ]
}

extension MyAlbum {
    static var myAlbum: [MyAlbum] = [
        MyAlbum(
            imageName: "beachSunset",
            title: "Summer Vacation",
            count: 248
        ),
        MyAlbum(
            imageName: "mountainPeak",
            title: "Hiking Adventures",
            count: 173
        ),
        MyAlbum(
            imageName: "birthdayCake",
            title: "Birthday Party",
            count: 56
        ),
        MyAlbum(
            imageName: "concertLights",
            title: "Music Festivals",
            count: 312
        ),
        MyAlbum(
            imageName: "winterSnow",
            title: "Ski Trip",
            count: 89
        ),
        MyAlbum(
            imageName: "cityLights",
            title: "Night Life",
            count: 421
        ),
        MyAlbum(
            imageName: "petDog",
            title: "Best Friend",
            count: 1024
        ),
        MyAlbum(
            imageName: "foodPlating",
            title: "Gourmet Recipes",
            count: 77
        ),
        MyAlbum(
            imageName: "artMuseum",
            title: "Culture & Art",
            count: 155
        ),
        MyAlbum(
            imageName: "sunriseField",
            title: "Early Mornings",
            count: 43
        ),
        MyAlbum(
            imageName: "vintageCar",
            title: "Classic Cars",
            count: 29
        ),
        MyAlbum(
            imageName: "bookStack",
            title: "Reading Nook",
            count: 18
        )
    ]
}

extension FirstSharedAlbum {
    static var firstSharedAlbum: FirstSharedAlbum = {
        FirstSharedAlbum(
            imageNames: ["familyPhoto1", "familyPhoto2", "familyPhoto3", "familyPhoto4"],
            title: "Family Photos",
            subtitle: "From You"
        )
    }()
}

extension SharedAlbum {
    static var sharedAlbum: [SharedAlbum] = [
        SharedAlbum(imageName: "familyBeach", title: "Family Reunion 2024", subtitle: "From Mom"),
        SharedAlbum(imageName: "roadTrip", title: "West Coast Road Trip", subtitle: "From Alex"),
        SharedAlbum(imageName: "weddingDay", title: "Sarah & Mike Wedding", subtitle: "From Sarah"),
        SharedAlbum(imageName: "gameNight", title: "Game Nights", subtitle: "From You"),
        SharedAlbum(imageName: "babyFirstSteps", title: "Baby's First Year", subtitle: "From Emma"),
        SharedAlbum(imageName: "concertCrowd", title: "Rock Concert", subtitle: "From David"),
        SharedAlbum(imageName: "weekendBBQ", title: "Summer BBQ", subtitle: "From You"),
        SharedAlbum(imageName: "hikingViews", title: "Mountain Hiking", subtitle: "From James"),
        SharedAlbum(imageName: "newYearParty", title: "New Year's Eve", subtitle: "From Maria"),
        SharedAlbum(imageName: "petTricks", title: "Pet Adventures", subtitle: "From You")
    ]
}

extension MediaAndOther {
    static let mediaType: [MediaAndOther] = [
        MediaAndOther(
            imageName: "video",
            title: "Videos",
            count: 205,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "person.crop.square",
            title: "Selfies",
            count: 692,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "livephoto",
            title: "Live Photos",
            count: 728,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "cube",
            title: "Portrait",
            count: 343,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "livephoto",
            title: "Long Exposure",
            count: 4,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "pano",
            title: "Panoramas",
            count: 2,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "slowmo",
            title: "Slo-mo",
            count: 7,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "square.stack.3d.down.right",
            title: "Bursts",
            count: 41,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "camera.viewfinder",
            title: "Screenshots",
            count: 252,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "square.stack.3d.forward.dottedline",
            title: "Animated",
            count: 2,
            chevronName: "chevron.right"
        )
    ]
    
    static let otherType: [MediaAndOther] = [
        MediaAndOther(
            imageName: "square.and.arrow.down",
            title: "Imports",
            count: 2762,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "eye.slash",
            title: "Hidden",
            count: 0,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "heart",
            title: "Favorites",
            count: 124,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "trash",
            title: "Recently Deleted",
            count: 32,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "folder",
            title: "Downloads",
            count: 567,
            chevronName: "chevron.right"
        ),
        MediaAndOther(
            imageName: "cloud",
            title: "iCloud Photos",
            count: 8921,
            chevronName: "chevron.right"
        )
    ]
}
