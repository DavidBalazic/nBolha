//
//  FontLoadStartupProcess.swift
//  ComplexChinaApp
//
//  Created by Luka Pernousek on 8. 11. 23.
//

import UIKit
import nBolhaCore

public final class FontLoadStartupProcess: StartupProcess {
    public func run() {
        UIFont.registerFonts()
    }
}
