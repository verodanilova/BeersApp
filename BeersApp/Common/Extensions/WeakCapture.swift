//
//  WeakCapture.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation


/** Weak capture taking nothing, returning nothing. */
func weakly<T: AnyObject>(_ object: T, _ f: @escaping (T) -> () -> ()) -> () -> () {
    return { [weak object] in
            if let object = object {
                return f(object)()
            }
        }
}

/** Weak capture returning nothing. */
func weakly<T: AnyObject, A>(_ object: T, _ f: @escaping (T) -> (A) -> ()) -> (A) -> () {
    return { [weak object] value in
            if let object = object {
                return f(object)(value)
            }
        }
}
