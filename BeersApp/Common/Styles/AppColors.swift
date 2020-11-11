//
//  AppColors.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit


struct AppColors {
    let clear = UIColor.clear
    let white = UIColor.white

    let alto = UIColor(int: 0xd3d3d3)
    let sandDune = UIColor(int: 0x7e6f66)
    let mineShaft = UIColor(int: 0x383838)
    let bostonBlue = UIColor(int: 0x307ebb)
    let gold = UIColor(int: 0xffd700)
    let salem = UIColor(int: 0x0ea455)
    
    let beerColors = BeerColors()
    
    init() {
    }
}

struct BeerColors {
    let paleStraw = UIColor(int: 0xffe26f)
    let straw = UIColor(int: 0xfebb1d)
    let paleGold = UIColor(int: 0xed9c19)
    let deepGold = UIColor(int: 0xd67d1e)
    let paleAmber = UIColor(int: 0xc66122)
    let mediumAmber = UIColor(int: 0xa94524)
    let deepAmber = UIColor(int: 0x8c2f1a)
    let amberBrown = UIColor(int: 0x6b1b10)
    let brown = UIColor(int: 0x550808)
    let rubyBrown = UIColor(int: 0x410002)
    let deepBrown = UIColor(int: 0x2f0001)
    let black = UIColor(int: 0x220001)
}

let appColors = AppColors()
