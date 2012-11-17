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
  @owners = Owner.all
  @service_types = ServiceType.all
  
  @service_types.unshift(Customer.new(:id => 0, :name => 'choose service type'))
  @customers.unshift(Customer.new(:id => 0, :name => 'choose'))
  @owners.unshift(Owner.new(:id => 0, :name => 'choose'))
  @submitters.unshift(Submitter.new(:id => 0, :name => 'choose'))
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

  id=find_or_create(Owner, params[:other][:owner])
  params[:service][:owner]=id

  id=find_or_create(Submitter, params[:other][:submitter])
  params[:service][:submitter]=id
  
  #params[:service][:comments]=params[:comment]
  
  @service = Service.new(params[:service])
      #@service.comments.create(:comment_text => 'my comment')
  
  if @service.save
    @service.comments.create(params[:comment])
  else
    error='unable to save service'
  end

  respond_to do |format|
    if !error
      format.html { redirect_to :controller=>'service', :action=>'list', notice: 'Post was successfully created.' }
      # format.json { render json: @post, status: :created, location: @post }
    else
      format.html { redirect_to :controller=>'service', :action=>'list', notice: 'Create service Error'}
      # format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end
  
end

def testdata
  create_if_not_exists(Customer, :name, 'philip' )
  create_if_not_exists(Customer, :name, 'alan' )
  #create_if_not_exists(Customer, :name, 'alex', Customer.new(:name => 'alex') )
  create_if_not_exists_generic(Company, [{:name => 'abc'},{:note => 'mynote'}])
  create_if_not_exists_generic(Company, [{:name => 'Home Depot'},{:note => 'mynote'}])
  create_if_not_exists_generic(Company, [{:name => 'Quick Lube'},{:note => 'mynote'}])
  create_if_not_exists_generic(Company, [{:name => 'Generic heater'},{:note => 'mynote'}])
  create_if_not_exists_generic(ServiceType, [{:name => 'Painting'},{:note => 'mynote'}])
  create_if_not_exists_generic(ServiceType, [{:name => 'Roofing'},{:note => 'mynote'}])
  create_if_not_exists_generic(ServiceType, [{:name => 'Disposal'},{:note => 'mynote'}])
  #@c.save
end

def create_if_not_exists(cls, symbol, val)
  if (cls.exists?(symbol => val))
    return
  end
  
  obj = cls.new(symbol => val)
  #cust = cls.new(symbol => val)
  obj.save
end

def create_if_not_exists_generic(cls, pair_list)
  if (cls.exists?(pair_list.first))
    return
  end
  
  pair_list = pair_list.inject(:merge)
  obj = cls.new(pair_list)
  #cust = cls.new(symbol => val)
  obj.save
  pair_list.first
end

def list
  @services = Service.all

  respond_to do |format|
    format.html # index.html.erb
    format.json { render json: @services }
  end
end
   
end #class