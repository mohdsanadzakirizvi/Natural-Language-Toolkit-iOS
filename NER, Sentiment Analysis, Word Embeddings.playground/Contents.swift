import UIKit
import NaturalLanguage

var str = "Hello, playground"

// Places, People, Organizations using NER
func ner(){
    let text = "Apple is looking at buying U.K. startup for $1 billion."
    let tagger = NLTagger(tagSchemes: [.nameType])
    tagger.string = text
    let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
    let tags: [NLTag] = [.personalName, .placeName, .organizationName]
    tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .nameType, options: options) { tag, tokenRange in
        if let tag = tag, tags.contains(tag) {
            print("\(text[tokenRange]): \(tag.rawValue)")
        }
        return true
    }
}

// Sentiment Analysis
func sentimentCheck(){
    // set up our input
    let input = "Great at first but a horrible aftertaste"

    // feed it into the NaturalLanguage framework
    let tagger = NLTagger(tagSchemes: [.sentimentScore])
    tagger.string = input

    // ask for the results
    let (sentiment, _) = tagger.tag(at: input.startIndex, unit: .sentence, scheme: .sentimentScore)

    // read the sentiment back and print it
    let score = Double(sentiment?.rawValue ?? "0") ?? 0
    print(score)
}

// Extract word embeddings
func embedCheck(){
    
}
