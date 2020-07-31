//
//  GameViewController.swift
//  gameOfLife
//
//  Created by Keri Levesque on 7/29/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    
    //MARK: Outlets
    
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var startButton: UIButton!
//    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var randomButton: UIButton!
    
    
    //MARK: Properties
    
    var objects = [Any]()
    var timer = Timer()
    var running = false
//    let tempoOptions: [(String, TimeInterval)] = [("1x", 1),
//                                                  ("2x", 0.5),
//                                                  ("4x", 0.25)]
//    var currentTempoIndex = 0
//
//    var isPlaying: Bool {
//        return timer != nil
//    }
    let columns: Int = Game.shared.columns
    let rows: Int = Game.shared.rows
    var game: Game?
    
    //MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        gameCollectionView.dataSource = self
        gameCollectionView.delegate = self
        
        gameCollectionView.layer.borderColor = self.cellBorderColor()
        gameCollectionView.isHidden = true

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshCells))

    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          if animated == false {
              self.gameCollectionView.reloadData()
          }
      }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let rect:CGRect = self.gameCollectionView.frame
        
        let width = rect.size.width / CGFloat(columns)
        let height = rect.size.width / CGFloat(columns)
        
        layout.itemSize = CGSize(width:width,  height: height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        gameCollectionView.setCollectionViewLayout(layout, animated: false)
        gameCollectionView.reloadData()
        gameCollectionView.isHidden = false
    }
    //MARK: UICollectionViewDataSource protocol functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columns * rows
    }
    
    //setting up the cell in the collectionView for the game's cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gameCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.borderColor = self.cellBorderColor()
        cell.layer.borderWidth = 0.5
        if Game.shared.getStatus(index: indexPath.item) {
            cell.backgroundColor = CellColor.shared.cellColor
        }
        else {
            cell.backgroundColor = .systemBackground
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let status = !Game.shared.getStatus(index: indexPath.item)
         Game.shared.setStatus(index: indexPath.item, status: status )
         self.gameCollectionView.reloadData()
     }
     

    //MARK: Actions
    @IBAction func start(_ sender: Any) {
        toggleState()
    }
    @IBAction func trashPressed(_ sender: Any) {
        clearCells()
//        self.gameCollectionView.reloadData()
    }
    
    
//    @IBAction func tempoButtonTapped(_ sender: UIButton) {
//         currentTempoIndex += 1
//         if currentTempoIndex >= tempoOptions.count {
//             currentTempoIndex = 0
//         }
//         if isPlaying { restartTimer() }
//         tempoButton.setTitle(tempoOptions[currentTempoIndex].0, for: UIControl.State())
//     }
//     

//    @IBAction func speedSlider(_ sender: Any) {
//        game!.timeInterval = TimeInterval(1.0) - TimeInterval(sender.value)
//    }

  //was random preset changed into to slow botton
    @IBAction func randomButtonTapped(_ sender: Any) {
        random()
    }
    func random() {
        if !running {
            timer = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true, block: {(timer) in
                if Game.shared.checkLife() == 0 {
                    if self.running {
                        timer.invalidate()
                        self.toggleState()
                    }
                }
                self.gameCollectionView.reloadData()
            })
            running = true
            self.randomButton.setTitle("Stop", for: .normal)
        }
        else {
            running = false
            timer.invalidate()
            self.randomButton.setTitle("Slow", for: .normal)
        }

    }

    
    //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showPresetSegue") {
                   ((segue.destination as! UINavigationController).topViewController as! PresetTableViewController).gameViewController = self
               }
    }

    
    //MARK: Helper Functions
    func toggleState() {
           if !running {
               timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (timer) in
                   if Game.shared.checkLife() == 0 {
                       if self.running {
                           timer.invalidate()
                           self.toggleState()
                       }
                   }
                   self.gameCollectionView.reloadData()
               })
               running = true
           }
           else {
               running = false
               timer.invalidate()
           }
       }
    @objc
    func clearCells() {
        Game.shared.clear()
        self.gameCollectionView.reloadData()
        if running {
            toggleState();
        }
    }
    @objc
      func refreshCells () {
          if running {
              toggleState();
          }
        performSegue(withIdentifier: "showPresetSegue", sender: nil)
      }
    
    internal func cellBorderColor() -> CGColor {
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.lightGray.cgColor
        }
        else {
            return UIColor.darkGray.cgColor
        }
    }
    
    
     internal func setButtonColor() {
         if traitCollection.userInterfaceStyle == .dark {
             self.startButton.layer.borderColor = UIColor.white.cgColor
         }
         else {
             self.startButton.layer.borderColor = UIColor.black.cgColor
         }
        
    }
}
