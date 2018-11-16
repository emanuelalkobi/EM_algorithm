# ec503_project


# project task:

(a) EM main ideas [Murphy,Sec.11.4.1]

(b) Study EM in the context of clustering. Use GMMs as a key model for 
clustering. [Murphy,Sec.11.4.2]

(c) Explore connection with k-means. [Murphy,Sec.11.4.5]

(d) Study the impact of various initialization [Murphy,Sec.11.4.2.7].

(e) Study the need for prior (Bayesian regularization) [Murphy,Sec.11.4.2.8]

(f) Study the application of EM for missing-data problems. 
[Murphy,Sec.11.6]. Also read [Murphy,Sec.8.6.2]

(g) Repeat some parts of (b)--(f) for the so-called "mixture of product 
of Bernoullis" model: all features are binary and in each mixture 
component, you assume a Naive-Bayes Bernoulli model. You can derive the 
EM algorithm for this model. You can apply it to cluster the 
binarized-MNIST dataset. You can even study the missing-data problem on 
this dataset. The results will be very visual. You can read more about 
EM for mixture of Bernoulli models here:


https://cedar.buffalo.edu/~srihari/CSE574/Chap9/Ch9.4-MixturesofBernoulli.pdf



# data set number 1 :

http://archive.ics.uci.edu/ml/datasets/Adult

this data set has 2 labels:

1.annual salary is higher  or equal to  50k =>50K

2.annual salary is less  than 50k  <=50K. 

this data set has 14 features:

age: continuous. 

workclass: Private, Self-emp-not-inc, Self-emp-inc, Federal-gov, Local-gov, State-gov, Without-pay, Never-worked. 
fnlwgt: continuous. 

education: Bachelors, Some-college, 11th, HS-grad, Prof-school, Assoc-acdm, Assoc-voc, 9th, 7th-8th, 12th, Masters, 1st-4th, 10th, Doctorate, 5th-6th, Preschool.

education-num: continuous. 

marital-status: Married-civ-spouse, Divorced, Never-married, Separated, Widowed, Married-spouse-absent, Married-AF-spouse. 

occupation: Tech-support, Craft-repair, Other-service, Sales, Exec-managerial, Prof-specialty, Handlers-cleaners, Machine-op-inspct, Adm-clerical, Farming-fishing, Transport-moving, Priv-house-serv, Protective-serv, Armed-Forces. 

relationship: Wife, Own-child, Husband, Not-in-family, Other-relative, Unmarried. 

race: White, Asian-Pac-Islander, Amer-Indian-Eskimo, Other, Black. 
sex: Female, Male. 

capital-gain: continuous.

capital-loss: continuous. 

hours-per-week: continuous.

native-country: United-States, Cambodia, England, Puerto-Rico, Canada, Germany, Outlying-US(Guam-USVI-etc), India, Japan, Greece, South, China, Cuba, Iran, Honduras, Philippines, Italy, Poland, Jamaica, Vietnam, Mexico, Portugal, Ireland, France, Dominican-Republic, Laos, Ecuador, Taiwan, Haiti, Columbia, Hungary, Guatemala, Nicaragua, Scotland, Thailand, Yugoslavia, El-Salvador, Trinadad&Tobago, Peru, Hong, Holand-Netherland



# data set number 2 :

http://archive.ics.uci.edu/ml/datasets/zoo

this data set has 7 labels

   1. (41) aardvark, antelope, bear, boar, buffalo, calf, cavy, cheetah, deer, dolphin, elephant, fruitbat, giraffe, girl,
   
   goat, gorilla, hamster, hare, leopard, lion, lynx, mink, mole, mongoose, opossum, oryx, platypus, polecat, pony, porpoise,
   
   puma, pussycat, raccoon, reindeer, seal, sealion, squirrel, vampire, vole, wallaby,wolf 
   
   2. (20) chicken, crow, dove, duck, flamingo, gull, hawk, kiwi, lark, ostrich, parakeet, penguin, pheasant, rhea, skimmer, 
   skua, sparrow, swan, vulture, wren 
   
   3 . (5) pitviper, seasnake, slowworm, tortoise, tuatara 
   
   4 . (13) bass, carp, catfish, chub, dogfish, haddock, herring, pike, piranha, seahorse, sole, stingray, tuna 
   
   5 . (4) frog, frog, newt, toad 
   
   6 . (8) flea, gnat, honeybee, housefly, ladybird, moth, termite, wasp 
   
   7 . (10) clam, crab, crayfish, lobster, octopus, scorpion, seawasp, slug, starfish, worm

this data set has 17 features(including animal name):

   1. animal name:      Unique for each instance
   
   2. hair		Boolean
   
   3. feathers		Boolean
   
   4. eggs		Boolean
   
   5. milk		Boolean
   
   6. airborne		Boolean
   
   7. aquatic		Boolean
   
   8. predator		Boolean
   
   9. toothed		Boolean
   
  10. backbone		Boolean
  
  11. breathes		Boolean
  
  12. venomous		Boolean
  
  13. fins		Boolean
  
  14. legs		Numeric (set of values: {0,2,4,5,6,8})
  
  15. tail		Boolean
  
  16. domestic		Boolean
  
  17. catsize		Boolean
