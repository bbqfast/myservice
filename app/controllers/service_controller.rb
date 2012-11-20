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
  fill_dropdown
  @form_action = 'create'
  @service = Service.new
  @service.customer = Customer.new
  @service.owner = Owner.new
  @service.submitter = Submitter.new
  @submit_tag = 'Create new service'
  
  respond_to do |format|
    format.html # index.html.erb
    #format.json { render json: @services }
  end  
end

def update
  fill_dropdown
  @form_action = 'change'
  @submit_tag = 'Update service'
  @service = Service.find(params[:id])
  @comments = Comment.find(:all, :conditions => [ "service_id = ?", params[:id] ])

  respond_to do |format|
    format.html # index.html.erb
  end  
end

def change
  @service = Service.find(params[:id])
  
  update_service_users

  if(!@service.update_attributes(params[:service]))
    error = 'update failed'
  else
    @service.comments.create(params[:comment]) # add comments
  end
 
  
  respond_to do |format|
    if !error
      format.html { redirect_to :controller=>'service', :action=>'list', notice: 'Service was updated created.' }
      format.json { render json: @service, status: :created, location: @service }
    else
      format.html { redirect_to :controller=>'service', :action=>'list', notice: error}
      format.json { render json: @service.errors, status: :unprocessable_entity }
    end
  end #do  
end

def delete
  @service = Service.find(params[:id])
  @service.destroy
  redirect_to :controller=>'service', :action=>'list', notice: params[:id].to_s + ' Deleted'
end


def fill_dropdown # populate drop downs
  @customers = Customer.all
  @submitters = Submitter.all
  @owners = Owner.all
  @service_types = ServiceType.all
  
  @service_types.unshift(Customer.new(:id => 0, :name => 'choose service type'))
  @customers.unshift(Customer.new(:id => 0, :name => 'choose'))
  @owners.unshift(Owner.new(:id => 0, :name => 'choose'))
  @submitters.unshift(Submitter.new(:id => 0, :name => 'choose'))
  
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

  update_service_users
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
      format.html { redirect_to :controller=>'service', :action=>'list', notice: 'Service was successfully created.' }
      # format.json { render json: @service, status: :created, location: @service }
    else
      format.html { redirect_to :controller=>'service', :action=>'list', notice: 'Create service Error'}
      # format.json { render json: @service.errors, status: :unprocessable_entity }
    end
  end
  
end

def update_service_users
  params[:service][:service_type_id]=params[:service_type].to_i
  
  id=find_or_create(Customer, params[:other][:customer])
  params[:service][:customer]=id

  id=find_or_create(Owner, params[:other][:owner])
  params[:service][:owner]=id

  id=find_or_create(Submitter, params[:other][:submitter])
  params[:service][:submitter]=id

  # convert to date before saving
  #params[:service][:completion_date] = params[:service][:completion_date].to_date
  params[:service][:completion_date] = DateTime.strptime(params[:service][:completion_date], '%m/%d/%Y')
end

def testdata
  create_if_not_exists(Customer, :name, 'philip' )
  create_if_not_exists(Customer, :name, 'alan' )
  create_if_not_exists(Owner, :name, 'jonathan' )
  create_if_not_exists(Owner, :name, 'andrew' )
  create_if_not_exists(Submitter, :name, 'Maryann' )
  create_if_not_exists(Submitter, :name, 'Katrina' )

  #create_if_not_exists(Customer, :name, 'alex', Customer.new(:name => 'alex') )
  create_if_not_exists_generic(Company, [{:name => 'Self-employed'},{:note => 'mynote'}])
  create_if_not_exists_generic(Company, [{:name => 'Home Depot'},{:note => 'mynote'}])
  create_if_not_exists_generic(Company, [{:name => 'Quick Lube'},{:note => 'mynote'}])
  create_if_not_exists_generic(Company, [{:name => 'Generic heater'},{:note => 'mynote'}])
  
  create_if_not_exists_generic(ServiceType, [{:name => 'Painting'},{:note => 'mynote'}])
  create_if_not_exists_generic(ServiceType, [{:name => 'Roofing'},{:note => 'mynote'}])
  create_if_not_exists_generic(ServiceType, [{:name => 'Disposal'},{:note => 'mynote'}])
  create_if_not_exists_generic(ServiceType, [{:name => 'Computer help'},{:note => 'mynote'}])
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

  # mail test
  #Gmail.email('bbqnow@gmail.com').deliver

  respond_to do |format|
    format.html # index.html.erb
    format.json { render json: @services }
  end
end
   
end #class