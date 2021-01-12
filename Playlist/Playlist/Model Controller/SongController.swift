//
//  SongController.swift
//  Playlist
//
//  Created by Benjamin Tincher on 1/11/21.
//

import Foundation

class SongController {
    
    //  creating shared instance property
    static let shared = SongController()
    
    //  Source of Truth (S.o.T.)
    var songs: [Song] = []
    
    //  CRUD Methods
    //  Create
    func createSong(songTitle: String, songArtist: String) {
        //  create song
        let song = Song(songTitle: songTitle, songArtist: songArtist)
        //  add to songs array
        songs.append(song)
        
        //  save changes
        saveToPersistenceStore()
    }
    
    //  Read: Not using right now
    //  TODO:   Update
    
    //  Delete
    func deleteSong(song: Song) {
        
        //  Remove song from songs array
        guard let index = songs.firstIndex(of: song) else { return }
        songs.remove(at: index)
        //  Note optional statement because remove(at: ) requires a non-nil value
        //  Note firstIndex(of: ) must follow Equatable protocol
        
        //  save changes
        saveToPersistenceStore()
    }	
    
    //  MARK: - Persistence
    
    //  fileURL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Playlist.json")
        return fileURL
    }
    
    //  save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(songs)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    //  load
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            let loadedSongs = try JSONDecoder().decode([Song].self, from: data)
            songs = loadedSongs
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
