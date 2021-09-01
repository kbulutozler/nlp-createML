import CreateML
import Foundation


// Load training and testing data from resources directory
let trainingDataPath = Bundle.main.path(forResource: "training", ofType: "json", inDirectory: "Data")!
let trainingData = try MLDataTable(contentsOf: URL(fileURLWithPath: trainingDataPath))

let testingDataPath = Bundle.main.path(forResource: "testing", ofType: "json", inDirectory: "Data")!
let testingData = try MLDataTable(contentsOf: URL(fileURLWithPath: testingDataPath))

/*
// Set model parameters with transfer learning and dynamic embedding to benefit from context
let modelParameters = try MLTextClassifier.ModelParameters(algorithm: MLTextClassifier.ModelAlgorithmType.transferLearning(MLTextClassifier.FeatureExtractorType.staticEmbedding, revision: 1))

// Train the model on training data with given model parameters
let sentimentClassifier = try MLTextClassifier(trainingData: trainingData,
                                               textColumn: "text",
                                               labelColumn: "label",
                                               parameters: modelParameters)

 */

// Train the model on training data with default method (maxEnt)
let sentimentClassifier = try MLTextClassifier(trainingData: trainingData,
                                               textColumn: "text",
                                               labelColumn: "label")


// Training accuracy as a percentage
let trainingAccuracy = (1.0 - sentimentClassifier.trainingMetrics.classificationError) * 100
print("trainingAccuracy: \(trainingAccuracy)!")

// Validation accuracy as a percentage
let validationAccuracy = (1.0 - sentimentClassifier.validationMetrics.classificationError) * 100
print("validationAccuracy: \(validationAccuracy)!")

// Evaluate the model on test data
let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "label")

// Evaluation accuracy as a percentage
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100
print("evaluationAccuracy: \(evaluationAccuracy)!")

// Evaluation precision-recall
let evaluationPrecisionRecall = evaluationMetrics.precisionRecall
print("evaluationPrecisionRecall: \(evaluationPrecisionRecall)!")

// Describe the model
let metadata = MLModelMetadata(author: "bulut",
                               shortDescription: "A model trained to classify movie review sentiment. Default parameters.",
                               version: "1.0")

// Save the model
try sentimentClassifier.write(to: URL(fileURLWithPath: "/Path/To/Models/MLTextClassifier/sentimentClassifierDefault.mlmodel"),
                              metadata: metadata)


