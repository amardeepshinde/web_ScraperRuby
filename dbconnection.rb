require 'open-uri'
require 'nokogiri'


require 'sqlite3'
def dataconnection
    
    $db = SQLite3::Database.open "arar.db"
    $db.execute "CREATE TABLE IF NOT EXISTS RECIPECATEGORY(Id INTEGER PRIMARY KEY, 
        name TEXT, links INt)"
     $db.execute "CREATE TABLE IF NOT EXISTS RecipeSubCategory(Id INTEGER, 
        name TEXT, links INt)"
    $db.execute "CREATE TABLE IF NOT EXISTS SubSubCategory(Id INTEGER , 
        name TEXT, links TEXT)"
    $db.execute "CREATE TABLE IF NOT EXISTS Descripation(Id INTEGER , 
        desc TEXT )"
    yield 

    $db.execute "select * from  RECIPECATEGORY "
    $db.execute "select * from  RecipeSubCategory "
    $db.execute "select * from  SubSubCategory "
    $db.execute "select * from  Descripation "
    

        
rescue SQLite3::Exception => e 
    
    puts "Exception occurred"
    puts e
    
ensure
    $db.close if $db
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
            
           
            dataconnection { 
                $db.execute('INSERT INTO RECIPECATEGORY (name , links ) VALUES (? , ? )', @names ,  @links)
              }
  
            end
          
	
	end
end

obj1 = RecipeCategory. new
obj1.get_categorys
  





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
            dataconnection { 
                $db.execute('INSERT INTO RecipeSubCategory (name , links ) VALUES (? , ? )', @names ,  @links)
              }
        

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
            dataconnection { 
                $db.execute('INSERT INTO SubSubCategory (name , links ) VALUES (? , ? )', @names ,  @links)
              }
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
            dataconnection { 
                $db.execute('INSERT INTO Descripation (desc  ) VALUES ( ? )', @descriptions )
              }
           
            puts @descriptions  

            end
            
	
	end
end

dec = Descripation. new
dec.descripations "https://www.allrecipes.com/recipe/220123/black-bean-breakfast-bowl/"






