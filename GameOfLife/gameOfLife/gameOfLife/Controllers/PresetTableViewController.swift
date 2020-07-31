//
//  PresetTableViewController.swift
//  gameOfLife
//
//  Created by Keri Levesque on 7/30/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit

class PresetTableViewController: UITableViewController {

    //MARK: Properties
    
    var gameViewController: GameViewController?
    let RowHeight:CGFloat = 84
    let presetsRowHeight:CGFloat = 42
    var selectedIndex: Int = -1
    
    let presets = [ PresetOne(), PresetTwo(), PresetThree()]

    
    //MARK: View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.title = NSLocalizedString("Preset", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: Selector(("dismiss")))
        self.tableView.allowsMultipleSelection = false

     
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1 {
            return presets.count
        }
        else {
            return 1
        }
    }

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if indexPath.section == 1 {
             let cell = tableView.cellForRow(at:indexPath)
             cell?.accessoryType = .checkmark
             self.selectedIndex = indexPath.row
         }
         else {
             
         }
     }

     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section  == 0 {
             return NSLocalizedString("Pick a color", comment: "")
        } else {
            return NSLocalizedString("Choose a preset", comment: "")
        }
     }
     
     override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
         if indexPath.section == 1 {
             let cell = tableView.cellForRow(at:indexPath)
             cell?.accessoryType = .none
         }
         else {
             
         }
     }
     
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.section == 0 {
             return RowHeight;
         }
         else {
            return presetsRowHeight;
        }
     }
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             if indexPath.section == 1 {
                 let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                 cell.selectionStyle = .none
                 let oscillator = self.presets[indexPath.row]
                 cell.textLabel?.text = oscillator.name
                 return cell
             } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath)
                cell.selectionStyle = .none
                let oscillator = self.presets[indexPath.row]
                cell.textLabel?.text = oscillator.name
                return cell
        }
//             else {
//                 let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath)
//                 return cell
//         }
     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: Helper
    @objc
       internal func dismiss() {
           if self.selectedIndex >= 0  && self.gameViewController != nil {
               Game.shared.clear()
               Game.shared.setOscillator(oscillator: presets[self.selectedIndex])
           }
           self.gameViewController?.viewWillAppear(false)
           self.dismiss(animated: true)
       }

}
