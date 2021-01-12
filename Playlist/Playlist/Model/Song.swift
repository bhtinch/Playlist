//
//  Song.swift
//  Playlist
//
//  Created by Benjamin Tincher on 1/11/21.
//

import Foundation

//  Note that type Codable will allow Encodable and Decodable at the same time
class Song: Encodable, Decodable {
    let songTitle: String
    let songArtist: String
    
    init(songTitle: String, songArtist: String) {
        self.songTitle = songTitle
        self.songArtist = songArtist
    }
}

extension Song: Equatable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.songTitle == rhs.songTitle && lhs.songArtist == rhs.songArtist
        
        /* above accomplishes the same as the lines below:
        if lhs.songTitle != rhs.songTitle { return false }
        if lhs.songArtist != rhs.songArtist { return false }
        return true */
    }
}
