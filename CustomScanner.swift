

//
//  CustomScanner.swift
//  Kalculitzer
//
//  Created by Gbemiro Jiboye on 08/09/2018.
//  Copyright © 2018 Gbemiro Jiboye. All rights reserved.
//

import Foundation




public struct CustomScanner{
    /**
     * The input to be scanned into tokens.
     */
    var input : String
    /**
     * The tokens to be employed in splitting the
     * input.
     */
    var tokens : [String]
    /**
     * If true the tokens will be included in
     * the output.
     */
    var includeTokensInOutput :  Bool
    
    
    
    
    /**
     *
     * @param input The input to scan.
     * @param includeTokensInOutput Will allow the splitting tokens to be added to the
     * final scan if this attribute is set to true.
     * @param tokens An array of tokens..input as a
     * variable argument list... on which the input is to be split.
     */
    public init( input: String, includeTokensInOutput: Bool, tokens: [String] ) {
        self.input = input
        self.tokens = tokens
        self.includeTokensInOutput = includeTokensInOutput
    }
    
    
    
    /**
     * A convenience constructor used when there exists
     * more than one array containing the tokenizer data.
     * @param input The input to scan.
     * @param includeTokensInOutput Will allow the splitting tokens to be added to the
     * final scan if this attribute is set to true.
     * @param splitterTokens1  An array of tokens..input as a
     * variable argument list... on which the input is to be split.
     * @param splitterTokens2  A second array of tokens..input as a
     * variable argument list... on which the input is to be split.
     *
     */
    public init( input: String , includeTokensInOutput: Bool, splitterTokens1: [String], splitterTokens2: [String] ) {
        self.input = input
        self.tokens = splitterTokens1
        self.tokens += splitterTokens2
        self.includeTokensInOutput = includeTokensInOutput
    }
    
    
    public func scan() -> [String] {
        
        var inp = self.input
        
        var parse : [String] = []
        
        var tokens = self.tokens
        
        tokens.sort(by: lengthWise)
        
        var i : Int = 0
        
        while i < inp.count{
            
            for token in tokens {
                
                let len = token.count
                
                if (len > 0 && i + len <= inp.count) {
                    let portion = substring(text: inp,start:  i, end: i + len)
                    
                    if (portion == token) {
                        if (i != 0) {//avoid empty spaces
                            parse.append(substring(text: inp, start: 0, end: i))
                        }
                        if (includeTokensInOutput) {
                            parse.append(token);
                        }
                        inp = substring( text: inp, startToEnd: i + len)
                        i = -1;
                        break;
                    }
                    
                }
                
            }
            
            i+=1
        }
        
        if (!inp.isEmpty) {
            parse.append(inp)
        }
        
        
        return parse
    }
    
    
    public func runStuff(){
        
        var tokens: [String] = ["sin","sinh","cos","+","(",")"]
        
        let scanner = CustomScanner(input: "42sin(A)cos(B)+9sin(A)sinh(B)", includeTokensInOutput: false, tokens: tokens)
        
        
        let start = Int(DispatchTime.now().rawValue)
        
        var i = 0
        
        let MAX_ITERS: Int = 10
        
        
        while i < MAX_ITERS {
            scanner.scan()
            i += 1
        }
        
        var end = Int(DispatchTime.now().rawValue)
        
        
        var duration = end - start
        
        print(
            "Benchmarks: Total time to run \(MAX_ITERS) iterations is \(duration)\n Average time to run each function is \(  (duration/MAX_ITERS)  )" )
        
    }
    
}


private func lengthWise(value1: String, value2: String) -> Bool {
    // One string is alphabetically first.
    // ... True means value1 precedes value2.
    return value2.count < value1.count;
}

func substring(text: String, start:Int, end:Int) -> String{
    if (start < 0 || start > text.count) || (end < 0 || end > text.count) || start > end {
        return ""
    }
    let startIndex = text.index(text.startIndex, offsetBy: start)
    let endIndex = text.index(text.startIndex, offsetBy: end)
    
    return String(text[startIndex..<endIndex])
}

/**
 * This returns an empty string in case of index errors
 * Else it returns all characters from the supplied index
 * to the end of the string
 */
func substring(text: String, startToEnd:Int ) -> String{
    
    if startToEnd < 0 || startToEnd > text.count {
        return ""
    }
    let startIndex = text.index(text.startIndex, offsetBy: startToEnd)
    let endIndex = text.endIndex
    
    return String(text[startIndex..<endIndex])
}



