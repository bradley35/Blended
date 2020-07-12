//
//  File.swift
//  
//
//  Created by Bradley on 7/12/20.
//

import Foundation
import simd
let videoURL = URL(fileURLWithPath: "/Users/bradley/Downloads/export 6/video1.mp4")
let jsonURL = URL(fileURLWithPath: "/Users/bradley/Downloads/export 6/video1track.json")
let framerate = 60
let tracking = try! TrackingData.loadFromFile(url: jsonURL)
var frameByFrameTransforms = [simd_float4x4]()
var currentFrame = 0
for point in tracking.points{
    let frame = Int(((Float(point.timeStamp)/Float(point.timeScale))/(1/Float(framerate))).rounded(.toNearestOrAwayFromZero))
    if(frame < currentFrame){
        print("Less")
        continue
    }else if frame == currentFrame{
        currentFrame+=1
        frameByFrameTransforms.append(point.position)
    }else{
        for g in 0..<(frame-currentFrame){
            print("Above")
            currentFrame+=1
            frameByFrameTransforms.append(frameByFrameTransforms.last ?? simd_float4x4(1))
        }
    }
}
var pythonString = "["
for frame in frameByFrameTransforms{
    
}
