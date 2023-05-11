//
//  BoardModel.swift
//  Tetris
//
//  Created by Sarvar Qosimov on 19/04/23.
//

import Foundation
import UIKit

class Board {

//MARK: Variables

    static var blocks = [UIColor]()
    static var indexsOfAddedBricks = [Int]()

    static var numberOfRows = 15
    static var numberOfColumns = 12

    static var countDown = 0
    static var countRight = 0
    static var countLeft = 0

//MARK: - addIIndexBrick -

   static func addIIndexBrick(){
            Brick.createCordinates()
       switch Brick.positionOfBrick {
        case .down:
            for i in Brick.downAndUpI {
                indexsOfAddedBricks.append(i.0)
            }
        case .right:
            for i in Brick.rightAndLeftI {
                indexsOfAddedBricks.append(i.0)
            }
        case .left:
            for i in Brick.rightAndLeftI {
                indexsOfAddedBricks.append(i.0)
            }
        default:
            for i in Brick.downAndUpI {
                indexsOfAddedBricks.append(i.0)
            }
        }
    }

//MARK: - addOIndexBrick -

    static func addOIndexBrick(){
            Brick.createCordinates()
        for i in Brick.o {
            Board.indexsOfAddedBricks.append(i.0)
        }
    }

//MARK: - addIIndexBrick -

   static func addTIndexBrick(){
            Brick.createCordinates()
       switch Brick.positionOfBrick {
        case .down:
            for i in Brick.downT {
                Board.indexsOfAddedBricks.append(i.0)
            }
        case .right:
            for i in Brick.rightT {
                Board.indexsOfAddedBricks.append(i.0)
            }
        case .left:
            for i in Brick.leftT {
                Board.indexsOfAddedBricks.append(i.0)
            }
        default:
            for i in Brick.upT {
                Board.indexsOfAddedBricks.append(i.0)
            }
        }
    }

//MARK: - addLIndexBrick -

    static func addLIndexBrick(){
             Brick.createCordinates()
        switch Brick.positionOfBrick {
         case .down:
             for i in Brick.downL {
                 indexsOfAddedBricks.append(i.0)
             }
         case .right:
             for i in Brick.rightL {
                 indexsOfAddedBricks.append(i.0)
             }
         case .left:
             for i in Brick.leftL {
                 indexsOfAddedBricks.append(i.0)
             }
         default:
             for i in Brick.upL {
                 indexsOfAddedBricks.append(i.0)
             }
         }
     }

//MARK: isValidDown

    static func isValidDown() -> Bool {
            Brick.createCordinates()
        switch Brick.typeOfBrick {
        case .I:
        ///`                                 I
        switch Brick.positionOfBrick {
                case .down:
                    if checkDown(pose: Brick.downAndUpI) {
                        return true
                    }
                case .right:
                    if checkDown(pose: Brick.rightAndLeftI){
                        return true
                    }
                case .left:
                    if checkDown(pose: Brick.rightAndLeftI){
                        return true
                    }
                case .up:
                    if checkDown(pose: Brick.downAndUpI) {
                        return true
                    }
                default:
                        return false
                }
        case .T:
        ///`                                 T
        switch Brick.positionOfBrick {
                case .down:
                    if checkDown(pose: Brick.downT) {
                        return true
                    }
                case .right:
                    if  checkDown(pose: Brick.rightT){
                        return true
                    }
                case .left:
                    if checkDown(pose: Brick.leftT) {
                        return true
                    }
                case .up:
                    if  checkDown(pose: Brick.upT) {
                        return true
                    }
                default:
                    return false
            }
        case .L:
        ///`                                 L
        switch Brick.positionOfBrick {
        case .down:
            if checkDown(pose: Brick.downL) {
                return true
            }

        case .right:
            if checkDown(pose: Brick.rightL) {
                return true
            }
        case .left:
            if checkDown(pose: Brick.leftL) {
                return true
            }
        default:
            if checkDown(pose: Brick.upL) {
                return true
            }
            }
        default:
        ///`                                 O
            if checkDown(pose: Brick.o) {
            return true
        }
    }
    return false
}

//MARK: isValidRight

    static func isValidRight() -> Bool{
            Brick.createCordinates()
        switch Brick.typeOfBrick {
        case .I:
    ///`                        I
      switch Brick.positionOfBrick {
        case .down:
          if checkRight(pose: Brick.downAndUpI) {
              return true
          }
        case .right:
          if checkRight(pose: Brick.rightAndLeftI) {
                return true
            }
        case .left:
          if checkRight(pose: Brick.rightAndLeftI) {
                return true
            }
        case .up:
          if checkRight(pose: Brick.downAndUpI) {
                return true
            }
        default:
            return false
            }
        case .T:
    ///`                        T
      switch Brick.positionOfBrick {
        case .down:
          if checkRight(pose: Brick.downT) {
                return true
            }
        case .right:
          if checkRight(pose: Brick.rightT) {
                return true
            }
        case .left:
          if checkRight(pose: Brick.leftT) {
                return true
            }
        case .up:
          if checkRight(pose: Brick.upT) {
                return true
            }
        default:
            return false
            }
        case .L:
    ///`                        L
        switch Brick.positionOfBrick {
            case .down:
            if checkRight(pose: Brick.downL) {
                    return true
                }
            case .right:
            if checkRight(pose: Brick.rightL) {
                    return true
                }
            case .left:
            if checkRight(pose: Brick.leftL) {
                    return true
                }
            case .up:
            if checkRight(pose: Brick.upL) {
                    return true
                }
            default:
                return false
                }


        default:
    ///`                        O
            if checkRight(pose: Brick.o) {
            return true
            }
    }
            return false
    }

//MARK: isValidLeft

    static func isValidLeft() -> Bool{
            Brick.createCordinates()
        switch Brick.typeOfBrick {
        case .I:
            ///`                        I
            switch Brick.positionOfBrick {
            case .down:
                if checkLeft(pose: Brick.downAndUpI) {
                    return true
                }
            case .right:
                if checkLeft(pose: Brick.rightAndLeftI) {
                    return true
                }
            case .left:
                if checkLeft(pose: Brick.rightAndLeftI) {
                    return true
                }
            default:
                if checkLeft(pose: Brick.downAndUpI) {
                    return true
                }
            }
        case .T:
            ///`                        T
            switch Brick.positionOfBrick {
            case .down:
                if checkLeft(pose: Brick.downT) {
                    return true
                }
            case .right:
                if checkLeft(pose: Brick.rightT) {
                    return true
                }
            case .left:
                if checkLeft(pose: Brick.leftT) {
                    return true
                }
            default:
                if checkLeft(pose: Brick.upT) {
                    return true
                }
            }
        case .L:
            ///`                        L
            switch Brick.positionOfBrick {
            case .down:
                if checkLeft(pose: Brick.downL) {
                    return true
                }
            case .right:
                if checkLeft(pose: Brick.rightL) {
                    return true
                }
            case .left:
                if checkLeft(pose: Brick.leftL) {
                    return true
                }
            default:
                if checkLeft(pose: Brick.upL) {
                    return true
                }
            }

        default:
            ///`                        O
            if checkLeft(pose: Brick.o) {
                return true
            }
        }
            return false
    }

//MARK: - checkDown -

    static func checkDown(pose: [(Int,[Brick.position])]) -> Bool {

        for i in pose {
            if  i.1.contains(.down) &&
                !indexsOfAddedBricks.contains(i.0 + numberOfColumns) &&
                i.0 + numberOfColumns <= numberOfColumns*numberOfRows {
                    countDown += 1
            }
        }

        if countDown == 3 || countDown == 5 || countDown == 1 && Brick.typeOfBrick == .o {
            countDown = 0
            return true
        } else {
            countDown = 0
            return false
        }

    }

//MARK: - checkRight -

    static func checkRight(pose: [(Int,[Brick.position])]) -> Bool {

        for i in pose {

            if i.1.contains(.right) && !indexsOfAddedBricks.contains(i.0 + 1) &&
                (i.0+1) % numberOfColumns != 0
            {
                    countRight += 1
            }
        }

        if countRight == 3 || countRight == 4 || countRight == 1 && Brick.typeOfBrick == .o {
            countRight = 0
            return true
        } else {
            countRight = 0
            return false
        }

    }

//MARK: checkLeft

    static func checkLeft(pose: [(Int,[Brick.position])]) -> Bool {

        for i in pose {
            if i.1.contains(.left) && !indexsOfAddedBricks.contains(i.0 - 1) &&
                (i.0) % numberOfColumns != 0
            {
                    countLeft += 1
            }
        }

        if countLeft == 3 || countLeft == 4 || countLeft == 1 && Brick.typeOfBrick == .o {
            countLeft = 0
            return true
        } else {
            countLeft = 0
            return false
        }

    }
}
