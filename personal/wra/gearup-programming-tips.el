(setq gearup-programming-tips nil)

;; general
(setq gearup-programming-tips 
  (append gearup-programming-tips
    '("Always do ONE thing at a time."
      "Implement only what you need -- Follow YAGNI principle (You Ain't Gonna Need It)."
      "Apply DEMETERS LAW where feasable: \"Only use fields and methods of direct neighbor objects.\""
      "DEMETERS LAW improves separation of concerns at the implementation level.")))


;; refactoring
(setq gearup-programming-tips 
  (append gearup-programming-tips
    '("Break dependencies for testing by faking collaborator objects, eg by EXTRACT INTERFACE or EXTRACT IMPLEMENTER."
      "NULL OBJECT PATTERN can replace frequent null checks and exception handling."
      "Rule of thumb: If classes have >= 50 methods break them up."
      "Identify Responsibilities: Private methods can often be reduced by extracting them to another class."
      "FEATURE SKETCHES [LEGACY CODE] can help identify responsibilities and splitting up classes."
      "The INTERFACE SEGREGATION PRINCIPLE helps improving information hiding and separation of concerns at the interface level."
      "The INTERFACE SEGREGATION PRINCIPLE can be a starting point for splitting up large classes.")))
      
      
      