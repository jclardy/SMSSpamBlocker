import CreateML
import Cocoa

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/jason/Documents/CoreML/fulldata.csv"))

print(data)

let (trainingData, testingData) = data.randomSplit(by: 0.95, seed: 9)
let sentimentClassifier = try MLTextClassifier(trainingData: trainingData,
                                               textColumn: "body",
                                               labelColumn: "spam_type")


// Training accuracy as a percentage
let trainingAccuracy = (1.0 - sentimentClassifier.trainingMetrics.classificationError) * 100

// Validation accuracy as a percentage
let validationAccuracy = (1.0 - sentimentClassifier.validationMetrics.classificationError) * 100


let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)


// Evaluation accuracy as a percentage
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100


let testData = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/jason/Documents/CoreML/spam_tests.csv"))
let evaluation = sentimentClassifier.evaluation(on: testData)


let testData2 = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/jason/Documents/CoreML/examples.csv"))
let evaluation2 = sentimentClassifier.evaluation(on: testData2)

let metadata = MLModelMetadata(author: "Jason Clardy",
                               shortDescription: "A model trained to classify spam text messages.",
                               version: "0.1")

try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/jason/Documents/CoreML/SpamClassifier.mlmodel"),
                              metadata: metadata)
