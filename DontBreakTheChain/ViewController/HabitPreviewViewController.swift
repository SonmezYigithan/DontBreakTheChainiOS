//
//  HabitPreviewViewController.swift
//  DontBreakTheChain
//
//  Created by Yiğithan Sönmez on 19.12.2023.
//

import UIKit

class HabitPreviewViewController: UIViewController {
    
    let streakView: UIView = {
        let streakView = UIView()
        streakView.layer.cornerRadius = 20
        streakView.backgroundColor = .secondarySystemBackground
        streakView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8 // Adjust the spacing as needed
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Current Streak"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "2 Days"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        streakView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: streakView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: streakView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: streakView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: streakView.bottomAnchor, constant: -16),
        ])
        
        return streakView
    }()
    
    let habitProgressView: UIView = {
        let habitProgressView = UIView()
        habitProgressView.layer.cornerRadius = 20
        habitProgressView.backgroundColor = .secondarySystemBackground
        habitProgressView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8 // Adjust the spacing as needed
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return habitProgressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(streakView)
        view.addSubview(habitProgressView)
        
        applyConstraints()
        createCalendar()
    }
    
    func configure(with habit: Habit){
        title = habit.habitName
    }
    
    func createCalendar(){
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.backgroundColor = .secondarySystemBackground
        calendarView.layer.cornerRadius = 20
        calendarView.delegate = self
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            calendarView.heightAnchor.constraint(equalToConstant: 450),
            calendarView.topAnchor.constraint(equalTo: habitProgressView.bottomAnchor, constant: 20)
        ])
    }
    
    func applyConstraints(){
        let cardViewConstraints = [
            streakView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            streakView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            streakView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            streakView.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let habitProgressViewConstraints = [
            habitProgressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            habitProgressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            habitProgressView.topAnchor.constraint(equalTo: streakView.bottomAnchor, constant: 20),
            habitProgressView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        NSLayoutConstraint.activate(habitProgressViewConstraints)
        NSLayoutConstraint.activate(cardViewConstraints)
    }
}

extension HabitPreviewViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        
    }
    
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        var testDate = DateComponents()
        testDate.day = 12
        testDate.month = 12
        testDate.year = 2023
        print("DateComp: \(dateComponents)\ntestDate: \(testDate)")
        print(testDate)
        
        var decoration = UICalendarView.Decoration.image(UIImage(systemName: "circle"),color: .systemGreen,size: .large)
        
        if(dateComponents.day == testDate.day && dateComponents.month == testDate.month){
            print("YESSS")
            decoration = UICalendarView.Decoration.image(UIImage(systemName: "checkmark.circle.fill"),color: .systemGreen,size: .large)
        }
        else{
            decoration = UICalendarView.Decoration.image(UIImage(systemName: "x.circle"),color: .systemRed, size: .large)
        }
        
        return decoration
    }
    
    
}
