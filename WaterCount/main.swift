//
//  main.swift
//  WaterCount
//
//  Created by EyreFree on 2018/3/5.
//  Copyright © 2018年 EyreFree. All rights reserved.
//

import Foundation

// 常量
class Constant {
    static let MIN_RECTS_COUNT = 2  // 最小 rect 数
}

// 异常码
enum ExitCode: Int {
    case success = 0
    case tooFewRects = 1
    case errorRect = 2
    case unknown = 3
    
    static let Desc = [
        "",
        "输入 Rects 数量小于 \(Constant.MIN_RECTS_COUNT)",
        "某 Rect 格式有误",
        "未知错误"
    ]
}

// Rect 结构体
struct Rect {
    var x1 = 0
    var x2 = 1
    var h = 1
    
    init?(x1: Int, x2: Int, h: Int) {
        if !(x1 > 0 && x2 > x1 && h > 0) {
            return nil
        }
        
        self.x1 = x1
        self.x2 = x2
        self.h = h
    }
}

// 某 1x1 区块
struct Point {
    var x1 = 0
    var x2 = 1
    var y1 = 0
    var y2 = 1
    
    init?(x1: Int, x2: Int, y1: Int, y2: Int) {
        if !(x1 < x2 && y1 < y2) {
            return nil
        }
        
        self.x1 = x1
        self.x2 = x2
        self.y1 = y1
        self.y2 = y2
    }
}

func input(rects: [(Int, Int, Int)]) -> (ExitCode, Int) {
    // 1. 输入的实体矩形数据转为结构体数组，同时检测输入是否合法
    if rects.count < 2 {
        return (.tooFewRects, -1)
    }
    var rectArray = [Rect]()
    for rect in rects {
        if let rectSct = Rect(x1: rect.0, x2: rect.1, h: rect.2) {
            // 如果不为第一个，则需要额外判断与前一个 rect 的关系是否成立
            if let lastRect = rectArray.last {
                if !(rectSct.x1 >= lastRect.x2) {
                    return (.errorRect, -1)
                }
            }
            
            // 追加到 rect 数组
            rectArray.append(rectSct)
        } else {
            return (.errorRect, -1)
        }
    }
    
    // 2. 生成热区
    var hotRange: Rect?
    if let minX = rectArray.first?.x2, let maxX = rectArray.last?.x1 {
        var maxH = 0
        for rectSct in rectArray {
            if rectSct.h > maxH {
                maxH = rectSct.h
            }
        }
        hotRange = Rect(x1: minX, x2: maxX, h: maxH)
    }
    
    // 3. 遍历热区
    guard let range = hotRange else {
        return (.unknown, -1)
    }
    
    // 某区是否为实体矩形
    func isPointSolid(_ point: Point) -> Bool {
        for rectSct in rectArray {
            if rectSct.h >= point.y2 && rectSct.x1 <= point.x1 && rectSct.x2 >= point.x2 {
                return true
            }
        }
        return false
    }
    // 某区水滴能否驻留
    func isPointNoLoss(_ point: Point) -> Bool {
        // 如果是矩形实体则无法驻留
        if isPointSolid(point) {
            return false
        }
        
        // 左边有阻挡
        var markLeft = false
        for x in (range.x1 - 1) ..< point.x1 {
            if let testPoint = Point(x1: x, x2: x + 1, y1: point.y1, y2: point.y2) {
                if isPointSolid(testPoint) {
                    markLeft = true
                }
            }
        }
        // 右边有阻挡
        var markRight = false
        for x in point.x2 ..< (range.x2 + 1) {
            if let testPoint = Point(x1: x, x2: x + 1, y1: point.y1, y2: point.y2) {
                if isPointSolid(testPoint) {
                    markRight = true
                }
            }
        }
        return markLeft && markRight
    }

    var count = 0
    for x in range.x1 ..< range.x2 {
        for y in 0 ..< range.h {
            if let testPoint = Point(x1: x, x2: x + 1, y1: y, y2: y + 1) {
                if isPointNoLoss(testPoint) {
                    count += 1
                }
            }
        }
    }
    
    return (.success, count)
}

// 使用示例
var result = input(rects: [(1, 2, 2), (3, 4, 3), (5, 8, 1), (9, 10, 2)])
if .success != result.0 {
    print(ExitCode.Desc[result.0.rawValue])
} else {
    print(result.1)
}

result = input(rects: [(1, 2, 2), (1, 4, 5), (5, 8, 4), (9, 10, 2)])
if .success != result.0 {
    print(ExitCode.Desc[result.0.rawValue])
} else {
    print(result.1)
}
