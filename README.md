# nlp-createML
This repository is for publishing documented examples of NLP applications with Apple's createML. 

## Sequence Classification
The data can be found [here](https://ai.stanford.edu/~amaas/data/sentiment/ "Named link title"). It consists of highly polar movie reviews. After downloading the file, it will be shown as a directory named *aclImdb*. Put this folder in this repository.

* If you don't want to change/redo the way the dataset is preprocessed, go to Datasets/MLTextClassifier/ and see ready-to-go dataset files.
* If you do, use the notebook *MLTextClassifier_preprocessing.ipynb* to extract the training and testing datasets in the json format. 
Change the dataset path to where you put *aclImdb* folder. 
* The notebook will create 2 files: training.json, testing.json. Go to xcode and add these files to Resources folder of the project. 
* In the xcode, you can train the default model which is maximum entropy, or transfer learning method. The results I got is in the table:

Model  | Accuracy
------------- | -------------
Original Best*  | %88.89
maxEnt  |  %87.52 
transferLearning  |  %74.45 

* Best result in the [paper](https://ai.stanford.edu/~amaas/papers/wvSent_acl2011.pdf "Named link title") under the column *Our Dataset*.

## Token Classification
The data can be found [here](https://www.kaggle.com/c/text-normalization-challenge-english-language/data "Named link title") 
and [here](https://www.kaggle.com/atmarouane/en-partofspeech-tags "Named link title"). *en_train.csv* has tokens in both normalized 
and unnormalized form. Tokens belong to a large list of sentences. *pos_tags.csv* has tags for tokens that have "plain" class in *en_train.csv*.

* If you don't want to change/redo the way the dataset is preprocessed, go to Datasets/MLWordTagger/ and see ready-to-go dataset files.
* If you do, use the notebook *MLWordTagger_preprocessing.ipynb* to extract the training and testing datasets in the json format. 
Change the dataset path to where you put *en_train.csv* and *pos_tags.csv* files. 
* The notebook will create several files with different sizes since the original dataset is pretty large and slow to process. 
Since the original dataset has both unnormalized and normalized tokens, the notebook creates training and testing files for each.
Choose the files you want to use, go to xcode and add these files to Resources folder of the project. 
* In the xcode, you can train the default model which is crf, or transfer learning method. The results I got is in the table:

Model |  Training (Size)  |  Testing (Size)  | Accuracy
------------- | -------------  | -------------  | -------------
crf  |  normalized (12k)  |  normalized (3k)  |  -  
transferLearning  |  normalized (12k)  |  normalized (3k)  |  - 



[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fkbulutozler%2Fsentiment-classifier-createML&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)
