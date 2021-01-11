import Foundation

enum Pizza {
    case preparePizza(id: Int, size: Int?, type: PizzaType, doughType:  DoughType)
    case addedExtras(id: Int, extras: [String:Int])
    case bakedPizza(id: Int)
    case deliveredPizza(id: Int)
    
    init(id: Int, size: Int?, type: PizzaType, doughType:  DoughType) {
        self = .preparePizza(id: id, size: size, type: type, doughType: doughType)
    }
    
    var isDelivered: Bool {
        switch self {
        case .preparePizza(id: _, size: _, type: _, doughType: _):
            return false
        case .addedExtras(id: _, extras: _):
            return false
        case .bakedPizza(id: _):
            return false
        case .deliveredPizza(id: _):
            return true
        }
    }
    
    var isBaked: Bool {
        switch self {
        case .preparePizza(id: _, size: _, type: _, doughType: _):
            return false
        case .addedExtras(id: _, extras: _):
            return false
        case .bakedPizza(id: _):
            return true
        case .deliveredPizza(id: _):
            return false
        }
    }
    
    var currentState: String {
        switch self {
        case .preparePizza(id: let id, size: _, type: _, doughType: _):
            return "Pizza \(id) prepared"
        case .addedExtras(id: let id, extras: _):
            return "Added extras to pizza \(id)"
        case .bakedPizza(id: let id):
            return "Baked pizza \(id)"
        case .deliveredPizza(id: let id):
            return "Delivered pizza \(id)"
        }
    }
    
    mutating func addExtras(id: Int, extras: [String:Int]) {
        switch self {
        case .preparePizza(id: let id, size: _, type: _, doughType: _):
            self = .addedExtras(id: id, extras: extras)
        case .addedExtras(id: let id, extras: _):
            self = .addedExtras(id: id, extras: extras)
        case .bakedPizza(id: let id):
            print("Cannot add extras to Piza \(id) at this phase")
        case .deliveredPizza(id: _):
            print("Pizza \(id) must be baked before delivery")
    }
    }
    
    mutating func bakePizza() {
        switch self {
        case .preparePizza(id: let id, size: _, type: _, doughType: _):
            self = .bakedPizza(id: id)
        case .addedExtras(id: let id, extras: _):
            self = .bakedPizza(id: id)
        case .bakedPizza(id: let id):
            print("Pizza \(id) is already baked")
        case .deliveredPizza(id: let id):
            print("Pizza \(id) is already delivered")
        }
    }
    
    mutating func deliverPizza() {
        switch self {
        case .preparePizza(id: let id, size: _, type: _, doughType: _):
            print("Pizza \(id) must be baked before delivery")
        case .addedExtras(id: let id, extras: _):
            print("Cannot add extras to Pizza \(id) at this phase")
        case .bakedPizza(id: let id):
            self = .deliveredPizza(id: id)
        case .deliveredPizza(id: let id):
            print("Pizza \(id) is already delivered")
        }
    }
}

enum PizzaType: String {
    case napolitana = "Napolitana"
    case bufalla = "Buffala"
}

enum DoughType: String {
    case thin = "Thin"
    case medium = "Medium"
    case thick = "Thick"
}

var napolitana = Pizza(id: 0, size: 8, type: .napolitana, doughType: .thin)
print(napolitana.currentState)
napolitana.bakePizza()
print(napolitana.currentState)
napolitana.deliverPizza()
print(napolitana.currentState)
