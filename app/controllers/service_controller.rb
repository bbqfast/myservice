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

def create
  cust=Customer.find(:all, :conditions => [ "name = ?", params[:other][:customer]  ])
  
  if checkempty(params[:service][:name], 'name')
    return
  end
  if (params[:service][:name] == '')
    xx
    @@display['name']='required'
    redirect_to :controller=>'service', :action=>'new', notice: 'Invalid entries' 
    return
  end
  
  if (cust.first.nil?)
    cust = Customer.new(:name => params[:other][:customer])
    cust.save
    id=cust.id
    #xxx
  else
    id=cust.id
  end
  
  params[:service][:customer]=id
  
  @service = Service.new(params[:service])

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