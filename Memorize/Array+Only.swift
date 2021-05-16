//
//  Array+Only.swift
//  Memorize
//
//  Created by Felipe Marques Ramos on 02/05/21.
//

import Foundation

extension Array{
    var only: Element?{
        count == 1 ? first : nil
    }
}
