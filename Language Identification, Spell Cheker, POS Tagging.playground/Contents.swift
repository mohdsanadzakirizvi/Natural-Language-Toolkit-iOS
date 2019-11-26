import UIKit
import NaturalLanguage


// Check the dominant language in a piece of text
func langCheck(){
    let string1 = """
    Hello world, I love machine learning and I work as a Data Scientist in India.
    機械学習で働くのが好き
    """
    let string2 = "    أحب العمل في التعلم الآلي"
    
    // Initialize LanguageRecognizer
    let languageRecog = NLLanguageRecognizer()
    
    // find the dominant language
    languageRecog.processString(string1)
    print("Dominant language is: \(languageRecog.dominantLanguage?.rawValue)")
    
    // identify the possible languages
    languageRecog.processString(string2)
    print("Possible languages are:\(languageRecog.languageHypotheses(withMaximum: 2))")
    
    
}

// Check and suggest the spelling of words in the text
func spellCheck(){
    let string = """
    I started my schooling as the majority did in my area, at the local primarry school. I then
    went to the local secondarry school and recieved grades in English, Maths, Phisics,
    Biology, Geography, Art, Graphical Comunication and Philosophy of Religeon. I'll not
    bore you with the 'A' levels and above.
    """

    // find the dominant language of text
    let dominantLanguage = NLLanguageRecognizer.dominantLanguage(for: string)

    print(string+", has dominant language:\(dominantLanguage!.rawValue)")

    // initialize UITextChecker, nsString, stringRange
    let textChecker = UITextChecker()
    let nsString = NSString(string: string)
    let stringRange = NSRange(location: 0, length: nsString.length)
    var offset = 0

    repeat {
        // find the range of misspelt word
        let wordRange =
                textChecker.rangeOfMisspelledWord(in: string,
                                                  range: stringRange,
                                                  startingAt: offset,
                                                  wrap: false,
                                                  language: dominantLanguage!.rawValue)
        
        // check if the loop range exceeds the string length
        guard wordRange.location != NSNotFound else {
            break
        }

        // get the misspelt word
        print(nsString.substring(with: wordRange))
        
        // get some suggested words for the misspelt word
        print(textChecker.guesses(forWordRange: wordRange, in: string, language: dominantLanguage!.rawValue))
        
        // update the start index or offset
        offset = wordRange.upperBound
    } while true
}

// POS and NER
func posCheck(){
    let text = "Hello world, I am a data scientist. I work with machine learning!"
    
    // Initialize the tagger
    let tagger = NLTagger(tagSchemes: [.lexicalClass])
    let options : NLTagger.Options = [.omitWhitespace, .omitPunctuation]
    tagger.string = text
    
    tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
        if let tag = tag{
            print("\(text[tokenRange]): \(tag.rawValue)")
        }
        return true
    }
}

posCheck()

