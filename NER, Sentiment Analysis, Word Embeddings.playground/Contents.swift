import UIKit
import NaturalLanguage

var str = "Hello, playground"

// Places, People, Organizations using NER
func ner(){
    let text = "Apple is looking at buying U.K. startup for $1 billion."
    
    // Initialize NLTagger with ".nameType" scheme for NER
    let tagger = NLTagger(tagSchemes: [.nameType])
    tagger.string = text
    // Ignore Punctuation and Whitespace
    let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
    // Tags to extract
    let tags: [NLTag] = [.personalName, .placeName, .organizationName]
    // Loop over the tokens and print the NER of the tokens
    tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .nameType, options: options) { tag, tokenRange in
        if let tag = tag, tags.contains(tag) {
            print("\(text[tokenRange]): \(tag.rawValue)")
        }
        return true
    }
}

//ner()

// Sentiment Analysis
func sentimentCheck(){
    // Set up our input
    let input = "I hate this apple pie."

    // Feed it into the NaturalLanguage framework
    let tagger = NLTagger(tagSchemes: [.sentimentScore])
    tagger.string = input

    // Ask for the results
    let sentiment = tagger.tag(at: input.startIndex, unit: .paragraph, scheme: .sentimentScore).0

    // Read the sentiment back and print it
    let score = Double(sentiment?.rawValue ?? "0") ?? 0
    
    // Print the right smiley based on sentiment
    if score == 0{
        print("🙂")
    }
    else if score < 0{
        print("😢")
    }
    else {
        print("😁")
    }
    
    // Print the final sentiment score
    print("The sentiment score is: \(score)")
}

//sentimentCheck()

// Find similar words based on embedding
func embedCheck(word: String){
    // Extract the language type
    let lang = NLLanguageRecognizer.dominantLanguage(for: word)
    // Get the OS embeddings for the given language
    let embedding = NLEmbedding.wordEmbedding(for: lang!)
    
    // Find the 5 words that are nearest to the input word based on the embedding
    let res = embedding?.neighbors(for: word, maximumCount: 5)
    // Print the words
    print(res ?? [])
}

// Find words similar to cheese
embedCheck(word: "cheese")
