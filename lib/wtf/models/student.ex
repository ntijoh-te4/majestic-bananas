defmodule WTF.Student do
    defstruct(id: nil, student_name: "")

    def update(id, student_name, url) do
        
    end

    def create(student_name, url) do
        
    end

    def delete(id) do
        
    end

    def to_struct([[id, school_name]]) do
        %School{id: id, student_name: student_name, school_id: school_id, class_id: class_id}
    end
end