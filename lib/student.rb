class Student
  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
    def initialize(name, grade, id=nil)
      @name = name
      @grade = grade
      @nil = nil
    end

    def self.create_table
      sq1 = "CREATE TABLE students ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, grade INTEGER);"
      DB[:conn].execute(sq1)
    end
  
    def self.drop_table
      sq1 = "DROP TABLE students;"
      DB[:conn].execute(sq1)
    end

    def save
      sq1 = "INSERT INTO students (name, grade) VALUES (?, ?);"
      DB[:conn].execute(sq1, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end

    def self.create(student)
      student1 = Student.new(student[:name], student[:grade])
      student1.save
      student1
    end
end
