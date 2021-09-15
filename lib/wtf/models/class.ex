defmodule WTF.Class do
    defstruct(id: nil, class_name: "", school_id: nil)

    def update(id, class_name) do
        
    end

    def create(class_name) do
        
    end

    def delete(id) do
        
    end

    def to_struct([[id, class_name, school_id]]) do
        %School{id: id, class_name: class_name, school_id: school_id}
    end
end