//
//  Model.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 17.08.2025.
//

import Foundation

/*
 🧠 Как думать при создании модели:
 1. Первый вопрос: Что показывает CollectionView?
 "Показывает секции: Мои альбомы, Общие альбомы, Медиа-типы..."
 
 ⇒ Значит нужен массив секций [AlbumSection]
 
 2. Второй вопрос: Что внутри каждой секции?
 "В секции есть заголовок и массив ячеек"
 
 ⇒ Значит структура:
 
 swift
 struct AlbumSection {
 let header: SectionHeader
 let items: [???] // Что здесь?
 }
 3. Третий вопрос: Какие типы ячеек в секциях?
 "В 'Мои альбомы' - ячейки с картинкой и текстом"
 
 "В 'Общие альбомы' - ячейки с кружочками и обычные"
 
 ⇒ Значит нужен enum для объединения типов:
 
 swift
 enum AlbumItem {
 case myAlbum(MyAlbum)
 case firstSharedAlbum(FirstSharedAlbum)
 case sharedAlbum(SharedAlbum)
 }
 4. Четвертый вопрос: Что внутри каждой ячейки?
 "Ячейка 'Мой альбом' имеет: картинку, название, количество"
 
 ⇒ Значит структура:
 
 swift
 struct MyAlbum {
 let imageName: String
 let title: String
 let count: Int
 }
 */

// АЛГОРИТМ СОЗДАНИЯ (шаг за шагом):
// ШАГ 1: Определить структуры данных для ячеек
// Данные для каждой типа ячеек
struct MyAlbum: Hashable {
    let imageName: String
    let title: String
    let count: Int
}

struct FirstSharedAlbum: Hashable {
    let imageNames: [String]
    let title: String
    let subtitle: String
}

struct SharedAlbum: Hashable {
    let imageName: String
    let title: String
    let subtitle: String
}

struct MediaAndOther: Hashable {
    let imageName: String
    let title: String
    let count: Int
    let chevronName: String
}

//ШАГ 2: Создать enum для объединения типов
// enum для объединения типов
enum AlbumItem: Hashable {
    case myAlbum(MyAlbum)
    case firstSharedAlbum(FirstSharedAlbum)
    case sharedAlbum(SharedAlbum)
    case mediaType(MediaAndOther)
    case other(MediaAndOther)
    
    var id: String {
        switch self {
        case .myAlbum(let album): return "myAlbum_\(album.title)"
        case .firstSharedAlbum(let album): return "firstShared_\(album.title)"
        case .sharedAlbum(let album): return "sharedAlbum_\(album.title)"
        case .mediaType(let media): return "mediaType_\(media.title)"
        case .other(let other): return "utility_\(other.title)"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: AlbumItem, rhs: AlbumItem) -> Bool {
        lhs.id == rhs.id
    }
}

// ШАГ 3: Создать модель секции
// Модель секции
struct AlbumSection: Hashable {
    let header: SectionHeader  // Заголовок секции
    let type: SectionType      // Тип секции (для layout)
    let items: [AlbumItem]     // ✅ Массив ВСЕХ ячеек этой секции
}

// После создания основных моделей, до лейаута
// Зачем нужен SectionType: Для лейаута
// AlbumCompositionalLayout  let sectionType = AlbumSection.allSections[sectionIndex].type // ✅ Берем тип
// MARK: - Sections

enum SectionType: String, CaseIterable {
    case myAlbums = "My Albums"
    case sharedAlbums = "Shared Albums"
    case mediaTypes = "Media Types"
    case other = "Other"
}

//ШАГ 4: Создать заголовок секции
//MARK: - Header

struct SectionHeader: Hashable {
    let title: String
    let buttonTitle: String?
    let buttonAction: (() -> Void)?
    
    init(
        title: String,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func == (lhs: SectionHeader, rhs: SectionHeader) -> Bool {
        lhs.title == rhs.title
    }
}

//ШАГ 5: Собрать все данные
//MARK: - datas

extension AlbumSection {
    static var allSections: [AlbumSection] = [
        // My Albums
        AlbumSection(
            header: SectionHeader(
                title: "My Albums",
                buttonTitle: "See All",
                buttonAction: {
                    print("See All tapped for My Albums")
                }
            ),
            type: .myAlbums,
            items: MyAlbum.myAlbums.map {AlbumItem.myAlbum($0)}
        ),
        
        // Shared Albums
        AlbumSection(
            header: SectionHeader(
                title: "Shared Albums",
                buttonTitle: "See All",
                buttonAction: {
                    print("See All tapped for Shared Albums")
                }
            ),
            type: .sharedAlbums,
            items: [
                // [перваяЯчейка] + [остальныеЯчейки]
                // ✅ ПЕРВАЯ ячейка с кружочками
                AlbumItem.firstSharedAlbum(FirstSharedAlbum.firstSharedAlbum),
                // ✅ Остальные обычные ячейки
            ] + SharedAlbum.sharedAlbums.map { AlbumItem.sharedAlbum($0) }
        ),
        
        // Media Types
        AlbumSection(
            header: SectionHeader(title: "Media Types"),
            type: .mediaTypes,
            items: MediaAndOther.mediaTypes.map {
                AlbumItem.mediaType($0
                )}
        ),
        
        // Other
        AlbumSection(
            header: SectionHeader(title: "Other"),
            type: .other,
            items: MediaAndOther.otherType.map {
                AlbumItem.other($0
                )}
        )
    ]
}

extension MyAlbum {
    static var myAlbums: [MyAlbum] = [
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
    static var sharedAlbums: [SharedAlbum] = [
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
    static let mediaTypes: [MediaAndOther] = [
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
