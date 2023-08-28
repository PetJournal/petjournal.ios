//
//  WaitingViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import SwiftUI

enum FocusStateOTP: Hashable {
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}

class WaitingViewModel: ObservableObject {
    @Published var code: String = ""
    @Published var codeFields: [String] = Array(repeating: "", count: 6)
    @FocusState var activeField: FocusStateOTP?
    @Published var cancel: Bool = false
    
    func checkValueField(value: [String]) {
        for index in 0..<5 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = activeState(index: index - 1)
            }
        }
        
        for index in 0..<6 {
            if value[index].count > 1 {
                codeFields[index] = String(value[index].last!)
            }
        }
    }
    
    func activeState(index: Int) -> FocusStateOTP {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        case 3: return .field4
        case 4: return .field5
        default:
            return .field6
        }
    }
    
    func checkState() -> Bool {
        for index in 0..<6 {
            if codeFields[index].isEmpty {return true}
        }
        return false
    }
    
    func codeValid() {
        if codeCheck {
            self.cancel.toggle()
        }
        self.cancel.toggle()
    }
}

extension WaitingViewModel {
    var codeCheck: Bool {
        let mockCode = ["1", "2", "3", "4", "5", "6"]
        if mockCode == codeFields {
            return true
        }
        return false
    }
    
    var checkCodeValidation: String {
        if !codeCheck {
            return "O código de verificação que você inseriu não é válido. Verifique o código e tente novamente"
        }
        return ""
    }
    
    var codeReset: Bool {
        return true
    }
}
