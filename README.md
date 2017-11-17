---
output:
  html_document: default
  pdf_document: default
  word_document: default
---

# Framingham package
r-framingham is a package used to estimate the 10-year cardiovascular risk of an individual using Framingham_Risk_Score standard guidelines https://en.wikipedia.org/wiki/Framingham_Risk_Score

The Framingham Risk Score is a gender-specific algorithm used to estimate the 10-year cardiovascular risk of an individual.

## Framingham Algorithim

Below is an algorithim to follow inorder to generate Framingham score for Coronary Heart Disease (10-year risk)

![fig. 1](framingham_score.gif)

 



### Usage
 This package can be used by statistician or data scientist in:
 
 * Survival analysis
 * Time series
 * Risk prediction
 * e.t.c
 
Example:  
```
your_data_frame %>%
group_by(patient_id) %>%
summarise( risk_score=framingham_func(gender=gender,age:age,...))
```
 
 
### Installation

when this package is published, a user can install it by running: 

```
install.packages("r-framingham")
```

### Task Breakdown

* Nour - literature of Framingham and step 1 to 5
* Allan - setup r-package project requirements and step 5 to 10


## Built With

* [Package 1](http://www.github.com) - Package 1
* [Package 2](https://www.github.org) - Package 2
* [Package 3](https://www.github.io) - Package 3

## Contributing

Please read [CONTRIBUTING.md](https://github.com/PHP2560-Statistical-Programming-R/r-framingham/graphs/contributors) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use git for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Nour Audi** - *member* - [member](https://github.com/Nour-Audi)
* **Allan Kimaina** - *member* - [member](https://github.com/kimaina)

See also the list of [contributors](https://github.com/PHP2560-Statistical-Programming-R/r-package-apollo) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc

