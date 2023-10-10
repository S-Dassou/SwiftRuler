//
//  ViewController.swift
//  RulerSample
//
//  Created by shafique dassu on 08/10/2023.
//

import UIKit

class ViewController: UIViewController, RKMultiUnitRulerDataSource, RKMultiUnitRulerDelegate {

    @IBOutlet weak var ruler: RKMultiUnitRuler!
    
    var rangeStart = Measurement(value: 60.0, unit: UnitLength.centimeters)
    var rangeLength = Measurement(value: Double(150), unit: UnitLength.centimeters)
    var direction: RKLayerDirection = .horizontal
    var segments = Array<RKSegmentUnit>()
    var numberOfSegments: Int {
        get {
            return segments.count
        }
        set {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        segments = self.createSegments()
        ruler.delegate = self
        ruler.dataSource = self
    }
    
    private func createSegments() -> Array<RKSegmentUnit> {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.unitOptions = .providedUnit
        let kgSegment = RKSegmentUnit(name: "CM", unit: UnitLength.centimeters, formatter: formatter)

        kgSegment.name = "CM"
        kgSegment.unit = UnitLength.centimeters
        let kgMarkerTypeMax = RKRangeMarkerType(color: UIColor.white, size: CGSize(width: 1.0, height: 50.0), scale: 5.0)
        kgMarkerTypeMax.labelVisible = true
        kgSegment.markerTypes = [
            RKRangeMarkerType(color: UIColor.white, size: CGSize(width: 1.0, height: 35.0), scale: 1.0),
            RKRangeMarkerType(color: UIColor.white, size: CGSize(width: 1.0, height: 50.0), scale: 10.0)]

        let lbsSegment = RKSegmentUnit(name: "FT", unit: UnitLength.feet, formatter: formatter)
        let lbsMarkerTypeMax = RKRangeMarkerType(color: UIColor.white, size: CGSize(width: 1.0, height: 50.0), scale: 5.0)

        lbsSegment.markerTypes = [
            RKRangeMarkerType(color: UIColor.white, size: CGSize(width: 1.0, height: 35.0), scale: 0.1),
            RKRangeMarkerType(color: UIColor.white, size: CGSize(width: 1.0, height: 50.0), scale: 1.0)
        
        ]

        kgSegment.markerTypes.last?.labelVisible = true
        lbsSegment.markerTypes.last?.labelVisible = true
        return [kgSegment, lbsSegment]
    }
    
    func unitForSegmentAtIndex(index: Int) -> RKSegmentUnit {
        return segments[index]
    }
    
    func rangeForUnit(_ unit: Dimension) -> RKRange<Float> {
        let locationConverted = rangeStart.converted(to: unit as! UnitLength)
        let lengthConverted = rangeLength.converted(to: unit as! UnitLength)
        return RKRange<Float>(location: ceilf(Float(locationConverted.value)),
                              length: ceilf(Float(lengthConverted.value)))
    }
    
    
    func styleForUnit(_ unit: Dimension) -> RKSegmentUnitControlStyle {
        let style: RKSegmentUnitControlStyle = RKSegmentUnitControlStyle()
        //style.scrollViewBackgroundColor = UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.0)
        let range = self.rangeForUnit(unit)
        if unit == UnitMass.pounds {

            style.textFieldBackgroundColor = UIColor.clear
            // color override location:location+40% red , location+60%:location.100% green
        } else {
            style.textFieldBackgroundColor = UIColor.red
        }
        style.textFieldBackgroundColor = UIColor.clear
        style.textFieldTextColor = UIColor.white
        return style
    }
    
    func valueChanged(measurement: NSMeasurement) {
        print("value changed to \(measurement.doubleValue)")
    }

}

