(setq gearup-programming-tips nil)

;; general
(setq gearup-programming-tips 
  (append gearup-programming-tips
    '("Always do ONE thing at a time."
      "Implement only what you need -- Follow YAGNI principle (You Ain't Gonna Need It)."
      "Apply DEMETERS LAW where feasable: \"Only use fields and methods of direct neighbor objects.\""
      "DEMETERS LAW improves separation of concerns at the implementation level."
      "Make dependencies explicit using Constructor, Interface or Setter (DEPENDENCY) INJECTION."
      "Keep GLUE CODE (the logic of constructing objects from their dependencies) out of BUSINESS LOGIC CODE classes."
      "Don't use SINGLETON or BORG PATTERN to implement application scope objects. Use real objects and pass them around with DEPENDENCY INJECTION."
      "If you seperate GLUE CODE from BUISNESS LOGIC, your busisness logic classes will be easier to instanciate in unit tests.")))


;; refactoring
(setq gearup-programming-tips 
  (append gearup-programming-tips
    '("Break dependencies for testing by faking collaborator objects, eg by EXTRACT INTERFACE or EXTRACT IMPLEMENTER."
      "NULL OBJECT PATTERN can replace frequent null checks and exception handling."
      "Rule of thumb: If classes have >= 50 methods break them up."
      "Identify Responsibilities: Private methods can often be reduced by extracting them to another class."
      "FEATURE SKETCHES [LEGACY CODE] can help identify responsibilities and splitting up classes."
      "The INTERFACE SEGREGATION PRINCIPLE helps improving information hiding and separation of concerns at the interface level."
      "The INTERFACE SEGREGATION PRINCIPLE can be a starting point for splitting up large classes."
      "Instance methods that don't use private members can be made static for testing.")))
      
      
      