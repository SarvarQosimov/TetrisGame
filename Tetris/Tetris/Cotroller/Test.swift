//
//  MainVC2.swift
//  Tetris
//
//  Created by Sarvar Qosimov on 08/04/23.
//

import UIKit

class Test: UIViewController {

//MARK: Variables

    var isSpeed = false
    var timer = Timer()
    var rows = Board.numberOfRows
    var columns = Board.numberOfColumns
    var lastBricks = [Int]()
    var isPaused = false
    var prepareNextTypeBrick = 1
    var scoreCount = 0

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib(nibName: "CVC", bundle: nil), forCellWithReuseIdentifier: "CVC")
        }
    }

    @IBOutlet weak var startBtn: UIButton!

    @IBOutlet weak var pauseBtn: UIButton! {
        didSet {

            let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(gameOver(_:)))

            pauseBtn.addGestureRecognizer(gestureRecognizer)
        }
    }

    @IBOutlet weak var scoreLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        pauseBtn.isHidden = true
        Brick.createCordinates()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        for _ in 0...columns*rows {
            Board.blocks.append(.systemGray4)
        }
    }

//MARK: - startPressed -

    @IBAction func startPressed(_ sender: Any) {

        timer = Timer.scheduledTimer(withTimeInterval: 0.63, repeats: true, block: { [self] timer in

            if isPaused {
                timer.invalidate()
            }

                /* speedly down */

            if isSpeed {
                while Board.isValidDown() {
                    Brick.moveDown()
                }
            }

            if Board.isValidDown() {
                    Brick.moveDown()
        } else {

            /* add to score */

            switch Brick.typeOfBrick {
            case .I: scoreCount += 7
            case .L: scoreCount += 5
            case .T: scoreCount += 5
            case .o: scoreCount += 1
            }

            scoreLbl.text = "Youre Score: \(scoreCount)"

            /* add to indexs according to type and positon */

            switch Brick.typeOfBrick {
                case .I:
                    Board.addIIndexBrick()
                case .T:
                    Board.addTIndexBrick()
                case .L:
                    Board.addLIndexBrick()
                default:
                    Board.addOIndexBrick()
        }

                /* make default brick */
            Brick.currentLocation = 20
            Brick.positionOfBrick = .down
            isSpeed = false

                /* change type */

            switch prepareNextTypeBrick {
            case 1:
                Brick.typeOfBrick = .o
                prepareNextTypeBrick += 1
            case 2:
                Brick.typeOfBrick = .T
                prepareNextTypeBrick += 1
            case 3:
                Brick.typeOfBrick = .o
                prepareNextTypeBrick += 1
            case 4:
                Brick.typeOfBrick = .I
                prepareNextTypeBrick += 1
            case 5:
                Brick.typeOfBrick = .o
                prepareNextTypeBrick += 1
            default:
                Brick.typeOfBrick = .L
                prepareNextTypeBrick = 1
            }

        }

           /*  last Row is full?     */

            if checkForLastRow() {
                setupNewBrick(isFull: true)
            } else {
                setupNewBrick(isFull: false)
            }

        /*  move bricks according to type and position */

            switch Brick.typeOfBrick {
            case .I:
                Brick.moveIBrick()
            case .T:
                Brick.moveTBrick()
            case .L:
                Brick.moveLBrick()
            default:
                Brick.moveOBrick()
            }

                    collectionView.reloadData()
        })

        startBtn.isHidden = true
        pauseBtn.isHidden = false
    }

    //MARK: - left and right pressed -

    @IBAction func pausePressed(_ sender: Any) {
        pauseGame()
    }

    @IBAction func leftPressed(_ sender: Any) {
        if Board.isValidLeft() {
            Brick.currentLocation -= 1
        }
    }

    @IBAction func rightPressed(_ sender: Any) {
        if Board.isValidRight() {
            Brick.currentLocation += 1
        }
    }

    @IBAction func rotatePressed(_ sender: Any) {
        switch Brick.positionOfBrick {
        case .down:
            Brick.positionOfBrick = .right
        case .right:
            Brick.positionOfBrick = .up
        case .up:
            Brick.positionOfBrick = .left
        default:
            Brick.positionOfBrick = .down
        }
    }


    @IBAction func speedlyDown(_ sender: Any) {
        isSpeed = true
    }

//MARK: @objc functions

    @objc func gameOver(_ press: UILongPressGestureRecognizer){

        if press.state == .began {

            Board.indexsOfAddedBricks = [Int]()
            Brick.currentLocation = 20
            Brick.typeOfBrick = .L
            prepareNextTypeBrick = 1
            Brick.positionOfBrick = .down
            rows = 15
            Board.blocks = [UIColor]()

            for _ in 0...columns*rows {
                Board.blocks.append(.systemGray4)
            }

            scoreCount = 0
            scoreLbl.text = "Your Score: \(scoreCount)"
            scoreLbl.textColor = .black
            isPaused = true
            pauseBtn.setImage(UIImage(systemName: "play"), for: .normal)
            setupNewBrick(isFull: false)
            collectionView.reloadData()
       }
    }


//MARK: pauseGame

    func pauseGame(){
        if isPaused {
            isPaused = false
            pauseBtn.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            timer.fire()
        } else {
            isPaused = true
            pauseBtn.setImage(UIImage(systemName: "play"), for: .normal)
        }
    }

//MARK: setupNewBrick

    func setupNewBrick(isFull: Bool) {

        for i in 0...Board.blocks.count-2 {
            if !Board.indexsOfAddedBricks.contains(i) {
                Board.blocks[i] = .systemGray4
            } else {
                Board.blocks[i] = .brown
            }
        }

    }

//MARK: checkForLastRow

    func checkForLastRow() -> Bool{
         lastBricks = [Int]()
        var cnt = 0
        var numLastBricks = 0
        for _ in 1...columns {
            lastBricks.append(columns*rows-cnt-1)
            cnt += 1
        }
        for i in lastBricks {
            if Board.indexsOfAddedBricks.contains(i) {
                numLastBricks += 1
            }
        }

        for i in 1...12 {
            if Board.indexsOfAddedBricks.contains(i) {
                scoreLbl.textColor = .red
                scoreLbl.text = "Game Over"
                isPaused = true
            }
        }

        if numLastBricks == columns {
            rows -= 1
            Board.blocks.removeLast(columns)
            return true
        } else {
            return false
        }

    }

}

//MARK: UICollectionViewDataSource

extension Test: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            columns*rows
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC", for: indexPath) as? CVC else {return UICollectionViewCell()}

        cell.updataCell(color: Board.blocks[indexPath.item])

        return cell
    }
}

extension Test: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Brick.currentLocation = indexPath.row
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension Test: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = self.collectionView.frame.width
        let height = self.collectionView.frame.height

        return CGSize(width: width/13, height: width/13)

    }

}


