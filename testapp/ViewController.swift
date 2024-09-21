//
//  ViewController.swift
//  testapp
//
//  Created by Avaz on 21/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        variablesFunctions();
        arraysLearning();
        ifElseFunctions();
        loopFunctions();
        setsLearning();
        dictionaryLearning();
    }
    
    func variablesFunctions(){
        let constants = "1";
        var changeableVariables = 11;
        print(constants + " is constant",
              " hello hello \(changeableVariables)");
        
        let namedTypes: String = "My name is Avaz"
        
        let doubleType: Double = 0.1;
        
        var integerType : Int = 19;
        
        print(namedTypes, doubleType, integerType);
        
        var nullOperators : Double? = nil
        
        if nullOperators == nil{
            nullOperators = 12;
        }
        
        print(nullOperators ?? 1);
    }
    
    func arraysLearning(){
        let arrays : [Int] = [10, 20, 30];
        
        let otherArray  = [40, 50, 60];
        
        var changeableArray : [Double] = [
            20, 30, 40.0,
        ];
        
        changeableArray.removeAll { (number) in
            return number == 30;
        }
        
        changeableArray.removeAll { $0 == 30 }
        
        changeableArray.append(45)
        
        var anotherValue = changeableArray.map { anyvalue in
            return anyvalue == 45 ? 50 : 0;
        }
        
        print(changeableArray, "another list after map: \(anotherValue)");
    }
    
    func setsLearning(){
        let setData : Set<String?> = ["Rock", "Rock", "Paper"]
        
        print(setData)
    }
    
    // similar to the Dart's Map
    func dictionaryLearning(){
        let dictionaryData : [String: Int?] = ["Avaz" : 22, "Jam" : nil];
        
        let anotherDict: [String: Int?] = dictionaryData.reduce(into: [String: Int?]()) { partialResult, some in
            if some.key == "Avaz"{
                partialResult["Dilsh"] = some.value;
            }
            partialResult[some.key] = some.value
        }
        
        print(dictionaryData, anotherDict)
    }
    
    func ifElseFunctions(){
        var valueOfBool: Bool = false;
        
        if valueOfBool == false {
            valueOfBool = true;
        } else if valueOfBool == true{
            valueOfBool = false;
        }
        
        print(valueOfBool);
        
        valueOfBool = !valueOfBool;
        
        print(valueOfBool);
    }
    
    
    func loopFunctions(){
        let namesOfPeople : [String?] = ["Avaz" , nil, "Jamshed"];
        
        for item in namesOfPeople {
            print("name of person: \(item)")
        }
        
        for i in 0..<namesOfPeople.count{
            print("name of another loop: \(namesOfPeople[i] ?? "")")
        }
    }
    
    
}

