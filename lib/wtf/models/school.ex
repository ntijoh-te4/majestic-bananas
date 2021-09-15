defmodule WTF.School do
    defstruct(id: nil, school_name: "")

    def update(id, school_name) do
        
    end

    def create(school_name) do
        
    end

    def delete(id) do
        
    end

    def to_struct([[id, school_name]]) do
        %School{id: id, school_name: school_name}
    end

end