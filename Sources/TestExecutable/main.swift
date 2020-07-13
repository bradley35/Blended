//
//  File.swift
//  
//
//  Created by Bradley on 7/12/20.
//

import Foundation
import simd
import TrackingToBlender

let videoURL = URL(fileURLWithPath: "/Users/bradley/Downloads/export/video1.mp4")
let jsonURL = URL(fileURLWithPath: "/Users/bradley/Downloads/export/video1track.json")
let currentFileURL = URL(fileURLWithPath: "\(#file)", isDirectory: false).deletingLastPathComponent()

let framerate = 60

let t2b = try! TrackingToBlender(frameRate: framerate, jsonURL: jsonURL)
t2b.processFrames()

let outputString = t2b.generateString()

try! outputString.write(to: currentFileURL.appendingPathComponent("output.py"), atomically: false, encoding: .ascii)

