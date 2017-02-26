//
//  QuestionsProvider.swift
//  TrueFalseStarter
//
//  Created by Benson Lo on 20/2/2017.
//  Copyright © 2017年 Treehouse. All rights reserved.
//

struct Question {
    let question: String
    let options: [String]
    let correctAnswer: Int
    
}

let question1 = Question(question: "This was the only US President to serve more than two consecutive terms.",
                         options: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"],
                         correctAnswer: 2)
let question2 = Question(question: "Which of the following countries has the most residents?",
                         options: ["Nigeria", "Russia", "Iran", "Vietnam"],
                         correctAnswer: 1)
let question3 = Question(question: "In what year was the United Nations founded?",
                         options: ["1918", "1919", "1945", "1954"],
                         correctAnswer: 3)
let question4 = Question(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
                         options: ["Paris", "Washington D.C.", "New York City", "Boston"],
                         correctAnswer: 3)
let question5 = Question(question: "Which nation produces the most oil?",
                         options: ["Iran", "Iraq", "Brazil", "Canada"],
                         correctAnswer: 4)
let question6 = Question(question: "Which country has most recently won consecutive World Cups in Soccer?",
                         options: ["Italy", "Brazil", "Argetina", "Spain"],
                         correctAnswer: 2)
let question7 = Question(question: "Which of the following rivers is longest?",
                         options: ["Yangtze", "Mississippi", "Congo", "Mekong"],
                         correctAnswer: 2)
let question8 = Question(question: "Which city is the oldest?",
                         options: ["Mexico City", "Cape Town", "San Juan", "Sydney"],
                         correctAnswer: 1)
let question9 = Question(question: "Which country was the first to allow women to vote in national elections?",
                         options: ["Poland", "United States", "Sweden", "Senegal"],
                         correctAnswer: 1)
let question10 = Question(question: "Which of these countries won the most medals in the 2012 Summer Games?",
                          options: ["France", "Germany", "Japan", "Great Britian"],
                          correctAnswer: 4)
let question11 = Question(question: "What is the answer of 3 plus 4?",
                          options: ["7", "9", "100"],
                          correctAnswer: 1)
let question12 = Question(question: "Which one is a food?",
                          options: ["chair", "fish", "pen", "doctor"],
                          correctAnswer: 2)

struct QuestionsProvider {
    var questions = [
        question1, question2, question3, question4, question5,
        question6, question7, question8, question9, question10, question11, question12
    ]
}




















