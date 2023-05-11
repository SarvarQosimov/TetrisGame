//
//  BrickModel.swift
//  Tetris
//
//  Created by Sarvar Qosimov on 14/04/23.
//

import Foundation
import UIKit

class Brick {

//MARK: - Variables -

    static var currentLocation: Int = 20
    static var typeOfBrick: type = .L
    static var positionOfBrick: Brick.position = .down

    static var downAndUpI: [(Int,[Brick.position])] = []
    static var rightAndLeftI: [(Int,[Brick.position])] = []
    static var downT: [(Int,[Brick.position])] = []
    static var rightT: [(Int,[Brick.position])] = []
    static var leftT: [(Int,[Brick.position])] = []
    static var upT: [(Int,[Brick.position])] = []
    static var o: [(Int,[Brick.position])] = []
    static var downL: [(Int,[Brick.position])] = []
    static var rightL: [(Int,[Brick.position])] = []
    static var leftL: [(Int,[Brick.position])] = []
    static var upL: [(Int,[Brick.position])] = []

    static let columns = Board.numberOfColumns
    static let rows = Board.numberOfRows

//MARK: - createCordinates -

   static func createCordinates(){

       let currentLocation = Brick.currentLocation

       o = [
        (currentLocation,[.left,.right,.down])
       ]

       downAndUpI = [
            (currentLocation-1-columns,[.left,.down]),
            (currentLocation-columns,[.up]),
            (currentLocation+1-columns,[.right,.down]),
            (currentLocation,[.left,.right]),
            (currentLocation-1+columns,[.left,.down]),
            (currentLocation+columns,[.down]),
            (currentLocation+1+columns,[.right,.down])
       ]

       rightAndLeftI = [
            (currentLocation-1-columns,[.left]),
            (currentLocation-1,[.left]),
            (currentLocation-1+columns,[.left,.right,.down]),
            (currentLocation,[.down]),
            (currentLocation+1-columns,[.right]),
            (currentLocation+1,[.right]),
            (currentLocation+1+columns,[.left,.right,.down])
       ]

       downT = [
            (currentLocation-1-columns,[.left,.down]),
            (currentLocation-columns,[.up]),
            (currentLocation+1-columns,[.right,.down]),
            (currentLocation,[.left,.right]),
            (currentLocation+columns,[.left,.right,.down]),
       ]

       rightT = [
            (currentLocation+1-columns,[.left,.right]),
            (currentLocation-1,[.left,.down]),
            (currentLocation,[.down]),
            (currentLocation+1,[.right]),
            (currentLocation+1+columns,[.left,.right,.down]),
       ]

       leftT = [
            (currentLocation-1-columns,[.right,.left]),
            (currentLocation-1,[.left]),
            (currentLocation,[.down]),
            (currentLocation+1,[.right,.down]),
            (currentLocation-1+columns,[.left,.right,.down])
       ]

       upT = [
            (currentLocation-columns,[.left,.right]),
            (currentLocation,[.left,.right]),
            (currentLocation+columns,[.down]),
            (currentLocation-1+columns,[.left,.down]),
            (currentLocation+1+columns,[.right,.down])
       ]

       downL = [
            (currentLocation-1-columns,[.left,.right]),
            (currentLocation-1,[.left,.right]),
            (currentLocation-1+columns,[.left,.down]),
            (currentLocation+columns,[.down]),
            (currentLocation+1+columns,[.down,.right]),
       ]

       leftL = [
            (currentLocation+1-columns,[.left,.right]),
            (currentLocation+1,[.left,.right]),
            (currentLocation+1+columns,[.right,.down]),
            (currentLocation+columns,[.down]),
            (currentLocation-1+columns,[.left,.down]),
       ]

       rightL = [
            (currentLocation-1-columns,[.left]),
            (currentLocation-columns,[.down]),
            (currentLocation+1-columns,[.down,.right]),
            (currentLocation-1,[.left,.right]),
            (currentLocation-1+columns,[.left,.down,.right]),
       ]

       upL = [
            (currentLocation-1-columns,[.left,.down]),
            (currentLocation-columns,[.down]),
            (currentLocation+1-columns,[.right]),
            (currentLocation+1,[.left,.right]),
            (currentLocation+1+columns,[.left,.down,.right]),
       ]

    }

//MARK: - moveDown -

   static func moveDown(){
         Brick.currentLocation += columns
    }

//MARK: - moveOBrick -

    static func moveOBrick(){
        Brick.createCordinates()
        changeColor(cordinates: o)
    }

//MARK: - moveIBrick -

    static func moveIBrick(){
        Brick.createCordinates()
        switch Brick.positionOfBrick {
        case .down:
            changeColor(cordinates: downAndUpI)
        case .right:
            changeColor(cordinates: rightAndLeftI)
        case .left:
            changeColor(cordinates: rightAndLeftI)
        default:
            changeColor(cordinates: downAndUpI)
        }
    }

//MARK: - moveTBrick -

    static func moveTBrick(){
            Brick.createCordinates()
        switch Brick.positionOfBrick {
        case .down:
            changeColor(cordinates: downT)
        case .right:
            changeColor(cordinates: rightT)
        case .left:
            changeColor(cordinates: leftT)
        default:
            changeColor(cordinates: upT)
        }
    }

//MARK: - moveLBrick -

    static func moveLBrick() {
            Brick.createCordinates()
        switch Brick.positionOfBrick {
        case .down:
            changeColor(cordinates: downL)
        case .right:
            changeColor(cordinates: rightL)
        case .left:
            changeColor(cordinates: leftL)
        default:
            changeColor(cordinates: upL)
        }
    }

//MARK: - changeColor -

   static func changeColor(cordinates:[(Int,[Brick.position])]){
        for i in cordinates {
            Board.blocks[i.0] = .brown
        }
    }

//MARK: - enums -

    enum type: Int {
        case T
        case I
        case L
        case o
    }

    enum position {
        case down
        case right
        case left
        case up
    }

    enum checkMovemen {
        case down, left, right
    }

}

