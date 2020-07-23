import Foundation
import simd
public class TrackingToBlender{
    
    var jsonURL:URL
    var frameRate:Int
    var tracking:TrackingData
    var frameByFrameTransforms = [simd_float4x4]()
    
    //let currentFileURL = URL(fileURLWithPath: "\(#file)", isDirectory: false).deletingLastPathComponent()
    //var templateURL:URL
    
    public init(frameRate:Int, jsonURL:URL) throws{
        self.frameRate = frameRate
        self.jsonURL = jsonURL
        self.tracking = try TrackingData.loadFromFile(url: jsonURL)
        
        //templateURL = currentFileURL.appendingPathComponent("template.py")
        
    }
    
    public func processFrames(){
        var currentFrame = 0
        for point in tracking.points{
            let frame = Int(((Float(point.timeStamp)/Float(point.timeScale))/(1/Float(frameRate))).rounded(.toNearestOrAwayFromZero))
            //print(String(frame)+":"+String(currentFrame))
            if(frame < currentFrame){
                //print("Less")
                continue
            }else if frame == currentFrame{
                currentFrame+=1
                frameByFrameTransforms.append(point.position)
            }else{
                for g in 0..<(frame-currentFrame){
                    //print("Above")
                    currentFrame+=1
                    frameByFrameTransforms.append(frameByFrameTransforms.last ?? simd_float4x4(1))
                }
                currentFrame+=1
                frameByFrameTransforms.append(point.position)
            }
        }
    }
    
    public func generateString() -> String{
        if(frameByFrameTransforms.count <= 0){
            fatalError("You need to processFrames() first")
        }
        var pythonString = "["
        for frame in frameByFrameTransforms{
            pythonString.append(contentsOf: "Matrix((("+String(frame.columns.0[0])+","+String(frame.columns.1[0])+","+String(frame.columns.2[0])+","+String(frame.columns.3[0])+"),")
            pythonString.append(contentsOf: "("+String(frame.columns.0[1])+","+String(frame.columns.1[1])+","+String(frame.columns.2[1])+","+String(frame.columns.3[1])+"),")
            pythonString.append(contentsOf: "("+String(frame.columns.0[2])+","+String(frame.columns.1[2])+","+String(frame.columns.2[2])+","+String(frame.columns.3[2])+"),")
            pythonString.append(contentsOf: "("+String(frame.columns.0[3])+","+String(frame.columns.1[3])+","+String(frame.columns.2[3])+","+String(frame.columns.3[3])+"))),")
        }
        pythonString.append("]")
        let templateString = PYTHON_TEMPLATE//try! String(contentsOf: templateURL)

        let outputPython = templateString.replacingOccurrences(of: "### Camera Data HERE ###", with: pythonString)
        return outputPython
    }
}
