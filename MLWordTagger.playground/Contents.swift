import CreateML
import Foundation


// Load training and testing data from resources directory
let trainingDataPath = Bundle.main.path(forResource: "unnormalized_train_6k", ofType: "json", inDirectory: "Data")!
let trainingData = try MLDataTable(contentsOf: URL(fileURLWithPath: trainingDataPath))

let testingDataPath = Bundle.main.path(forResource: "unnormalized_test_3k", ofType: "json", inDirectory: "Data")!
let testingData = try MLDataTable(contentsOf: URL(fileURLWithPath: testingDataPath))

/*
// Set model parameters with transfer learning and dynamic embedding to benefit from context
let modelParameters = try MLWordTagger.ModelParameters(algorithm: MLWordTagger.ModelAlgorithmType.transferLearning(MLWordTagger.FeatureExtractorType.dynamicEmbedding, revision: 1))

// Train the model on training data with given model parameters
let wordTagger = try MLWordTagger(trainingData: trainingData,
                                  tokenColumn: "tokens",
                                  labelColumn: "labels",
                                  parameters: modelParameters)

 */


let wordTagger = try MLWordTagger(trainingData: trainingData,
                             tokenColumn: "tokens",
                             labelColumn: "labels")
 


// Training accuracy as a percentage
let trainingAccuracy = (1.0 - wordTagger.trainingMetrics.taggingError) * 100

// Validation accuracy as a percentage
let validationAccuracy = (1.0 - wordTagger.validationMetrics.taggingError) * 100


let evaluationMetrics = wordTagger.evaluation(on: testingData,
                                              tokenColumn: "tokens",
                                              labelColumn: "labels")

// Evaluation accuracy as a percentage
let evaluationAccuracy = (1.0 - evaluationMetrics.taggingError) * 100

// Evaluation precision-recall
let evaluationPrecisionRecall = evaluationMetrics.precisionRecall
print("evaluationPrecisionRecall: \(evaluationPrecisionRecall)!")

// Describe the model
let metadata = MLModelMetadata(author: "bulut",
                               shortDescription: "A model trained to tag labels of tokens/words. Default parameters.",
                               version: "1.0")

// Save the model
try sentimentClassifier.write(to: URL(fileURLWithPath: "/Path/To/Models/MLWordTagger/wordTaggerDefault.mlmodel"),
                              metadata: metadata)
