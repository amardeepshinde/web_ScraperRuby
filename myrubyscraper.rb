
require 'open-uri'
require 'nokogiri'
require "dbi"


begin
   
   dbh = DBI.connect("DBI:Mysql:TESTDB:localhost", "root", "root")



   dbh.do("CREATE TABLE RECIPECATEGORY (
  NAME  CHAR(20) NOT NULL,
   LINK CHAR(20))" );

   dbh.do("CREATE TABLE RECIPESUBCATEGORY (
    NAME  CHAR(20) NOT NULL,
     LINK CHAR(20) )" );

        
   dbh.do("CREATE TABLE SUBSUBCATEGORY (
    NAME  CHAR(20) NOT NULL,
     LINK CHAR(20) )" );

     dbh.do("CREATE TABLE DESCRIPATION (
        NAME  CHAR(20) NOT NULL)" );
    

        pst = con.prepare "INSERT INTO RECIPECATEGORY(Nam, LINK) VALUES(? , ?)"
        pst.execute name
            
       puts "Record has been created"
       dbh.commit
    rescue DBI::DatabaseError => e
       puts "An error occurred"
       puts "Error code:    #{e.err}"
       puts "Error message: #{e.errstr}"
       dbh.rollback
    ensure
       
       dbh.disconnect if dbh
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
            @names = "#{li.css('span').text}"
           
            puts @names  

            end
            
	
	end
end

dec = Descripation. new
dec.descripations "https://www.allrecipes.com/recipe/220123/black-bean-breakfast-bowl/"


