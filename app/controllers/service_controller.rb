class ServiceController < ApplicationController

def new
  @customers = Customer.all
  @submitters = Submitter.all
  
    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @posts }
    end  
end

def testdata
  @c = Customer.create(:name => 'April')
  @c = Customer.create(:name => 'John')
  @c.save
end
  

   
end 