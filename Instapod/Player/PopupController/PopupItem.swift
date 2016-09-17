//
//  PopupItem.swift
//  PopupController
//
//  Created by Christopher Reitz on 15.03.16.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

class PopupItem: NSObject {

    let observationContext: UnsafeMutableRawPointer? = nil

    var _title: String?
    var title: String? {
        get {
            if self._title == nil && self.subtitle == nil {
                return "TODO"
//                return containerController!.title
            }
            return self._title
        }
        set {
            self._title = newValue
        }
    }
    var subtitle: String?

    var progress: Float = 0.0 {
        didSet {
            willChangeValue(forKey: NSStringFromSelector(#selector(getter: ProgressReporting.progress)))
            if progress > 1.0  {
                progress = 1.0
            }
            didChangeValue(forKey: NSStringFromSelector(#selector(getter: ProgressReporting.progress)))
        }
    }

    var leftBarButtonItems = [UIBarButtonItem]()
    var rightBarButtonItems = [UIBarButtonItem]()

    var itemDelegate: PopupItemDelegate?
    var containerController: UIViewController?

    override init() {
        super.init()

        addObserver(self, forKeyPath: "title", options: [], context: observationContext)
        addObserver(self, forKeyPath: "subtitle", options: [], context: observationContext)
        addObserver(self, forKeyPath: "progress", options: [], context: observationContext)
        addObserver(self, forKeyPath: "leftBarButtonItems", options: [], context: observationContext)
        addObserver(self, forKeyPath: "rightBarButtonItems", options: [], context: observationContext)
    }

    deinit {
        removeObserver(self, forKeyPath: "title", context: observationContext)
        removeObserver(self, forKeyPath: "subtitle", context: observationContext)
        removeObserver(self, forKeyPath: "progress", context: observationContext)
        removeObserver(self, forKeyPath: "leftBarButtonItems", context: observationContext)
        removeObserver(self, forKeyPath: "rightBarButtonItems", context: observationContext)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == observationContext {
            itemDelegate?.popupItem(self, didChangeValueForKey:keyPath!)
        }
    }


}
