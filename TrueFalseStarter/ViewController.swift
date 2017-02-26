//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    var gameSound: SystemSoundID = 0
    
    // Load questions set from QuestionsProvider file
    var questionsProvider = QuestionsProvider()
    
    /*
    let trivia: [[String : String]] = [
        ["Question": "Only female koalas can whistle", "Answer": "False"],
        ["Question": "Blue whales are technically whales", "Answer": "True"],
        ["Question": "Camels are cannibalistic", "Answer": "False"],
        ["Question": "All ducks are birds", "Answer": "True"]
    ]
    */
    
    // The counter is the seconds to be used ni lightning mode
    // so that user could only have a certain seconds to answer a question
    var counter = 15
    // The variable to store the timer
    var timer: Timer? = nil
    

    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var resultField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var consoleField: UILabel!

    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load game start sound
        loadGameStartSound()
        
        // Set option buttons to rounded button
        answer1Button.layer.cornerRadius = 10.0
        answer2Button.layer.cornerRadius = 10.0
        answer3Button.layer.cornerRadius = 10.0
        answer4Button.layer.cornerRadius = 10.0
        playAgainButton.layer.cornerRadius = 5.0
        nextQuestionButton.layer.cornerRadius = 5.0
        
        // Start game and play the game start sound
        playGameStartSound()
        displayQuestion()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The function to update the lightning mode counter
    func updateCounter() {
        if counter > 0 {
            consoleField.text = "\(counter) seconds left..."
            counter -= 1
        } else {
            timeUp()
        }
    }
    
    // funnction to handle time up situation in lightning mode
    func timeUp() {
        // Stop the timer
        timer?.invalidate()
        
        // Increment the questions asked counter
        questionsAsked += 1
        
        // Disable all options button
        answer1Button.isUserInteractionEnabled = false
        answer2Button.isUserInteractionEnabled = false
        answer3Button.isUserInteractionEnabled = false
        answer4Button.isUserInteractionEnabled = false
        answer1Button.alpha = 0.5
        answer2Button.alpha = 0.5
        answer3Button.alpha = 0.5
        answer4Button.alpha = 0.5
        
        // Show time up message
        consoleField.text = "Time up!"
        
        // remove the selected question from the question set
        questionsProvider.questions.remove(at: indexOfSelectedQuestion)
        
        // Show the next question button
        nextQuestionButton.isHidden = false
    }
    
    // function to display a question
    func displayQuestion() {
        // Brighten all option buttons
        answer1Button.alpha = 1
        answer2Button.alpha = 1
        answer3Button.alpha = 1
        answer4Button.alpha = 1
        
        // Enable all option buttons
        answer1Button.isUserInteractionEnabled = true
        answer2Button.isUserInteractionEnabled = true
        answer3Button.isUserInteractionEnabled = true
        answer4Button.isUserInteractionEnabled = true
        
        // Load a random question from the question set
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questionsProvider.questions.count)
        let selectedQuestion = questionsProvider.questions[indexOfSelectedQuestion]
        questionField.text = selectedQuestion.question
        
        // Show the option buttons according to the number of options
        // Update the text of the option button to respective answer
        // The app could handle questions with 3 or 4 options
        // Remark: I could not understand the requirement of the project that
        // "Implement a feature so that the app can neatly display a mix of 3-option questions as well as 4-option questions. Inactive buttons should be spaced or resized appropriately, not simply hidden."
        // Thus, I try as far as I can to demostrate a functional app.
        switch selectedQuestion.options.count {
        case 3:
            answer1Button.isHidden = false
            answer2Button.isHidden = false
            answer3Button.isHidden = false
            answer4Button.isHidden = true
            
            answer1Button.setTitle(selectedQuestion.options[0], for: .normal)
            answer2Button.setTitle(selectedQuestion.options[1], for: .normal)
            answer3Button.setTitle(selectedQuestion.options[2], for: .normal)
        case 4:
            answer1Button.isHidden = false
            answer2Button.isHidden = false
            answer3Button.isHidden = false
            answer4Button.isHidden = false
            
            answer1Button.setTitle(selectedQuestion.options[0], for: .normal)
            answer2Button.setTitle(selectedQuestion.options[1], for: .normal)
            answer3Button.setTitle(selectedQuestion.options[2], for: .normal)
            answer4Button.setTitle(selectedQuestion.options[3], for: .normal)
        default: print("Unexpected error!")
        }
        
        // Hide the play again button
        playAgainButton.isHidden = true
        
        // Hide the next question button
        nextQuestionButton.isHidden = true
        
        // Hide the result label
        resultField.isHidden = true
        
        // Display current score
        consoleField.isHidden = false
        
        // Start a timer for the lightning mode
        // reset the counter to 15 seconds every time
        counter = 15
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        playTimerSound()
    }
    
    func displayScore() {
        // Hide the result label
        resultField.isHidden = true
        
        // Hide the console label
        consoleField.isHidden = true
        
        // Hide the next question button
        nextQuestionButton.isHidden = true
        
        // Hide the answer buttons
        answer1Button.isHidden = true
        answer2Button.isHidden = true
        answer3Button.isHidden = true
        answer4Button.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        // Print the score to the view
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
        // Play game end sound
        playGameEndSound()
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Stop the timer
        timer?.invalidate()
        
        // Increment the questions asked counter
        questionsAsked += 1
        
        // Disable all options button
        answer1Button.isUserInteractionEnabled = false
        answer2Button.isUserInteractionEnabled = false
        answer3Button.isUserInteractionEnabled = false
        answer4Button.isUserInteractionEnabled = false
        
        // Load the selected question and find out the answer from the model
        let selectedQuestion = questionsProvider.questions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestion.correctAnswer
        
        // Dim color of option button not selected
        switch sender {
        case answer1Button:
            answer2Button.alpha = 0.5
            answer3Button.alpha = 0.5
            answer4Button.alpha = 0.5
        case answer2Button:
            answer1Button.alpha = 0.5
            answer3Button.alpha = 0.5
            answer4Button.alpha = 0.5
        case answer3Button:
            answer1Button.alpha = 0.5
            answer2Button.alpha = 0.5
            answer4Button.alpha = 0.5
        case answer4Button:
            answer1Button.alpha = 0.5
            answer2Button.alpha = 0.5
            answer3Button.alpha = 0.5
        default: print("Unexpected error!")
        }
        
        // To decide if the answer is right or wrong
        // Show the correct answer if the chosen option is wrong
        if (sender === answer1Button &&  correctAnswer == correctAnswer) || (sender === answer2Button && correctAnswer == 2) || (sender === answer3Button && correctAnswer == 3) || (sender === answer4Button && correctAnswer == 4) {
            correctQuestions += 1
            resultField.text = "Correct!"
            resultField.textColor = UIColor.cyan
            consoleField.text = "You got \(correctQuestions) out of \(questionsPerRound) correct!"
            playCorrectAnswerSound()
        } else {
            resultField.text = "Sorry, that's not it."
            resultField.textColor = UIColor.orange
            consoleField.text = "The correct answer is \(selectedQuestion.options[correctAnswer-1])"
            consoleField.isHidden = false
            playWrongAnswerSound()
        }
        
        // Hide the result label
        resultField.isHidden = false
        
        // remove the selected question from the question set
        questionsProvider.questions.remove(at: indexOfSelectedQuestion)
        
        /*
        // Use next question button as shown in the mock up instead of waiting for delay seconds
        loadNextRoundWithDelay(seconds: 2)
        */
        
        // Show the next question button
        nextQuestionButton.isHidden = false
 
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Reset game parameters
        questionsAsked = 0
        correctQuestions = 0
        
        // reset the questions set
        questionsProvider = QuestionsProvider()
        
        // Open a new round
        nextRound()
    }
    
    @IBAction func nextQuestion() {
        nextRound()
    }

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // function to load game start sound
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    // function to play game start sound
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    
    // function to play Game End Sound
    func playGameEndSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "applause2_x", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
        AudioServicesPlaySystemSound(gameSound)
    }
    
    
    // function to play sound when answering questioning during lightning mode
    func playTimerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "timer", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
        AudioServicesPlaySystemSound(gameSound)
    }
    
    
    // function to play sound when correct answer chosen
    func playCorrectAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "doorbell_x", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
        AudioServicesPlaySystemSound(gameSound)
    }
    
    // function to play sound when wrong answer chosen
    func playWrongAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "blip", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
        AudioServicesPlaySystemSound(gameSound)
    }
}

