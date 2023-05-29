//
//  ViewCode.swift
//  LearningTask-12.3
//
//  Created by Jeovane Barbosa on 20/01/23.
//

import Foundation

protocol ViewCode {
    func setUpViewHierarchy()
    func applyConstraints()
    func applyAdditionalSettings()
}

extension ViewCode {
    func setUpViewCode(){
        setUpViewHierarchy()
        applyConstraints()
        applyAdditionalSettings()
    }
}
