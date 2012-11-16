class ServiceController < ApplicationController
@@display={}

# TEST for find & exists
def testfind
  myname='Alan'
  cust=Customer.find(:all, :conditions => [ "name = ?", myname])
  #cust=Customer.where(:all, :conditions => [ "name = ?", 'Alan'])
  # if (cust.first.nil?)
  if (!Customer.exists?(:name => myname))
    params[:notice]='not found'
  else
    params[:notice]=cust[0].id
  end
end

def new
  @customers = Customer.all
  @submitters = Submitter.all
  
  @customers.unshift(Customer.new(:id => 0, :name => 'choose'))
  #@display={}
  #@display[:name]='inv'
  
  respond_to do |format|
    format.html # index.html.erb
    #format.json { render json: @posts }
  end  
end

def checkempty(entry, label)
  if (entry == '')
    @@display[label]='required'
    redirect_to :controller=>'service', :action=>'new', notice: 'Invalid entries' 
    return true
  end  
end

def find_or_create(obj, match)
  cust=obj.find(:all, :conditions => [ "name = ?", match  ])
  
  if (cust.first.nil?)
    cust = obj.new(:name => match)
    cust.save
    id=cust.id
    return cust
  else
    id=cust[0].id
    return cust[0]
  end
end

def create
  #if checkempty(params[:service][:name], :name)
    #@@display[:name]='required'
   # return
  #end
  if (params[:service][:name] == '')
    @@display[:name]='required'
    redirect_to :controller=>'service', :action=>'new', notice: 'Invalid entries' 
    return
  end
  if (params[:other][:customer] == '')
    @@display[:name]='required'
    redirect_to :controller=>'service', :action=>'new', notice: 'Invalid entries' 
    return
  end

  id=find_or_create(Customer, params[:other][:customer])
  
  params[:service][:customer]=id
  x={}
  x[:name]=params[:service][:name]
  x[:description]='desc'
  x[:customer]=params[:service][:customer]
  
  @service = Service.new(x)

  respond_to do |format|
    if @service.save
      format.html { redirect_to :controller=>'login', :action=>'list', notice: 'Post was successfully created.' }
      # format.json { render json: @post, status: :created, location: @post }
    else
      format.html { redirect_to :controller=>'login', :action=>'list', notice: 'Create service Error'}
      # format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end
  
end

def testdata
  @c = Customer.create(:name => 'Philip')
  @c = Customer.create(:name => 'Alan')
  @c.save
end

def list
  @services = Service.all

  respond_to do |format|
    format.html # index.html.erb
    format.json { render json: @services }
  end
end
  

   
end #class