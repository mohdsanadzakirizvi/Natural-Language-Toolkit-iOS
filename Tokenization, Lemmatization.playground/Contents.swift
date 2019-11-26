import NaturalLanguage

func tokenize(){
    let text = """
    Analytics Vidhya provides a community based knowledge portal for Analytics and Data Science professionals. The aim of the platform is to become a complete portal serving all knowledge and career needs of Data Science Professionals.
    """

    // Initialize the tokenizer with unit of "word"
    let tokenizer = NLTokenizer(unit: .word)
    // Set the string to be processed
    tokenizer.string = text
    // Loop over all the tokens and print them
    tokenizer.enumerateTokens(in: text.startIndex..<text.endIndex) { tokenRange, _ in
        print(text[tokenRange])
        return true
    }
}

func lemma(){
    let text = "swimming, swam, swim, assuming, assumed, assume, learned, learning."
    
    // Initialize the NLTagger with scheme type as "lemma"
    let tagger = NLTagger(tagSchemes: [.lemma])
    // Set the string to be processed
    tagger.string = text
    // Loop over all the tokens and print their lemma
    tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lemma) { tag, tokenRange in
        if let tag = tag {
            print("\(text[tokenRange]): \(tag.rawValue)")
        }
        return true
    }
}

lemma()
