//
//  ParticlesToObjConverter.swift
//  SceneDepthPointCloud
//
//  Created by Mykola Odnoshyvkin on 08.02.21.
//  Copyright © 2021 Apple. All rights reserved.
//


// Converter to PLY
// Generates ASCII PLY file with ‘x, y, z, red, green, blue’ vertex values.
// RGB values are 0-255
final class ParticlesToPlyConverter {
    public func convert(from: MetalBuffer<ParticleUniforms>, count: Int) -> String {
        var result = ""
        
        var header = buildHeader(vertexAmount: count)
        result.append(header)
        
        for index in 0...count {
            let particle = from[index]
            let x = particle.position[0]
            let y = particle.position[1]
            let z = particle.position[2]
            let r = Int(particle.color[0] * 255)
            let g = Int(particle.color[1] * 255)
            let b = Int(particle.color[2] * 255)
            result.append("\(x) \(y) \(z) \(r) \(g) \(b)\r\n")
        }
        
        return result
    }
    
    // http://paulbourke.net/dataformats/ply/
    private func buildHeader(vertexAmount: Int) ->String{
        var header: String = ""
        let lineBreak = "\r\n"
        header.append("ply" + lineBreak)
        header.append("format ascii 1.0" + lineBreak)
        header.append("element vertex \(vertexAmount)" + lineBreak)
        header.append("property float x" + lineBreak)
        header.append("property float y" + lineBreak)
        header.append("property float z" + lineBreak)
        header.append("property uchar red" + lineBreak)
        header.append("property uchar green" + lineBreak)
        header.append("property uchar blue" + lineBreak)
        header.append("end_header" + lineBreak)
        
        return header
    }
}
