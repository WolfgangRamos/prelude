(setq gearup-programming-tips nil)

;; general
(setq gearup-programming-tips 
  (append gearup-programming-tips
    '("Always do ONE thing at a time."
      "Implement only what you need -- Follow YAGNI principle (You Ain't Gonna Need It).")))


;; refactoring
(setq gearup-programming-tips 
  (append gearup-programming-tips
    '("Break dependencies for testing by faking collaborator objects, eg by EXTRACT INTERFACE or EXTRACT IMPLEMENTER."
      "NULL OBJECT PATTERN can replace frequent null checks and exception handling.")))