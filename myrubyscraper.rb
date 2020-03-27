
require 'open-uri'
require 'nokogiri'
require 'sqlite3'

begin
    
    db = SQLite3::Database.open "my.db"
    db.execute "CREATE TABLE RECIPECATEGORY(Id INTEGER PRIMARY KEY, 
        Name TEXT , link Text)"
    db.execute "CREATE TABLE RecipeSubCategory(Id INTEGER , 
      Name TEXT , link Text)"
    db.execute "CREATE TABLE SubSubCategory(Id INTEGER , 
        Name TEXT , link Text)"
    db.execute "CREATE TABLE Descripation(Id INTEGER , 
        desc TEXT )"
    
         db.prepare( "INSERT INTO RECIPECATEGORY(Name , link ) VALUES(? , ?)" ) do |stmt|
    1000.times do
      stmt.execute do |get_categorys|
        ...
      end
    end
  end

  

    
rescue SQLite3::Exception => e 
    
    puts "Exception occurred"
    puts e
    
ensure
    db.close if db
end




class RecipeCategory
    attr_accessor :name, :link
    def initilize(url)
        @url = url
        
    end

    def get_categorys
        base_url = "https://www.allrecipes.com/"
        html = open(base_url)
        document = Nokogiri::HTML(html)
        @nodes = document
        category_page = @nodes

		
			category_page.css('#insideScroll ul li').each do |li|
            @names = "#{li.css('span').text}"
            @links = "#{li.css('a').attribute 'href'}" 
            puts @names

            end
            
	
	end
end

obj1 = RecipeCategory. new
obj1.get_categorys


# subcatogary
class RecipeSubCategory
    def initilize(url)
        @url = url
        
    end

    def get_sub_categorys(sub_url)
        
        html = open(sub_url)
        document = Nokogiri::HTML(html)
        @nodes = document
        sub_category_page = @nodes

		
			sub_category_page.css('#insideScroll ul li').each do |li|
            @names = "#{li.css('span').text}"
            @links = "#{li.css('a').attribute 'href'}" 
            puts @names

            end
            
	
	end
end

obj = RecipeSubCategory. new
obj.get_sub_categorys "https://www.allrecipes.com/recipes/83/everyday-cooking/convenience-cooking/'"



class SubSubCategory
    def initilize(url)
        @url = url
        
    end

    def sub_sub_categorys(sub_url)
        
        html = open(sub_url)
        document = Nokogiri::HTML(html)
        @nodes = document
        sub_category_page = @nodes

		
			sub_category_page.css('#insideScroll ul li').each do |li|
            @names = "#{li.css('span').text}"
            @links = "#{li.css('a').attribute 'href'}" 
            puts @names  

            end
            
	
	end
end

objsub = SubSubCategory. new
objsub.sub_sub_categorys "https://www.allrecipes.com/recipes/1849/everyday-cooking/convenience-cooking/canned-food/"





class Descripation
    def initilize(url)
        @url = url
        
    end

    def descripations(sub_url)
        
        html = open(sub_url)
        document = Nokogiri::HTML(html)
        @nodes = document
        descripation_page = @nodes

		
        descripation_page.css('#insideScroll ul li').each do |li|
            @descriptions = "#{li.css('span').text}"
           
            puts @descriptions  

            end
            
	
	end
end

dec = Descripation. new
dec.descripations "https://www.allrecipes.com/recipe/220123/black-bean-breakfast-bowl/"


