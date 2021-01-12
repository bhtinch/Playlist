//
//  SongListTableViewController.swift
//  Playlist
//
//  Created by Benjamin Tincher on 1/11/21.
//

import UIKit

class SongListTableViewController: UITableViewController {

    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songArtistNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SongController.shared.loadFromPersistenceStore()
    }
    
    //  MARK: - Actions
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let songTitle = songTitleTextField.text else { return }
        guard !songTitle.isEmpty else { return }
        guard let songArtist = songArtistNameTextField.text else { return }
        guard !songArtist.isEmpty else { return }
        //  Can put all the above 4 guard statements into 1 guard statement like below:
        //  guard let songTitle = songTitleTextField.text, !songArtist.isEmpty, let songArtist = songArtistNameTextField.text, !songArtist.isEmpty else { return }
        
        SongController.shared.createSong(songTitle: songTitle , songArtist: songArtist)
        tableView.reloadData()
        songTitleTextField.text = ""
        songArtistNameTextField.text = ""
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //  MARK: - table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SongController.shared.songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let songTitle = SongController.shared.songs[indexPath.row].songTitle
        let songArtist = SongController.shared.songs[indexPath.row].songArtist
        
        cell.textLabel?.text = songTitle
        cell.detailTextLabel?.text = songArtist
        
        return cell
    }

        // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let song = SongController.shared.songs[indexPath.row]
            SongController.shared.deleteSong(song: song)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //  tableView.deleteRows automatically reloads tableView data so no need to do tableView.reoloadData()
        }
    }
}
