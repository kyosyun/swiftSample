//
//  ExtentionCompatible.swift
//  CameraCropPractice
//
//  Created by Keisei Saito on 2017/10/12.
//  Copyright © 2017 Keisei Saito. All rights reserved.
//

struct Extension<Base> {
    let base: Base
    init (_ base: Base) {
        self.base = base
    }
}

protocol ExtensionCompatible {
    associatedtype Compatible
    static var ex: Extension<Compatible>.Type { get }
    var ex: Extension<Compatible> { get }
}

extension ExtensionCompatible {
    static var ex: Extension<Self>.Type {
        return Extension<Self>.self
    }

    var ex: Extension<Self> {
        return Extension(self)
    }
}
